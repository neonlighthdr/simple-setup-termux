#!/bin/bash

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Padding width for aligned output
PAD_WIDTH=30

# Universal function for any task
do_task() {
    task_name="$1"
    command="$2"

    raw="${task_name}..."

    # 1. Print padded raw text (no color)
    printf "%-${PAD_WIDTH}s" "$raw"

    # 2. Print colored task text (overwrite padded)
    printf "\r${YELLOW}%s${RESET}" "$raw"

    # 3. Move cursor to end of padded area
    printf "%$((PAD_WIDTH - ${#raw}))s" ""

    # 4. Execute command silently
    if eval "$command" >/dev/null 2>&1; then
        echo -e "[${GREEN}SUCCESS${RESET}]"
    else
        echo -e "[${RED}FAILED${RESET}]"
    fi
}

clear
# Update package lists
do_task "Updating packages" "pkg update"
do_task "Upgrading packages (waiting 9s)" 'sleep 2 && pkg upgrade -y -o Dpkg::Options::="--force-confold"'

sleep 1 # 2 second pause 

clear # clear cache
# Installing Necessary Packages
do_task "Installing x11-repo" "apt install -y x11-repo"
do_task "Installing termux-x11" "apt install -y termux-x11"
do_task "Installing tur-repo" "apt install -y tur-repo"
do_task "Installing pulseaudio" "apt install -y pulseaudio"
do_task "Installing proot-distro" "apt install -y proot-distro"
do_task "Installing git" "apt install -y git"
do_task "Installing wget" "apt install -y wget"
do_task "Installing nano" "apt install -y nano"

# Clear cache
pkg clean
clear
