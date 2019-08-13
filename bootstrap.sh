#!/bin/bash
#
# Only ultra-essential files are symlinked
#

set -eu

cd $HOME
ln -s .dotfiles/.zshrc .
ln -s .dotfiles/.vim .
ln -s .dotfiles/.vimrc .
ln -s .dotfiles/.mutt .
ln -s .dotfiles/.muttrc .
ln -s .dotfiles/.skroutz-helpers .
ln -s .dotfiles/.aliases .
ln -s .dotfiles/.gitconfig .
ln -s .dotfiles/.irbrc .
ln -s .dotfiles/.i3 .
ln -s /home/papanikge/.dotfiles/i3status .config

# Secrets and sensitive files
# TODO need to fetch password-sensitive files

# oh-my-tmux
wget -qO .tmux.conf https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf

# oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh .oh-my-zsh

echo "You might need to run:"
echo "    adduser <username>"
echo "...then add to sudoers, switch to them and run:"
echo "    sudo chsh -s /bin/zsh"
