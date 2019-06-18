#
# George 'papanikge' Papanikolaou 2014 zsh configuration.
# Modified and tried again 19/07/2017
# Modified a lot for locales and safety/sanity 26-7/03/2019
#

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="papanikge" # based on af-magic. I don't like the separator line
plugins=(sudo python docker brew ruby rake redis-cli z colored-man-pages)

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

  # Enable Google Cloud SDK
  PATH=$PATH:/Users/papanikge/.google-cloud-sdk/bin
  CLOUDSDK_PYTHON=/usr/bin/python # for there is no python2
fi

# Custom shit
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.skroutz-helpers ] && source ~/.skroutz-helpers

# env handlers
command -v rbenv >/dev/null && eval "$(rbenv init -)"
command -v pyenv >/dev/null && eval "$(pyenv init -)"
command -v kubectl >/dev/null && source <(kubectl completion zsh);

# Go
export GOPATH=$HOME/playground/go
export GOBIN=$GOPATH/bin
PATH=$PATH:$GOBIN

# Rust
PATH=$PATH:~/.cargo/bin

# Enable fzf and helpers
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf_helpers ] && source ~/.fzf_helpers

export FZF_DEFAULT_COMMAND='rg --files'

# Don't mess with my prompt, virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Jupyter/ipython/itermplot
export MPLBACKEND="module://itermplot"
export ITERMPLOT=rv

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

manswitch () {
  man $1 | less -p "^ +$2";
}
