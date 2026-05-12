#!/bin/bash
# 1. Launch both apps
ghostty &
rustrover &

# 2. Wait for windows to actually exist
while [[ $(hyprctl clients | grep -c "jetbrains-rustrover") -eq 0 ]] || \
      [[ $(hyprctl clients | grep -c "com.mitchellh.ghostty") -eq 0 ]]; do
    sleep 0.2
done

# 3. Apply the rule only because both are now confirmed open
# This focuses RustRover and ensures it takes 70% of the screen (1.4 ratio)
hyprctl dispatch focuswindow "class:jetbrains-rustrover"
hyprctl dispatch splitratio exact 1.4
