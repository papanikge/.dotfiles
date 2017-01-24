#
# George Papanikolaou 2013-2014
# Bash shell configuration. Supposed to work on both mac and linux
#

#
# PATH modifications
#
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

# enable z before PROMPT_COMMAND modifications
export PROMPT_COMMAND=
source ~/.dotfiles/bin/z.sh
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

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
export HISTSIZE=20000
export HISTIGNORE='ls:ll:la:[fb]g:clear:history:h'
export HISTTIMEFORMAT='%F %T '

# Don't mess with my prompt, virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Perl CPAN (for local lib)
PERL_MB_OPT="--install_base \"~/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=~/perl5"; export PERL_MM_OPT;

# }------------------------------- PLATFORMS ---------------------------------{

if [[ `uname -s` == 'Darwin' ]]; then
  command -v sha1sum > /dev/null || alias sha1sum="shasum"
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  # (OSX) Change working directory to the top-most Finder window location (short for "cdfinder")
  cdf() {
    cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
  }
  export DOCKER_HOST=tcp://192.168.59.103:2375
  ulimit -n 1024
else
  export PLATFORM=linux
  export CLICOLOR=1
  alias afk='echo "not yet implemented"'
  alias open="xdg-open"
  alias feh="feh -d -F"
  # pacman helpers
  alias aur="cower -s -c"
  alias paclog="gvim /var/log/pacman.log -c 'normal G'"
  alias paconf="gvim /etc/pacman.conf 2>/dev/null"
  # screen management
  alias dualm="xrandr --output LVDS1 --auto --output DP1 --auto --right-of LVDS1"
  alias singlem="xrandr --output LVDS1 --primary --auto --output DP1 --off"
  # I miss this OSX command. Thank you reddit.
  say () {
    mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$*";
  }
fi

# }------------------------------- FUNCTIONS ---------------------------------{

source ~/.functions

# }--------------------------------- PROMPT ----------------------------------{

source ~/.bash_prompt

# }-------------------------------- ALIASES ----------------------------------{

source ~/.aliases
