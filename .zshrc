#
# George Papanikolaou (aka papanikge, aka g.pap) 2014 zsh configuration.
# Modified and tried again 19/07/2017
# Modified a lot for locales and safety/sanity 26-7/03/2019
# Major rewrites for i3 and linux on 08/2019
# Major rewrites for mac again on 2021
#
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="papanikge" # based on af-magic. I don't like the separator line
plugins=(sudo z colored-man-pages pyenv)

# Activate oh-my-zsh.
source $HOME/.oh-my-zsh/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh-history
HISTSIZE=200000
SAVEHIST=200000
HISTORY_IGNORE="(ls|la|ll|clear|history|cd|pwd|z|fg)"
bindkey -e

# General
export EDITOR=vim
export PAGER="less -iw -F -X"
export MANPAGER=$PAGER

# These are the result of hours of searching of greek character encoding
export LC_ALL=""
export LC_CTYPE="en_US.UTF-8"

PATH=/usr/local/bin:$PATH
MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

[ -f ~/.aliases ] && source ~/.aliases

# Go
export GOPATH=$HOME/panther/go
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOBIN

## Python. added on 21-07-22. why didn't I have these?
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#### Until here. I swear I had these

# Enable fzf and helpers
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf_helpers ] && source ~/.fzf_helpers

export FZF_DEFAULT_COMMAND='rg --files'

# Used by the custom theme to display the ruby/python version on the right.
right_status() {
  [[ ! -z $VIRTUAL_ENV ]] && echo "[${VIRTUAL_ENV}]"
}

epoch-to-normal() {
  perl -le "print scalar localtime $1"
}

manswitch () {
  man $1 | less -p "^ +$2";
}

_change_cmd () {
  zle beginning-of-line
  zle kill-word
}
# you can "define" a method as a widget and just bind it to a key
zle -N _change_cmd
bindkey ^Q _change_cmd # ^ is contorl, \e is meta/alt key. bless zle

# define with -N
bindkey ^B backward-word
bindkey ^F forward-word
bindkey ^H backward-char
bindkey ^V push-line      # interim command

autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-sudo

# How on earth did I survive without this all this time?
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# system
alias systemupdate="sudo softwareupdate -ia --verbose"

# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
