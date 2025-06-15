#!/usr/bin/env bash

set -e

# Settings
PATCH_REPO_URL="https://github.com/devnoname120/kernelsu-coccinelle.git"
PATCH_DIR_NAME="kernelsu-coccinelle"

# Usage control
if [[ -z "$1" ]]; then
  echo "Usage: bash autopatch.sh <kernel-source-path> [patch1.cocci patch2.cocci ...]"
  exit 1
fi

KERNEL_DIR="$1"
shift

# Is Coccinelle installed?
if ! command -v spatch &>/dev/null; then
  echo "[!] Coccinelle (spatch) is not installed."
  echo "Please install it first:"
  echo "  https://coccinelle.gitlabpages.inria.fr/website/download.html"
  echo ""
  echo "Example (Debian/Ubuntu):"
  echo "  sudo apt update && sudo apt install coccinelle"
  exit 2
fi

# Clone or update patch repository
if [[ ! -d "$PATCH_DIR_NAME" ]]; then
  echo "[+] Cloning patch repo: $PATCH_REPO_URL"
  git clone --depth=1 "$PATCH_REPO_URL" "$PATCH_DIR_NAME"
else
  echo "[=] Patch repo already exists: $PATCH_DIR_NAME"
  echo -e "[=] To update patches, run:\n  cd $PATCH_DIR_NAME && git pull"
fi

# Select patches to apply
if [[ "$#" -gt 0 ]]; then
  COCCI_LIST=("$@")
else
  COCCI_LIST=( "$PATCH_DIR_NAME"/*.cocci )
fi

echo "[+] Kernel source: $KERNEL_DIR"
echo "[+] Applying ${#COCCI_LIST[@]} patches..."

# Apply patches sequentially
for COCCI in "${COCCI_LIST[@]}"; do
  if [[ -f "$COCCI" ]]; then
    echo "[*] Applying $(basename "$COCCI") → recursively to $KERNEL_DIR"
    spatch --sp-file "$COCCI" --dir "$KERNEL_DIR" --in-place --linux-spacing
  else
    echo "[!] Patch not found: $COCCI"
  fi
done

echo "[✓] All patches applied successfully."
