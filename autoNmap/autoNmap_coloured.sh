#!/bin/sh

# Timing the script
start=$(date +%s)

# Colours
red=$(tput setaf 1);
green=$(tput setaf 2);
yellow=$(tput setaf 3);
reset=$(tput sgr0);

# Error msg
errorMsg() {
	echo "${red}[-] Error: $1 ${reset}" >&2;
}

# Usage
usage(){
    printf "Usage: %s <IP> <Name> [OPTIONS]\n -v\tVerbose\n -A\tAggresive\n -h\tDisplay this help and exit" "$0" 1>&2; exit 1;
}

while getopts "h:v:A:" flag
do
    case "${flag}" in
        h)  usage; exit 1;;

        v)  VERBOSE_FLAG="-vv";
            COMP_NAME="$COMP_NAME""_verbose";
            ;;

        A)  AGGRESIVE_FLAG="-A";
            COMP_NAME="$COMP_NAME""_aggressive";
            ;;

        *)  errorMsg "Invalid options provided";
			usage;
			;;
    esac
done

echo "Welcome to autoNmap for a quick port sweep, by ${green}0x5ubt13!${reset}"


if [ -n "$1" ]; then
IP="$1"
else
errorMsg "You must provide an IP address as first argument"
echo "Please enter IP to attack:"
read -r IP
fi

if [ -n "$2" ]; then
NAME="$2"
else
errorMsg "Second argument must be name of output file"
fi

printf "${green}[+] Scanning %s for any TCP open ports..." "$IP"
PORTS=$(nmap --min-rate=2000 -p- -T5 "$IP" | grep "^[0-9]" | cut -d '/' -f 1 | tr '\n' ',' | sed "s/,$//")

echo "$PORTS"

FINAL_NAME="${NAME}${COMP_NAME}"

echo "${yellow}[+] Procceeding to scan the open ports with your settings...${reset}"

nmap -sS -v "$AGGRESIVE_FLAG" "$VERBOSE_FLAG" -oN "${FINAL_NAME}".scan -p"$PORTS" "$IP"

# printf "${green}[+] Done! you file has been saved as %s.scan" "$FINAL_NAME"
printf "[+] Done! you file has been saved as %s.scan" "$FINAL_NAME"

# Getting runtime
end=$(date +%s)
runtime=$((end - start))
printf "\n[+] It took %s seconds to scan your target!!" "$runtime"