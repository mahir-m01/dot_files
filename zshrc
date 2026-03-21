# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Mysql path
export PATH="/usr/local/mysql/bin:$PATH"

# Aliases
alias mysqlstart='sudo /usr/local/mysql/support-files/mysql.server start'
alias mysqlstop='sudo /usr/local/mysql/support-files/mysql.server stop'

# Git aliases
alias gmain="switch_account ~/.ssh/id_rsa_main 'mahir-m01' 'mahirabd.official@gmail.com'"
alias gnst="switch_account ~/.ssh/id_rsa_nst 'mahir-nst' 'mahirabd.official+github@gmail.com'"

switch_account() {
  ssh-add -D
  ssh-add "$1"
  git config --global user.name "$2"
  git config --global user.email "$3"
  ssh -T git@github.com
}

# --- Plugins that must load before Oh My Zsh
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# --- Oh My Zsh load
plugins=(git)
source $ZSH/oh-my-zsh.sh

# --- Aliases that override OMZ defaults
if command -v eza &>/dev/null; then
  alias l="eza --icons=always"
  alias ls="eza --icons=always"
  alias ll="eza -lg --icons=always"
  alias la="eza -lag --icons=always"
  alias lt="eza -lTg --icons=always"
  alias lt2="eza -lTg --level=2 --icons=always"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lt4="eza -lTg --level=4 --icons=always"
  alias lta="eza -lTag --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
  alias lta4="eza -lTag --level=4 --icons=always"
fi

# --- Starship prompt init
eval "$(starship init zsh)"

# Added by Antigravity
export PATH="/Users/mahir/.antigravity/antigravity/bin:$PATH"
# Added by Antigravity
export PATH="/Users/mahir/.antigravity/antigravity/bin:$PATH"




# opencode
export PATH=/Users/mahir/.opencode/bin:$PATH
