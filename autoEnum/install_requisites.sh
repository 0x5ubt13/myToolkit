#!/bin/bash

# ---------- Colour constants ----------
RESTORE="\033[0m"
RED="\033[031m"
GREEN="\033[32m"
YELLOW="\033[33m"

# ---------- Installation ----------
# Making sure we're not SU
if [ "$EUID" -eq 0 ]; then 
  printf "%b[-]%b Please don't run this script as root 💀, sudo will only be used when strictly necessary.\n" "${RED}" "${RESTORE}"
  exit 1
fi

# Detecting debian-based distro
compatible_distro=$(cat /etc/*-release | grep -i "debian")
if [ -n "$compatible_distro" ]; then
  printf "%b[+] Debian-like distro successfully detected. Updating system...%b\n" "${GREEN}" "${RESTORE}"
  sudo apt-get update >/dev/null  
  
  # Seclists
  seclists=$(find /usr/share/ 2>/dev/null | grep darkweb2017-top1000.txt)
  if [ -n "$seclists" ]; then
    printf "%b[+] Seclists detected as installed.%b\n" "${GREEN}" "${RESTORE}"
  else
    printf "%b[+] Installing seclists...%b\n" "${GREEN}" "${RESTORE}"
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
    printf "%b[+] Rustscan detected as installed.%b\n" "${GREEN}" "${RESTORE}"
  fi

  # Updatedb / locate
  updatedb_check=$(which updatedb)
  if [ -z "$updatedb_check" ]; then
    sudo apt install updatedb locate -y
  fi
  sudo updatedb
  
  # Symlink autoEnum
  chmod +x ./autoEnum
  ln -s ./autoEnum /usr/bin/autoenum

  # ODAT
  updatedb_check=$(which updatedb)
  if [ -z "$updatedb_check" ]; then
    printf "%b[+] Installing ODAT...%b\n" "${GREEN}" "${RESTORE}"
    sudo apt install odat -y >/dev/null
  else
    printf "%b[+] ODAT detected as installed.%b\n" "${GREEN}" "${RESTORE}"
  fi
  
  # SSH-Audit
  ssh_audit_check=$(which ssh-audit)
  if [ -z "$ssh_audit_check" ]; then
    printf "%b[+] Installing ssh-audit...%b\n" "${GREEN}" "${RESTORE}"
    sudo apt install ssh-audit -y >/dev/null
  else
    printf "%b[+] SSH-Audit detected as installed.%b\n" "${GREEN}" "${RESTORE}"
  fi

  # Launch autoEnum help
  printf "%b[+]%b autoEnum %bis ready for you! Start enumerating now! :)\n" "${GREEN}" "${YELLOW}" "${RESTORE}"
  autoenum -h

else
  printf "%b[-] Debian-like distro NOT detected. Aborting...%b\n%b[!] To run autoEnum fast, simply make sure you have installed Seclists and Rustscan. Some ports won't be covered, like 1521, but the majority will be enumerated!%b\n" "${RED}" "${RESTORE}" "${YELLOW}" "${RESTORE}"
fi    
