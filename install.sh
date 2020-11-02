#!/bin/sh

echo "Setting up workstation..."

WORKING_DIR=$(dirname $0)

# Set up symlinks
source ./scripts/symlinks.sh $WORKING_DIR

# Install brew, tap bundle and then use the provided Brewfile to install everything
if test ! $(which brew); then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew tap homebrew/bundle
brew bundle

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Set up GitHub access and repos
source ./scripts/configure_github_auth.sh $WORKING_DIR/.env_vars
source ./scripts/clone_github_repos.sh $HOME/Repositories
