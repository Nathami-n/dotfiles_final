# My linux dot files

<!--toc:start-->
- [My linux dot files](#my-linux-dot-files)
  - [Quick Start](#quick-start)
    - [Clone the repository](#clone-the-repository)
    - [Install GNU Stow](#install-gnu-stow)
      - [Ubuntu/Debian](#ubuntudebian)
      - [macOS(Homebrew)](#macoshomebrew)
      - [Arch Linux](#arch-linux)
      - [Stow your configs](#stow-your-configs)
<!--toc:end-->

These use **GNU Stow** for easy symlink management.

---

## Quick Start

### Clone the repository

```bash
git clone https://github.com/Nathami-n/dotfiles_final ~/.dotfiles
cd ~/.dotfiles
```

---

### Install GNU Stow

If you do not have it installed already

#### Ubuntu/Debian

```bash
sudo apt install stow
```

#### macOS(Homebrew)

```bash
brew install stow
```

#### Arch Linux

```bash
sudo pacman -S stow
```

#### Stow your configs

Each folder inside `~/.dotfiles` is a config group, and each file inside a folder is a config file e.g `nvim`, `zsh`, etc).

Run:

```bash
stow .
```

This will symlink all files into your `$HOME` directory

---

## ⚠️ Important: Change the Git Remote

If you’re cloning this repository to use as your own dotfiles setup, **make sure to change the remote URL** — otherwise you’ll accidentally push your changes to my repo.

After cloning, run:

```bash
git remote remove origin
git remote add origin git@github.com:<your-username>/dotfiles.git

