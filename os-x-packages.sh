#!/bin/bash
#
# Basic Bootstraping for a new Mac OS system
# George 'papanikge' Papanikolaou 2014
# a lot of snippets are from https://github.com/MatthewMueller/.dotfiles/
#

# Only on a Mac
if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

# if git is not installed yet, it means that xcode is not installed
if test ! $(which git); then
  echo "Please install Xcode first!"
  exit 0
fi

# Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi

echo "Hold tight."
# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install findutils
brew install bash
# ...and some other goodies
brew install the_silver_searcher macvim git tree ffmpeg graphicsmagick python
atool weechat boot2docker wget xz gcc cscope cmake z gpg ctags

# Install homebrew-cask
brew tap phinze/homebrew-cask
brew install brew-cask

# Install some native OS-X apps
brew cask install --appdir="/Applications" google-chrome torbrowser skype
dropbox mplayerx virtualbox f-lux transmission iterm2 launchbar evernote
spectacle day-o

# Remove outdated versions from the cellar
brew linkapps
brew cleanup

# Run "hacker-osx-sane-defaults-script"
echo "Running OS-X for hackers script."
wget -q -O .this https://raw.githubusercontent.com/MatthewMueller/dots/master/os/osx/defaults.sh
chmod +x .this
./.this
rm .this

echo "Also check out for any App Store apps you may need"
