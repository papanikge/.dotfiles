# George 'papanikge' Papanikolaou 2014 zsh configuration.
# Using oh-my-zsh for the time being.
export ZSH=$HOME/.oh-my-zsh

# Basic oh-my-zsh configurations
ZSH_THEME="robbyrussell"
export UPDATE_ZSH_DAYS=15 # Auto update is on.
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(osx brew cabal ruby git sudo)

# Activate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

# General
export EDITOR=vim
export PAGER="less -iw"
export MANPAGER=$PAGER
export GREP_OPTIONS="--color=auto -n"

# PATH modifications
if [[ `uname -s` == 'Darwin' ]]; then
  # god damn it apple
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/bin:$PATH
  MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi
export MANPATH="/usr/local/man:$MANPATH"
# ...adding rubygems and cabal tools
PATH=$PATH:$(ruby -rubygems -e 'puts Gem.user_dir')/bin:~/.cabal/bin
# ...and my own bin folder full of script goodies
PATH=$PATH:~/.dotfiles/bin

# Enable z
source ~/.dotfiles/bin/z.sh

# Don't mess with my prompt, virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# log history to a daily file
function precmd() {
    if [ "$(id -u)" -ne 0 ]; then
        FULL_CMD_LOG="$HOME/.logs/zsh-history-$(date -u "+%Y-%m-%d").log"
        echo "$USER@`hostname`:`pwd` [$(date -u)] `\history -1`" >> ${FULL_CMD_LOG}
    fi
}

# Mac only
if [[ `uname -s` == 'Darwin' ]]; then
  command -v sha1sum > /dev/null || alias sha1sum="shasum"
  alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
  export DOCKER_HOST=tcp://192.168.59.103:2375
fi

# My aliases
source ~/.aliases
source ~/.functions
alias g=gvim
