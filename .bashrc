#
# George Papanikolaou 2013-2014
# Bash shell configuration. Supposed to work on both mac and linux
#

# Basic PATH modifications
if [[ `uname -s` == 'Darwin' ]]; then
  # god damn it apple
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/bin:$PATH
  MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

# General
export EDITOR=vim
export PAGER="less -iw"
export MANPAGER=$PAGER

# env handlers
eval "$(rbenv init -)"
eval "$(pyenv init -)"

# Globbing settings, try to emulate zsh. Maybe I should switch to it.
if [[ $(echo $BASH_VERSION | cut -d. -f1) -ge 4 ]]; then
  shopt -s globstar
  shopt -s nullglob
fi

# Completions
if [[ `uname -s` == 'Darwin' ]]; then
  for file in /usr/local/etc/bash_completion.d/*; do
    source $file;
  done
  complete -cf which
  complete -cf watch
  complete -cf sudo
  complete -cf type
  complete -cf man
else
  source ~/.dotfiles/bin/.git-completion.sh
fi

# Bash history modifications
shopt -s histappend
shopt -s cdspell
export HISTCONTROL=ignoreboth
export HISTSIZE=30000
export HISTIGNORE='ls:ll:la:[fb]g:clear:history:h'
export HISTTIMEFORMAT='%F %T '

# Don't mess with my prompt, virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Jupyter/ipython/itermplot
export MPLBACKEND="module://itermplot"
export ITERMPLOT=rv

# }------------------------------- PLATFORMS ---------------------------------{

if [[ `uname -s` == 'Darwin' ]]; then
  command -v sha1sum > /dev/null || alias sha1sum="shasum"
  ulimit -n 1024
else
  export CLICOLOR=1
  alias open="xdg-open"
  alias feh="feh -d -F"
  # pacman helpers
  alias aur="cower -s -c"
  alias paclog="gvim /var/log/pacman.log -c 'normal G'"
  alias paconf="gvim /etc/pacman.conf 2>/dev/null"
  # screen management
  alias dualm="xrandr --output LVDS1 --auto --output DP1 --auto --right-of LVDS1"
  alias singlem="xrandr --output LVDS1 --primary --auto --output DP1 --off"
fi

# }------------------------------- FUNCTIONS ---------------------------------{

# Skroutz specific
export YOGURT_PATH="/Users/papanikge/skroutz/yogurt/"
export DISABLE_SPRING=true
source ~/.skroutz-helpers

# }--------------------------------- PROMPT ----------------------------------{

source ~/.bash_prompt

# enable z after PROMPT_COMMAND modifications
export PROMPT_COMMAND="$PROMPT_COMMAND ; history -a;"
source ~/.dotfiles/bin/z.sh

# }-------------------------------- ALIASES ----------------------------------{

source ~/.aliases

# }--------------------------------- REST ------------------------------------{

# enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# enable color in man pages
if [[ `uname -s` == 'Darwin' ]]; then
  export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
  export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
  export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
  export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
  export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
  export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
  export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
  export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
fi

# history helper
h () {
  history | fgrep -i $1 | tail
}

# flexible find in cwd
f () {
  find . -iname "*$1*" 2>/dev/null
}
