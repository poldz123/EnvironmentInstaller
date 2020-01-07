#!/bin/bash


install-brew() {
	# Install brew: https://brew.sh/
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install-brew-cli() {

}

install-brew-cask() {

}

install-brew
install-brew-cli
install-brew-cask