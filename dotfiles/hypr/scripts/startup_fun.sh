#!/usr/bin/env bash

# Liste des animations disponibles
animations=("cmatrix" "pipes" "cbonsaii")

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
    cbonsaii)
        kitty --class "startup-anim" -e cbonsaii
        ;;
esac
