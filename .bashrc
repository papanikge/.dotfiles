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

# Ruby
eval "$(rbenv init -)"

# Globbing settings, try to emulate zsh. Maybe I should switch to it.
if [[ $(echo $BASH_VERSION | cut -d. -f1) -ge 4 ]]; then
  shopt -s globstar
  shopt -s nullglob
fi

# Completions
source ~/.dotfiles/bin/.git-completion.sh
complete -cf which
complete -cf watch
complete -cf sudo
complete -cf type
complete -cf man

# Bash history modifications
shopt -s histappend
shopt -s cdspell
export HISTCONTROL=ignoreboth
export HISTSIZE=30000
export HISTIGNORE='ls:ll:la:[fb]g:clear:history:h'
export HISTTIMEFORMAT='%F %T '

# Don't mess with my prompt, virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Docker (for mac)
if [[ `uname -s` == 'Darwin' ]]; then
  eval $(docker-machine env)
fi

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

source ~/.functions

# }--------------------------------- PROMPT ----------------------------------{

source ~/.bash_prompt

# enable z after PROMPT_COMMAND modifications
export PROMPT_COMMAND="$PROMPT_COMMAND ; history -a;"
source ~/.dotfiles/bin/z.sh

# }-------------------------------- ALIASES ----------------------------------{

source ~/.aliases
