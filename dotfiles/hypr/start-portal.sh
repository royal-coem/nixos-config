#!/usr/bin/env bash
sleep 2
pkill -9 -f xdg-desktop-portal
systemctl --user start xdg-desktop-portal-hyprland
exec /nix/store/*-xdg-desktop-portal-1*/libexec/xdg-desktop-portal
