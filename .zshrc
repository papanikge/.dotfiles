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

################## FZF KEY BINDING FOR GIT #################### EXPERIMENTAL

# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

_tags_gt() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  # Pass the list of the tags to fzf-tmux
  # - "{}" in preview option is the placeholder for the highlighted entry
  # - Preview window can display ANSI colors, so we enable --color=always
  # - We can terminate `git show` once we have $LINES lines
  git tag --sort -version:refname |
    fzf-tmux --multi --preview-window right:70% \
             --preview 'git show --color=always {} | head -'$LINES
}

_hashes_gh() {
  is_in_git_repo || return

  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# A helper function to join multi-line output from fzf
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-gt-widget() LBUFFER+=$(_tags_gt | join-lines)
fzf-gh-widget() LBUFFER+=$(_hashes_gh | join-lines)
zle -N fzf-gt-widget
zle -N fzf-gh-widget
bindkey '^g^t' fzf-gt-widget
bindkey '^g^h' fzf-gh-widget

# also
alias ftig="_hashes_gh"

# FZF WITH PREVIEW (Try highlight, then fall back to cat)
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500"'
