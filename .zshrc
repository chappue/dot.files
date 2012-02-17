# .zshrc -*- Mode: shell-script; coding: euc-jp; -*-

#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# fandermental

  ###
  # like Emacs KeyBainding
  bindkey -e
  bindkey '^P' history-beginning-search-backward
  bindkey '^N' history-beginning-search-forward
  bindkey '^I' complete-word

  ###
  # history 
  HISTFILE=$HOME/.zsh-history
  HISTSIZE=100000
  SAVEHIST=100000

  ###
  # Prompt setting

  # use escape charcode
  unsetopt promptcr
  # color 
  local GRAY='%{[1;30m%}'
  local LIGHT_GRAY='%{[0;37m%}'
  local WHITE='%{[1;37m%}'
  local LIGHT_BLUE='%{[1;36m%}'
  local YELLOW='%{[1;33m%}'
  local PURPLE='%{[1;35m%}'
  local GREEN='%{[1;32m%}'
  local BLUE='%{[1;34m%}'
  local RED='%{[1;31m%}'
  local NC='%{[m%}'  #No Color

  case $TERM {
      xterm*)
      PROMPT=%(!,$RED,$GREEN)'%m-> '$NC
      RPROMPT=$LIGHT_BLUE'(%~)'$NC
      ;;
      screen*)
      PROMPT=%(!,$RED,$GREEN)'%m:'%{$WINDOW%}'-> '$NC
      RPROMPT=$LIGHT_BLUE'(%~)'$NC
      ;;
      dumb)
      PROMPT='dumb->'
      ;;
      *)
      PROMPT=$BLUE'%m -> '$NC
      RPROMPT=$BLUE'(%~)'$NC
      ;;
  }

#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# completion

  autoload -U compinit
  compinit -u

  # distinguish between capital letter and small letter
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  # color-coded
  zstyle ':completion:*' list-colors di=34 fi=0 ex=31 ln=35


#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# Zsh setting files in ZUSERDIR

export ZUSERDIR=$HOME/.zsh


#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# System specific environment

export HOSTNAME=`uname -n`

if [ -f $ZUSERDIR/zshrc.$HOSTNAME ]; then
  source $ZUSERDIR/zshrc.$HOSTNAME
fi


#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# load setting files

# zsh options
if [ -f $ZUSERDIR/zshoptions ]; then
  source $ZUSERDIR/zshoptions
fi

# completions command
if [ -f $ZUSERDIR/completions ]; then
  source $ZUSERDIR/completions
fi

# alias command
if [ -f $ZUSERDIR/aliases ]; then
  source $ZUSERDIR/aliases
fi

# functions
if [ -f $ZUSERDIR/functions ]; then
  source $ZUSERDIR/functions
fi

#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
# execute commands

## clean this display up
#clear

## wipe out dead screens
# if [ -f `where screen` ]; then
#   screen -q -wipe
#   if [ $TERM != "screen" ]; then
#     screen -U
#   fi
#fi

