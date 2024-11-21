# No delay or animation to show dock
defaults write com.apple.dock autohide-delay -int 0; defaults write com.apple.dock autohide-time-modifier -int 0; killall Dock
# Reset to defaults
defaults delete com.apple.dock autohide-delay; defaults delete com.apple.dock autohide-time-modifier; killall Dock
