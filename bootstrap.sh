#!/bin/bash
#
# Only ultra-essential files are symlinked
#

set -eu

cd $HOME
ln -s .dotfiles/.vim .
ln -s .dotfiles/.vimrc .
ln -s .dotfiles/.zshrc .
ln -s .dotfiles/.aliases .
ln -s .dotfiles/.fzf_helpers .
ln -s .dotfiles/.gitconfig .

