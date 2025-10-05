# =========================================================
# Powerlevel10k instant prompt (MUST stay at the very top)
# =========================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================================================
# History configuration
# =========================================================
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

# =========================================================
# Keybindings
# =========================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# =========================================================
#  aliases
# =========================================================

alias gcm="git commit -m"
alias ga="git add"
alias gp="git push"

# =========================================================
# Completion styles
# =========================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completions:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

alias ls='ls --color'

# =========================================================
# Zinit (plugin manager)
# =========================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# =========================================================
# Powerlevel10k theme
# =========================================================
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =========================================================
# Zsh plugins
# =========================================================
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# =========================================================
# Completions (only once)
# =========================================================
autoload -Uz compinit && compinit

# =========================================================
# FZF integration (must come after completions/plugins)
# =========================================================


[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# =========================================================
# Theme tweaks
# =========================================================
ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="mocha"

# =========================================================
# Paths / environment
# =========================================================
export NVM_DIR="$HOME/.nvm" 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# echo 'export PATH="$HOME/.fzf/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.fzf/bin:$PATH"


