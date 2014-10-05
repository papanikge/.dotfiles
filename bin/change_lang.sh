# get current language
lang=$(setxkbmap -query | awk 'FNR==3 {print $2}')
# change
if [[ "$lang" == "us" ]]; then
    setxkbmap -layout el
else
    setxkbmap -layout us
    # restore caps
    xmodmap ~/.Xmodmap >/dev/null
fi

