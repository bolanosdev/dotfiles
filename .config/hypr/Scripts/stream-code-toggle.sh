#!/usr/bin/env bash
# Toggle coding stream profile on workspace 1
# Profile ON:  1920x1080 top-right content area (15% margin)
# Profile OFF: full 3440x1440

FLAG="/tmp/hypr-stream-code"
PROFILE="$HOME/.config/hypr/stream-profile.lua"
MAIN="$HOME/.config/hypr/hyprland.lua"

if [ -f "$FLAG" ]; then
    # OFF: remove the require line
    sed -i '/require("stream-profile")/d' "$MAIN"
    rm "$FLAG"
    hyprctl reload
else
    # ON: append the require if not already there
    if ! grep -q 'require("stream-profile")' "$MAIN"; then
        echo 'require("stream-profile")' >> "$MAIN"
    fi
    touch "$FLAG"
    hyprctl reload
fi
