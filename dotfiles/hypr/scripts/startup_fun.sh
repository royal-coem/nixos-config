#!/usr/bin/env bash

# Liste des animations disponibles
animations=("cmatrix" "pipes" "cbonsai" "mapscii")

# Choisit l'une d'elles aléatoirement
selected=${animations[$RANDOM % ${#animations[@]}]}

# Lance Kitty avec l'animation choisie
case $selected in
    cmatrix)
        kitty --class "startup-anim" -e cmatrix
        ;;
    pipes)
        kitty --class "startup-anim" -e pipes.sh
        ;;
    cbonsai)
        kitty --class "startup-anim" -e cbonsai
        ;;
    mapscii)
	kitty --class "startup-anim" -e mapscii
esac
