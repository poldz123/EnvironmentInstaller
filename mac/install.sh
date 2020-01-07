#!/bin/bash


install-brew() {
	# Install brew: https://brew.sh/
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install-brew-cli() {

}

install-brew-cask() {
	brew cask install slack
}

install-brew
install-brew-cli
install-brew-cask