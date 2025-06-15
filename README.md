# How to use

1) Install [Coccinelle](https://coccinelle.gitlabpages.inria.fr/website/download.html)
2) Run the following command to automatically apply all `.cocci` patches to your kernel source:
  ```sh
  curl -LSs "https://raw.githubusercontent.com/cvnertnc/kernelsu-coccinelle/main/autopatch.sh" | bash -s /path-to-kernel
  ```

  This will:

  Automatically clone the patch repository if not already present
  
  Apply all `.cocci` patches in the repository to the kernel source

  For example, if your kernel source is located at `~/dev/kernel_xiaomi_sm6150`, you can run:
  ```sh
  curl -LSs "https://raw.githubusercontent.com/cvnertnc/kernelsu-coccinelle/main/autopatch.sh" | bash -s ~/dev/kernel_xiaomi_sm6150
  ```

3. (Optional) To apply only specific `.cocci` patches:
  ```sh
  curl -LSs "https://raw.githubusercontent.com/cvnertnc/kernelsu-coccinelle/main/autopatch.sh" | bash -s /path-to-kernel vfs_read.cocci execveat.cocci
  ```

# How to learn Coccinelle

**Introduction**:
- EJCP 2018 conference:
  - [Introduction to Coccinelle Part 1](https://ejcp2018.sciencesconf.org/file/part1_lawall.pdf) ([archive](https://web.archive.org/web/20250518120845/https://ejcp2018.sciencesconf.org/file/part1_lawall.pdf))
  - [Introduction to Coccinelle Part 2](https://ejcp2018.sciencesconf.org/file/part2_lawall.pdf) ([archive](https://web.archive.org/web/20250518120846/https://ejcp2018.sciencesconf.org/file/part2_lawall.pdf))
- [Introduction to Semantic Patching of C programs with Coccinelle](https://web.archive.org/web/20250207160114if_/https://www.lrz.de/services/compute/courses/x_lecturenotes/hspc1w19.pdf#page=21)
- [Semantic patching with Coccinelle](https://lwn.net/Articles/315686/) (LWN)
- [Evolutionary development of a semantic patch using Coccinelle](https://lwn.net/Articles/380835/) (LWN)
- [Coccinelle for the newbie](https://home.regit.org/technical-articles/coccinelle-for-the-newbie/)
- [Advanced SmPL: Finding Missing IS ERR tests](https://coccinelle.gitlabpages.inria.fr/website/papers/cocciwk4_talk2.pdf) ([archive](https://web.archive.org/web/20250518130934/https://coccinelle.gitlabpages.inria.fr/website/papers/cocciwk4_talk2.pdf))


**Documentation**:
- Cookbook: https://github.com/kees/kernel-tools/tree/trunk/coccinelle
- Grammar reference: https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html ([pdf](https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.pdf))
- Standard isomorphisms: https://coccinelle.gitlabpages.inria.fr/website/standard.iso.html

**Examples**:
- https://github.com/groeck/coccinelle-patches
- https://coccinelle.gitlabpages.inria.fr/website/sp.html
- https://coccinelle.gitlabpages.inria.fr/website/rules/
- https://github.com/coccinelle/coccinellery
- More examples: https://github.com/search?q=language%3ASmPL&type=code

**Mailing lists**:
- cocci@systeme.lip6.fr (search the [[archives]](https://lore.kernel.org/cocci/))
- cocci@inria.fr (search the [[archives]](https://lore.kernel.org/cocci/))

**GitHub repository**: https://github.com/coccinelle/coccinelle
