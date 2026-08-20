#!/usr/bin/env bash

# Définition propre des raccourcis
read -r -d '' SHORTCUTS << 'EOF'
󰌌 Super + T             Open Terminal (Kitty)
󰌌 Super + Q             Close Active Window
󰌌 Super + M             Exit Hyprland
󰌌 Super + E             File Manager (Dolphin)
󰌌 Super + L             Toggle Floating Mode
󰌌 Super + A             Application Launcher
󰌌 Super + V             Clipboard History
󰌌 Super + B             Web Browser (Firefox)
󰌌 Super + !             Keyboard Shortcuts Menu
---------------------------------------------------
󰌌 Super + Arrows        Move Window Focus
󰌌 Super + Scroll        Switch Workspaces
󰌌 Super + 1..10         Go to Workspace N
󰌌 Super + Shift + 1..10 Move Window to Workspace N
---------------------------------------------------
󰌌 Super + Shift + S     Screenshot Region -> Clipboard
󰌌 PrintScreen           Screenshot Fullscreen -> Clipboard
󰌌 Super + PrintScreen   Screenshot Region -> Save File
EOF

THEME="$HOME/.config/rofi/launchers/type-6/style-6.rasi"

# Commande Rofi avec surcharge CSS pour forcer l'affichage du texte
echo "$SHORTCUTS" | rofi -dmenu \
    -p "Shortcuts" \
    -theme "$THEME" \
    -theme-str 'listview { columns: 1; lines: 12; } element { children: [ element-icon, element-text ]; } element-icon { enabled: false; } element-text { horizontal-align: 0.0; vertical-align: 0.5; }'
