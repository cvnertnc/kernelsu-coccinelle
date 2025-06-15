#!/usr/bin/env bash

set -e

# Settings
PATCH_REPO_URL="https://github.com/devnoname120/kernelsu-coccinelle.git"
PATCH_DIR_NAME="kernelsu-coccinelle"

# Usage control
if [[ -z "$1" ]]; then
  echo "Usage: bash autopatch.sh <kernel-source-path> [-o | -m]"
  echo "  -o  Apply each patch recursively to all files in the kernel source (default if no flag given)"
  echo "  -m  Apply each patch to its known target file only"
  exit 1
fi

KERNEL_DIR="$1"
MODE="$2"

# Check Coccinelle installation
if ! command -v spatch &>/dev/null; then
  echo "[!] Error: 'spatch' (Coccinelle) is not installed. Please install it first."
  exit 2
fi

# Clone patch repo if needed
if [[ ! -d "$PATCH_DIR_NAME" ]]; then
  echo "[+] Cloning patch repo: $PATCH_REPO_URL"
  git clone --depth=1 "$PATCH_REPO_URL" "$PATCH_DIR_NAME"
else
  echo "[=] Patch repo already exists: $PATCH_DIR_NAME"
fi

# Gather patches
COCCI_LIST=( "$PATCH_DIR_NAME"/*.cocci )

echo "[+] Kernel source: $KERNEL_DIR"
echo "[+] Applying ${#COCCI_LIST[@]} patches..."

# Define target map for -m mode
declare -A TARGET_MAP=(
  [devpts_get_priv.cocci]="fs/devpts/inode.c"
  [execveat.cocci]="fs/exec.c"
  [faccessat.cocci]="fs/open.c"
  [input_handle_event.cocci]="drivers/input/input.c"
  [path_umount.cocci]="fs/namespace.c"
  [vfs_read.cocci]="fs/read_write.c"
  [vfs_statx.cocci]="fs/stat.c"
)

# Apply patches
for COCCI in "${COCCI_LIST[@]}"; do
  PATCH_NAME=$(basename "$COCCI")

  if [[ "$MODE" == "-m" ]]; then
    TARGET_FILE="${TARGET_MAP[$PATCH_NAME]}"
    if [[ -n "$TARGET_FILE" ]]; then
      echo "[*] Applying $PATCH_NAME → $KERNEL_DIR/$TARGET_FILE"
      spatch --sp-file "$COCCI" --in-place --linux-spacing "$KERNEL_DIR/$TARGET_FILE"
    else
      echo "[!] No target defined for $PATCH_NAME, skipping."
    fi
  else
    echo "[*] Applying $PATCH_NAME → recursively to $KERNEL_DIR"
    spatch --sp-file "$COCCI" --dir "$KERNEL_DIR" --in-place --linux-spacing
  fi

done

echo "[✓] All patches applied successfully."
