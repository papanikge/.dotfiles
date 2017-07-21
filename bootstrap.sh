# let's remove the previous versions first
rm ../.bashrc
rm ../.bash_profile

# [Obsoletes] password-sensitive files
# scp papanikge@diogenis.ceid.upatras.gr:.irc.conf .weechat/irc.conf
# scp papanikge@diogenis.ceid.upatras.gr:.offlineimaprc .offlineimaprc
# scp papanikge@diogenis.ceid.upatras.gr:.msmtp-ceid.gpg .msmtp-ceid.gpg

cd
ln -s .dotfiles/.vim .
ln -s .dotfiles/.vimrc .
ln -s .dotfiles/.mutt .
ln -s .dotfiles/.muttrc .
ln -s .dotfiles/.bashrc .
ln -s .dotfiles/.bash_prompt .
ln -s .dotfiles/.skroutz-helpers .
ln -s .dotfiles/.aliases .
ln -s .dotfiles/.bash_profile .
ln -s .dotfiles/.zshrc .
ln -s .dotfiles/.gitconfig .
ln -s .dotfiles/.ghci .
ln -s .dotfiles/.agignore .
ln -s .dotfiles/.valgrindrc .
ln -s .dotfiles/.wgetrc .
ln -s .dotfiles/.weechat .
ln -s .dotfiles/.irbrc .
if [[ `uname -s` == 'Linux' ]]; then
  ln -s .dotfiles/.inputrc .
  ln -s .dotfiles/.Xdefaults .
  ln -s .dotfiles/.Xmodmap .
  ln -s .dotfiles/.dunstrc .
  ln -s .dotfiles/.gtkrc-2.0 .
  ln -s .dotfiles/.msmtprc .
  ln -s .dotfiles/.offlineimaprc .
  ln -s .dotfiles/.xinitrc .
  ln -s .dotfiles/.xmonad .
fi
