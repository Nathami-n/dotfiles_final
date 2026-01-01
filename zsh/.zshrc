# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================================================
# FAST STARTUP (Powerlevel10k instant prompt)
# MUST be at the very top
# =========================================================

[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =========================================================
# OS detection (Linux / macOS)
# =========================================================

case "$(uname)" in
  Darwin) OS="macos" ;;
  Linux)  OS="linux" ;;
  *)      OS="other" ;;
esac

# =========================================================
# Homebrew (macOS only)
# Must be before plugins so PATH is correct
# =========================================================

if [[ "$OS" == "macos" ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# =========================================================
# History configuration
# =========================================================

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# =========================================================
# Keybindings (vi mode)
# =========================================================

bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -M viins '^F' autosuggest-accept
bindkey -M vicmd '^F' autosuggest-accept

# =========================================================
# Aliases
# =========================================================

alias gcm="git commit -m"
alias ga="git add"
alias gp="git push"

alias pr="cd ~/Desktop/projects/"
alias pc="cd ~/Desktop/clients/"
alias wf="cd ~/Desktop/work/frontend/"
alias wb="cd ~/Desktop/work/backend/"

# Portable ls color handling
if [[ "$OS" == "linux" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi

# =========================================================
# Completion styles (lightweight)
# =========================================================

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
[[ -z "$LS_COLORS" ]] && export LS_COLORS=""
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Lightweight fzf-tab preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 $realpath | head -50'

# =========================================================
# Zinit (plugin manager)
# =========================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && \
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# =========================================================
# Theme (Powerlevel10k)
# =========================================================

zinit ice depth=1
zinit light romkatv/powerlevel10k

# =========================================================
# Zsh plugins (ASYNC + NON-BLOCKING)
# =========================================================

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# =========================================================
# Plugin tuning (CPU SAVERS)
# =========================================================

ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# =========================================================
# Completions (cached)
# =========================================================

autoload -Uz compinit
compinit -C

# =========================================================
# FZF integration (Linux + macOS)
# =========================================================

if [[ "$OS" == "linux" ]]; then
  [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && \
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && \
    source /usr/share/doc/fzf/examples/completion.zsh
elif [[ "$OS" == "macos" ]] && command -v brew >/dev/null; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
fi

# =========================================================
# Paths / environment
# =========================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

export EDITOR="nvim"

# =========================================================
# Yazi file manager integration
# =========================================================

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# =========================================================
# FZF path (fallback)
# =========================================================

export PATH="$HOME/.fzf/bin:$PATH"
