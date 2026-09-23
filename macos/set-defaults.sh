#!/bin/sh

source $HOME/.dotfiles/zsh/msg.zsh

# Ask for the administrator password upfront
msg_info "Asking for sudo"
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# General UI/UX
msg_done "Disable press-and-hold for keys in favor of key repeat."
defaults write -g ApplePressAndHoldEnabled -bool false

msg_done "Enable keyboard navigation ⌨"
defaults write -g AppleKeyboardUIMode -int 2

msg_done "Re-enable the classic Mac startup chime! 🎶"
sudo nvram StartupMute=%00

msg_done "Position dock to the left"
defaults write com.apple.dock "orientation" -string "left"

msg_done "Autohide dock"
defaults write com.apple.dock "autohide" -bool "true"

msg_done "Remove autohide delay for dock"
defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock

msg_done "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

msg_done "Change the location of where screenshots are saved to Downloads"
defaults write com.apple.screencapture location $HOME/Downloads/

# Photos
msg_done "Don't launch Photos if a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Safari
msg_done "Set up Safari for development"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

msg_done "Disable pull to refresh in Safari"
defaults write com.apple.Safari DebugDisableRefreshControl 1
