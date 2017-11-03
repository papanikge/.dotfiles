#
# George 'papanikge' Papanikolaou 2014 zsh configuration.
# Modified and tried again 19/07/2017
#

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="papanikge"
plugins=(git sudo screen python docker brew ruby bundler rake vagrant \
  redis-cli cabal z colored-man-pages)
# remove 'bu' aliases if you have bundler

# Activate oh-my-zsh.
source $HOME/.oh-my-zsh/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh-history
HISTSIZE=10000
SAVEHIST=50000
HISTORY_IGNORE="(ls|la|ll|clear|history|cd|pwd)"
bindkey -e

# General
export EDITOR=vim
export PAGER="less -iw -F -X"
export MANPAGER=$PAGER
export GREP_OPTIONS="--color=auto"

if [[ `uname -s` == 'Darwin' ]]; then
  # god damn it apple
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  PATH=/usr/local/bin:$PATH
  PATH=$PATH:~/.dotfiles/bin:~/.local/bin
  MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
fi

# Custom shit
source ~/.aliases
source ~/.skroutz-helpers

# env handlers
eval "$(rbenv init -)"
eval "$(pyenv init -)"

# enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.zsh

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

# history helper
h() {
  history | fgrep -i $1 | tail
}

# flexible find in cwd
f() {
  find . -iname "*$1*" 2>/dev/null
}

# git recent edit files editor
vd() {
  if [[ -z `git diff --name-only` ]]; then
    vim `git diff --name-only @ @~`
  else
    vim `git diff --name-only`
  fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
gfb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
