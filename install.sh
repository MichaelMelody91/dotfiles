#!/bin/sh

echo "Setting up workstation..."

# Set up symlinks

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s ./zsh/.zshrc $HOME/.zshrc


# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -rf $HOME/.gitconfig
ln -s ./git/.gitconfig $HOME/.gitconfig

rm -rf $HOME/.gitignore
ln -s ./git/.gitconfig $HOME/.gitignore

rm -rf $HOME/.mavenrc
ln -s .mavenrc $HOME/.mavenrc

# Install brew, tap bundle and then use the provided Brewfile to install everything
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew tap homebrew/bundle
brew bundle

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k