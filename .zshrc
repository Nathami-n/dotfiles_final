# =========================================================

# FAST STARTUP (Powerlevel10k instant prompt)

# MUST be at the very top

# =========================================================

[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =========================================================

# History configuration

# =========================================================

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups 
hist_save_no_dups hist_ignore_dups hist_find_no_dups

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
alias ls='ls --color'

# =========================================================

# Completion styles (lightweight)

# =========================================================

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# IMPORTANT: fzf-tab preview made lightweight

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 $realpath | head -50'

# =========================================================

# Zinit (plugin manager)

# =========================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone [https://github.com/zdharma-continuum/zinit.git](https://github.com/zdharma-continuum/zinit.git) "$ZINIT_HOME"
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

# Reduce syntax highlighting cost

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# =========================================================

# Completions (cached)

# =========================================================

autoload -Uz compinit
compinit -C

# =========================================================

# FZF integration

# =========================================================

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

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

function y() {
local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
yazi "$@" --cwd-file="$tmp"
IFS= read -r -d '' cwd < "$tmp"
[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
rm -f -- "$tmp"
}

# =========================================================

# FZF path

# =========================================================

export PATH="$HOME/.fzf/bin:$PATH"
