#
# Lemniscate
# Custom zsh theme 19/07/2017 based on af-magic.zsh-theme from oh-my-zsh
#

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%} %? ↵%{$reset_color%})"

# We need it in a different local variable surrounded by single quotes in
# order to update in every invocation and not cache.
# It needs a 'right_status' shell function.
local interpreter_version='$(right_status)'

# primary prompt
PROMPT='%{$reset_color%}$FG[032]%~\
$(git_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '

# secondary prompt
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

# right prompt
RPS1="$my_gray${interpreter_version}${return_code}%{$reset_color%}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
