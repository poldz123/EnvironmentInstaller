#!/bin/bash

set -e

install-base() {
	# Install util script
	curl -L -s -H 'Cache-Control: no-cache' -o installer-rodolfo-util.sh https://raw.githubusercontent.com/poldz123/EnvironmentInstaller/master/util.sh && . ./installer-rodolfo-util.sh
	rm -f installer-rodolfo-util.sh
	# Install brew: https://brew.sh/
	if ! which brew > /dev/null; then
		util-print-header "Installing BREW"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
}

install-java() {
	util-print-header "Installing JAVA-JDK-8"
	brew install --cask temurin@17
}

install-terminal() {
	util-print-header "Installing ZSH-TERMINAL"
	touch ~/.zshrc # Create the file so that zsh wont break during installation
	brew install --cask iterm2
	brew install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" | true
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
	util-append-unique-text-to-file 'alias cls="clear"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gdl="git diff --shortstat"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias grhh="git reset HEAD --hard"' "$HOME/.zshrc"
	util-append-unique-text-to-file 'alias gphf="git push -f"' "$HOME/.zshrc"
	# Create android path environment variables
	util-append-unique-text-to-file 'export ANDROID_HOME=~/Library/Android/sdk' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export ANDROID_SDK_ROOT=~/Library/Android/sdk' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export ANDROID_AVD_HOME=~/.android/avd' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export PATH=$PATH:$ANDROID_HOME/emulator' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export PATH=$PATH:$ANDROID_HOME/tools' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export PATH=$PATH:$ANDROID_HOME/tools/bin' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export PATH=$PATH:$ANDROID_HOME/platform-tools' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export PATH=$PATH:$ANDROID_AVD_HOME' "$HOME/.zshrc"
	util-append-unique-text-to-file 'export PATH=$HOME/.jenv/bin:$PATH' "$HOME/.zshrc"
	util-append-unique-text-to-file 'eval "$(jenv init -)"' "$HOME/.zshrc"
}

install-kubernetes() {
	util-print-header "Installing KUBERNETES"
	brew install --cask docker
	brew install kubectl
	brew install kubectx
	# Create an empty config, this wont be empty if it was already created before
	mkdir -p ~/.kube
	touch ~/.kube/config
}

install-aws-serverless() {
	util-print-header "Installing AWS-SERVERLESS"
	brew tap aws/tap
	brew install serverless
	brew install aws-sam-cli
	brew install node
	brew install yarn
}

install-mobile() {
	brew install android-sdk
}

install-commands() {
	util-print-header "Installing BREW-COMMANDS"
	brew install bundletool
 	brew install gh
	brew install jenv
}

install-applications() {
	util-print-header "Installing BREW-APPLICATIONS"
	# brew install --cask spotify
	# brew install --cask google-chrome
	brew install --cask android-studio
	brew install --cask sublime-text
	# brew install --cask p4v
	brew install --cask charles
	# brew install --cask db-browser-for-sqlite
	# brew install --cask android-file-transfer
	# brew install --cask intellij-idea-ce
	brew install --cask postman
	brew install --cask cursor
	brew install --cask codex
	brew install --cask warp
	brew install --cask claude-code
	# brew install --cask visual-studio-code
 	# brew install --cask zoom
  	# brew install --cask tuple
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
# install-aws-serverless
# install-mobile
install-commands
install-applications

# Make sure to add $0 arguments since we are running the script in bash
install-addon "$0"
for option in "$@"
do
	install-addon $option
done

util-print-header "DONE"
