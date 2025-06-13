# ~/.zshrc

# Enable colors
autoload -Uz colors && colors

# Enable completion
autoload -Uz compinit && compinit

#Color Variables (using ANSI Codes)
#put them in that exact format below so zsh can display them correctly !
VIOLET="%F{141}"
MINT_GREEN="%F{48}"
RESET="%f"


# Set prompt
#PROMPT="${VIOLET}${MINT_GREEN}%n ${RESET}%~ %# "

# History
HISTSIZE=20
SAVEHIST=20
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS       # Don’t record duplicate commands
setopt SHARE_HISTORY          # Share history across terminals
setopt PROMPT_SUBST

#Syntax Highlighter
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ls='exa --icons --group-directories-first -lh --git'

# --------------------------------------
#  LS_COLORS (fallback if not using exa)
# --------------------------------------

export LS_COLORS="di=1;36:fi=0:ln=1;35:pi=33:so=32:bd=33;1:cd=33;1:or=31;1:mi=5;37;41:ex=1;32"

eval "$(starship init zsh)"

