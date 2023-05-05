#!/bin/bash

# ---------- Colour constants ----------
RESTORE="\033[0m"
RED="\033[031m"
GREEN="\033[32m"
YELLOW="\033[33m"

# ---------- Installation ----------
# Making sure we're not SU
if [ "$EUID" -eq 0 ]; then 
    printf "%b[-]%b Please don't run this script as root 💀, sudo will be only used when scritly necessary." "${RED}" "${RESTORE}"
    exit 1
fi

# Detecting debian-based distro
compatible_distro=$(cat /etc/*-release | grep -i "debian")
if [ -n "$compatible_distro" ]; then
    printf "%b[+] Debian-like distro successfully detected. Updating system...%b" "${GREEN}" "${RESTORE}"
    sudo apt-get update >/dev/null

    # Seclists
    seclists=$(find /usr/share/ 2>/dev/null | grep darkweb2017-top1000.txt)
    if [ -n "$seclists" ]; then
        printf "%b[+] Seclists detected as installed.%b" "${GREEN}" "${RESTORE}"
    else
        printf "%b[+] Installing seclists ...%b" "${GREEN}" "${RESTORE}"
        sudo apt-get install seclists
    fi

    # Rustscan
    rustscan_check=$(find / rustscan 2>/dev/null | grep /bin/rustscan)
    if [ -n "$rustscan_check" ]; then
        # Homebrew (for rustscan)
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Bind to shell
        (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv )"') >> "${HOME}"/.zprofile
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    
        # Install Rustscan
        brew install rustscan
    else
        "%b[+] Rustscan detected as installed.%b" "${GREEN}" "${RESTORE}"
    fi

    # Symlink autoEnum
    chmod +x ./autoEnum
    ln ./autoEnum /usr/bin/autoenum

    # Launch autoEnum help
    autoenum

else
    printf "%b[-] Debian-like distro NOT detected. Aborting...%b\n%b[!] To run autoEnum fast, simply make sure you have installed Seclists and Rustscan%b" "${RED}" "${RESTORE}" "${YELLOW}" "${RESTORE}"
fi    
