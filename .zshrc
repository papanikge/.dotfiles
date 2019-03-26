#
# George 'papanikge' Papanikolaou 2014 zsh configuration.
# Modified and tried again 19/07/2017
# Modified a lot again 26/03/2019
#

export ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="agnoster"
ZSH_THEME="papanikge"
plugins=(sudo screen python docker brew ruby rake vagrant redis-cli cabal z colored-man-pages)
# if you're here looking for something that's missing check fzf-docker

# Activate oh-my-zsh.
source $HOME/.oh-my-zsh/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh-history
HISTSIZE=200000
SAVEHIST=200000
HISTORY_IGNORE="(ls|la|ll|clear|history|cd|pwd|z)"
bindkey -e

# General
export EDITOR=vim
export PAGER="less -iw -F -X"
export MANPAGER=$PAGER
export GREP_OPTIONS="--color=auto"

# These are the result of hours of searching of greek character encoding
export LC_ALL=""
export LC_CTYPE="en_US.UTF-8"

if [[ `uname -s` == 'Darwin' ]]; then
  # god damn it apple
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/bin:$PATH
  PATH=$PATH:~/.dotfiles/bin:~/.local/bin
  PATH=$PATH:/usr/local/opt/mariadb@10.1/bin
  # more below after the $GOBIN set up
  MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
else
  LANG=C
  LC_CTYPE=el_GR.ISO8859-7
  LC_COLLATE=el_GR.ISO8859-7
fi

# Custom shit
source ~/.aliases
source ~/.skroutz-helpers

if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# env handlers
eval "$(rbenv init -)"
eval "$(pyenv init -)"

# Go
export GOPATH=$HOME/playground/go
export GOBIN=$GOPATH/bin
PATH=$PATH:$GOBIN

# Enable fzf and helpers
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && source ~/.fzf_helpers

# Enable Google Cloud SDK
PATH=$PATH:/Users/papanikge/.google-cloud-sdk/bin
CLOUDSDK_PYTHON=/usr/bin/python # for there is no python2

# Don't mess with my prompt, virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Jupyter/ipython/itermplot
export MPLBACKEND="module://itermplot"
export ITERMPLOT=rv

# Skroutz specific
export YOGURT_PATH="/Users/papanikge/skroutz/yogurt/"
export DISABLE_SPRING=true

# Used by the custom theme to display the ruby/python version on the right.
right_status() {
  if [[ -f .ruby-version ]]; then
    echo "[$(rbenv version-name)]"
  else
    if [[ -f .python-version ]]; then
      echo "[$(pyenv version-name)]"
    fi
  fi
}

epoch-to-normal() {
  perl -le "print scalar localtime $1"
}
