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
# ...adding rubygems and cabal tools
PATH=$PATH:$(ruby -rubygems -e 'puts Gem.user_dir')/bin:~/.cabal/bin

# General
export EDITOR=vim
export PAGER="less -iw"
export MANPAGER=$PAGER
export GREP_OPTIONS="--color=auto -n"

# Globbing settings, try to emulate zsh. Maybe I should switch to it.
if [[ $(echo $BASH_VERSION | cut -d. -f1) -ge 4 ]]; then
  shopt -s globstar
  shopt -s nullglob
fi

# enable z before PROMPT_COMMAND modifications
export PROMPT_COMMAND=
source ~/code/bin/z.sh
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Completions
source ~/code/bin/.git-completion.sh
complete -cf which
complete -cf watch
complete -cf sudo
complete -cf type
complete -cf man

# Bash history modifications
shopt -s histappend
shopt -s cdspell
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
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
else
  export PLATFORM=linux
  export CLICOLOR=1
  synclient TapButton1=0
  synclient TapButton2=0
  synclient TapButton3=0
  synclient PalmDetect=1
  alias afk="echo 'not yet implemented'"# TODO afk locking for linux
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

# create and go to a directory in one cmd
mcd () {
  mkdir -p $1
  cd $1
}

# send output to stderr
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# history helper
h () {
  history | fgrep -i $1 | tail
}

# flexible find in cwd
f () {
  find . -iname "*$1*" 2>/dev/null
}

# count all the files in a directory
cf () {
  find $1 -name "*" -type f | wc -l
}

# repeat commands on file change in local directory
repeat () {
  echo "to be implemented"
}

# restart the network
reip () {
  sudo ip link set wlan0 down
  echo "Access Granted"
  sleep 2
  sudo ip link set wlan0 up
}

# google from the command line
google () {
  local q
  q=$(echo $* | tr ' ' '+')
  chromium https://google.com/search?q=$q
}

# graphviz is weird
draw () {
  dot -Tpng $1 > output.png
}

# Simple calculator (thx @mathiasbynens)
calc() {
  local result="";
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
      -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
      -e 's/0*$//;s/\.$//';  # remove trailing zeros
  else
    printf "$result";
  fi
  printf "\n";
}

g() {
  if [ $# -eq 0 ]; then
    gvim . 2>/dev/null;
  else
    gvim "$@" 2>/dev/null;
  fi
}

# }--------------------------------- PROMPT ----------------------------------{

_prompt_color () {
  if [[ $? = 0 ]]; then
    echo "$(tput setaf 2)"
  else
    echo "$(tput setaf 1)"
  fi
}

_prompt_git () {
  # shall we continue?
  if [[ ! -d .git ]]; then
    [[ -d .hg ]] && echo "$(tput setaf 3)(hg) "
    return
  fi

  local state branch prompt

  state=$(git status --porcelain 2>/dev/null)
  # I have "-n" in GREP_OPTIONS so I need that last cut command. Maybe I should remove it...
  branch=$(git branch --no-color | fgrep "*" | cut -d' ' -f2)
  prompt="$(tput sgr0)on $(tput setaf 11)git:"

  prompt=${prompt}${branch#\* }

  if $(echo "$state" | egrep '^UU ' &>/dev/null); then
    prompt="${prompt}!"
  fi

  if $(echo "$state" | egrep '^.[MD] ' &>/dev/null); then
    prompt="${prompt}+"
  fi

  if $(echo "$state" | egrep '^\?\? ' &>/dev/null); then
    prompt="${prompt}?"
  fi

  if $(echo "$state" | egrep '^[AMDR]. ' &>/dev/null); then
    prompt="${prompt}*"
  fi

  echo -n "${prompt} "
}

_prompt_env () {
  [[ -n "$VIRTUAL_ENV" ]] && echo "$(tput setaf 5)[virtualenv]"
  [[ -d cabal-dev ]] && echo "$(tput setaf 5)[cabal-dev]"
  [[ -f cabal.sandbox.config ]] && echo "$(tput setaf 5)[cabal-sandbox]"
  [[ -f *.gemspec || -f .ruby-version ]] && echo "$(tput setaf 5)[$(ruby --version | cut -d' ' -f1,2)]"
}

export PS1='\n$(_prompt_color)\u $(tput sgr0)at $(tput setaf 13)\H $(tput sgr0)in $(tput setaf 4)\w $(_prompt_git)$(_prompt_env) $(tput sgr0)\n→ '

# }-------------------------------- ALIASES ----------------------------------{

# Better defaults
alias ls="ls --color"
alias ll="clear && ls -lG"
alias la="ls -A"
alias ls1="find . -name *"
alias cfgrep='grep -v "^[[:space:]]*($|#)"' # for config files
alias p="pgrep -l"
alias c="chromium"
alias du="du -hs"
alias df="df -hT"
alias dirdiff="diff -b -r -w"
alias gdb="gdb -q"                   # need to find how to add this to .gdbinit
alias dmesg="dmesg --color --ctime"
alias hcp="rsync -WavP --human-readable --progress"                # human copy
alias qemu="sudo qemu-system-x86_64 -enable-kvm -redir tcp:2222::22 -vga std"
alias ubuntu="qemu -m 1024 -hda Virtual/pompeii-ubuntu.img -smp cores=1,threads=2,sockets=1 -vga vmware"
# git stuff
alias gst="git status -sb"
alias gbr="git branch"
alias gco="git checkout"
# ssh & vm stuff
alias ceid="ssh papanikge@diogenis.ceid.upatras.gr"
alias arch="ssh -p 2222 papanikge@127.0.0.1"
alias up="VBoxManage startvm Palmyra --type headless"
alias down="VBoxManage controlvm Palmyra poweroff"
# IP addresses
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
if [[ `uname -s` == 'Darwin' ]]; then
  alias localip="ipconfig getifaddr en1"
else
  alias localip="ifconfig"
fi
# vim in the cli should not load bells and whistles
alias vim='vim -c "colo default" --noplugin'
# command line pastebin using sprunge
alias pastebin="curl -F 'sprunge=<-' http://sprunge.us"
# python helpers
alias nose="nosetests3"
alias activate='source $(find . -name activate)'
# valgrind helpers
alias vmem="valgrind --tool=cachegrind"
alias vthreads="valgrind --tool=helgrind --verbose"
alias vcalls="valgrind --tool=callgrind --branch-sim=yes --cacheuse=yes --verbose"
alias vleaks="valgrind --tool=memcheck --leak-check=full --show-reachable=yes --num-callers=20 --track-fds=yes"
# network
alias serve="python -m http.server 8080"
# other tools
alias m="~/code/m.sh/m"
alias wr="~/code/bin/wr.rb"
alias alert="~/code/bin/alert.rb"                        # only works for linux
alias mirror="wget --no-clobber --random-wait -krpE -e robots=off"
alias ssh-password='ssh -o PasswordAuthentication=yes -o PubkeyAuthentication=no'
