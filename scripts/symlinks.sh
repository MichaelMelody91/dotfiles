# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -f $HOME/.zshrc
ln -s $1/zsh/.zshrc $HOME/.zshrc


# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -f $HOME/.gitconfig
ln -s $1/git/.gitconfig $HOME/.gitconfig

rm -f $HOME/.gitignore
ln -s $1/git/.gitconfig $HOME/.gitignore

rm -f $HOME/.mavenrc
ln -s $1/mavenrc $HOME/.mavenrc