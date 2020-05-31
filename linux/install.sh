#!/bin/bash
#!/bin/bash

set -e

install-base() {
	# Install util script
	curl -L -s -H 'Cache-Control: no-cache' -o installer-rodolfo-util.sh https://raw.githubusercontent.com/poldz123/EnvironmentInstaller/master/util.sh && . ./installer-rodolfo-util.sh
	rm -f installer-rodolfo-util.sh
	# Install brew: https://brew.sh/
	if ! which brew > /dev/null; then
		util-print-header "INSTALLING BREW"
		echo | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
		util-print-header "CONFIGURING BREW PROFILE ENVIRONMENT"
		SHELL=$(which bash)
		test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
		test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
		test -r ~/.bash_profile && brew shellenv >> ~/.bash_profile
		brew shellenv >> ~/.profile
		source ~/.profile
		echo "Done"
	fi
}

install-java() {
	util-print-header "Installing JAVA-JDK-8"
	# brew cask install adoptopenjdk/openjdk/adoptopenjdk8
}

install-terminal() {
	util-print-header "Installing ZSH-TERMINAL"
	sudo apt install zsh -y
	echo | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
	# Create the alias for git
	util-append-unique-text-to-file 'alias gb="git branch"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gbc="git checkout"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gpl="git pull"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gph="git push"' "$HOME/.zshrc"
	# Alias when inline command should encase with single qoute to prevent the command from executing during sourcing of the alias
	util-append-unique-text-to-file "alias gphb='git push -u origin \"\$(git rev-parse --abbrev-ref HEAD)\"'" "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gc="git commit -m"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gs="git status"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gca="git commit --amend"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gd="git diff"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gdt="git difftool -y --tool=p4merge"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gm="git merge"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gmt="git mergetool -y --tool=p4merge"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gaa="git add ."' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gl="git log --pretty=oneline"' "$HOME/.zshrc"
}

install-kubernetes() {
	util-print-header "Installing KUBERNETES"
	brew install kubectl
	brew install kubectx
	# Create an empty config, this wont be empty if it was already created before
	mkdir -p ~/.kube
	touch ~/.kube/config
}

install-commands() {
	util-print-header "Installing BREW-COMMANDS"
	brew install bundletool
}

install-applications() {
	util-print-header "Installing BREW-APPLICATIONS"
	# brew cask install spotify
	# brew cask install google-chrome
	# brew cask install android-studio
	# brew cask install sublime-text
	# brew cask install p4v
	# brew cask install virtualbox
	# brew cask install db-browser-for-sqlite
	# brew cask install android-file-transfer
}

install-addon() {
	option="$1"
	if [[ "$option" == "--with-kubernetes" ]]; then
		install-kubernetes
	fi
}

install-base
install-java
install-terminal
install-commands
install-applications

# Make sure to add $0 arguments since we are running the script in bash
install-addon "$0"
for option in "$@"
do
	install-addon $option
done

util-print-header "DONE"
