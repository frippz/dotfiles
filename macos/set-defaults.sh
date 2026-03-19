#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2> /dev/null &

# General UI/UX
echo " ✅ Disable press-and-hold for keys in favor of key repeat."
defaults write -g ApplePressAndHoldEnabled -bool false

echo " ✅ Enable keyboard navigation ⌨"
defaults write -g AppleKeyboardUIMode -int 2

echo " ✅ Re-enable the classic Mac startup chime! 🎶"
sudo nvram StartupMute=%00

echo " ✅ Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo " ✅ Change the location of where screenshots are saved to Downloads"
defaults write com.apple.screencapture location $HOME/Downloads/

# Photos
echo " ✅ Don't launch Photos if a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Safari
echo " ✅ Set up Safari for development."
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo " ✅ Set up Safari Technology Preview for development"
defaults write com.apple.SafariTechnologyPreview IncludeInternalDebugMenu -bool true
defaults write com.apple.SafariTechnologyPreview IncludeDevelopMenu -bool true
defaults write com.apple.SafariTechnologyPreview WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.SafariTechnologyPreview "com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# NetNewsWire
echo " ✅ Use traditional window title bar in NetNewsWire"
defaults write com.ranchero.NetNewsWire-Evergreen KafasisTitleMode -bool YES
