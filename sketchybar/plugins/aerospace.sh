#!/bin/bash
# Get focused workspace directly
FOCUSED=$(aerospace list-workspaces --focused)

# Catppuccin colors
CLR_MAUVE=0xffcba6f7
CLR_TEXT_DIM=0x77cdd6f4

# Highlight if this is the focused workspace
if [ "$1" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" label.color="$CLR_MAUVE"
else
  sketchybar --set "$NAME" label.color="$CLR_TEXT_DIM"
fi