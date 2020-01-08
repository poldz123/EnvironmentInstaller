#!/bin/bash

set -e

install-base() {
	# Install util script
	curl -L -s -H 'Cache-Control: no-cache' -o installer-rodolfo-util.sh https://raw.githubusercontent.com/poldz123/EnvironmentInstaller/master/util.sh && . ./installer-rodolfo-util.sh
	rm -f installer-rodolfo-util.sh
	# Install brew: https://brew.sh/
	util-print-header "Installing BREW"
	echo | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install-terminal() {
	util-print-header "Installing ZSH-TERMINAL"
	brew cask install iterm2
	brew install zsh
	echo | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# Create the alias for git
	util-append-unique-text-to-file 'alias gpl="git pull"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gph="git push"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gc="git commit -m"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gs="git status"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gca="git commit --amend"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gd="git diff"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gaa="git add ."' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gl="git log --pretty=oneline"' "$HOME/.zshrc"
}

install-applications() {
	util-print-header "Installing BREW-APPLICATIONS"
	brew cask install spotify
	brew cask install google-chrome
	brew cask install android-studio
}

install-base
install-terminal
install-applications