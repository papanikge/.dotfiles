#
# Custom theme 19/07/2017 from af-magic.zsh-theme
#
# based on:
# https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
#

#
# I want to show the tag in the prompt when there is one, in case of detached
# HEAD.  Find git_prompt_info and add this in the succession of command with
# which it gets the object SHA:
#
# ref=$(command git tag --points-at HEAD 2> /dev/null) || \
#

#
# Other changes I've made: remove a space from oh-my-zsh/lib/git.zsh
#

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%} %? ↵%{$reset_color%})"

# We need it in a different local variable surrounded by single quotes in
# order to update in every invocation and not cache.
local interpreter_version='$(right_status)'

# primary prompt (there's also git_prompt_status, but let's keep it clean)
PROMPT='%{$reset_color%}$FG[032]%~\
$(git_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '

# secondary prompt
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

# right prompt
RPS1="$my_gray${interpreter_version}${return_code}%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075] $FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075]%{$reset_color%}"

# `git_prompt_status` uses these.
# ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[103]%}✚%{$rset_color%}"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[103]%}✹%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[103]%}✖%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[103]%}➜%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[103]%}═%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[103]%}✭%{$reset_color%}"
