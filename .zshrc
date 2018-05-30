#
# George 'papanikge' Papanikolaou 2014 zsh configuration.
# Modified and tried again 19/07/2017
#

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="papanikge"
plugins=(sudo screen python docker brew ruby rake vagrant redis-cli cabal z \
  colored-man-pages fzf-docker) # fzf-docker is not build-in

# Activate oh-my-zsh.
source $HOME/.oh-my-zsh/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=~/.zsh-history
HISTSIZE=50000
SAVEHIST=50000
HISTORY_IGNORE="(ls|la|ll|clear|history|cd|pwd)"
bindkey -e

# General
export EDITOR=vim
export PAGER="less -iw -F -X"
export MANPAGER=$PAGER
export GREP_OPTIONS="--color=auto"

# Lang
# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8

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

# Go
export GOPATH=$HOME/playground/go
export GOBIN=$GOPATH/bin

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# history helper
h() {
  history | fgrep -i $1 | tail
}

##
#
# FZF - The Holiest of Holies
#
##
export FZF_COMPLETION_TRIGGER=','

# Helpers first
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Show hashes with control-g-h (like tig)
_hashes_gh() {
  is_in_git_repo || return

  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}
fzf-gh-widget() LBUFFER+=$(_hashes_gh | join-lines)
zle -N fzf-gh-widget
bindkey '^g^h' fzf-gh-widget

########### more - mine

_docker_images() {
  docker image ls |
  fzf-tmux --ansi --no-sort --reverse \
    --preview '' |
  cut -d' ' -f3
}
fzf-di-widget() LBUFFER+=$(_docker_images | join-lines)
zle -N fzf-di-widget
bindkey '^g^i' fzf-di-widget

# FZF WITH PREVIEW (Try highlight, then fall back to cat)
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && \
                        echo {} is a binary file || \
                        (highlight -O ansi -l {} || cat {}) 2> /dev/null | \
                        head -500"'

# lastpass
pass() {
  lpass show lucidchart.com >/dev/null
  lpass show -c --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
}

# Tmux manager
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No sessions found."
}

# git find - general purpose checkout tool
gfa() {
  local tags local_branches remote_branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return

  local_branches=$(git branch | grep -v HEAD | sed "s/.* //" |
    awk '{print "\x1b[32;1mbranch\x1b[m\t" $1}') || return

  remote_branches=$(git branch --remotes | grep -v HEAD |
    sed "s/.* //" | sed "s#remotes/[^/]*/##" |
    awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return

  target=$((echo "$tags"; echo "$local_branches"; echo "$remote_branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 --ansi \
    --preview="git diff --color=always $(echo {+2..} | sed 's/$/..master/' ) | head -500") || return

  # ${target} has origin/ in front. we use or # for prefix of // for substring
  git checkout $(echo "${target//origin\/}" | awk '{print $2}')
}
