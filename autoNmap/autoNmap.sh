#!/bin/sh

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
    printf "usage: %s [OPTIONS]\n -v\tVerbose\n -A\tAggresive\n -h\tDisplay this help and exit" "$0" 1>&2; exit 1;
}

echo "Welcome to autoNmap for quickly scanning your box, by 0x5ubt13!"

echo "Enter IP to attack:"
read -r IP
echo "Enter name of the box to name the file:";
read -r NAME

echo "${green}[+] Scanning for open ports...";
PORTS=$(nmap -p- --min-rate=1000 -T4 "$IP" | grep "^[0-9]" | cut -d '/' -f 1 | tr '\n' ',' | sed "s/,$//");

printf "[+] Done! Here is a summary of the ports you will be messing with this time:\n";

for PORT in $(echo "$PORTS" | tr ',' '\n')
do 
    echo "Port $PORT."
done

while getopts "h:v:A:" flag
do
    case "${flag}" in
        h)  usage;;

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

# while true ; do
#     echo "[?] Do you want this scan aggresive (flag -A)? (yes/no):"
#     read -r AGGR
#     AGGRESIVE=$(echo "$AGGR" | awk '{print tolower($0)}')

#     if [ "$AGGRESIVE" = "yes" ] || [ "$AGGRESIVE" = "y" ]; then
#         AGGRESIVE_FLAG="-A"
#         COMP_NAME="_aggresive"
#         break;
#     elif [ "$AGGRESIVE" = "no" ] || [ "$AGGRESIVE" = "n" ]; then
#         AGGRESIVE_FLAG="-sS"
#         COMP_NAME="_stealthy"
#         break;
#     else
#         printf '[!] Sorry, you need to enter either "yes" or "no"\n'
#     fi
# done

# while true ; do
#     echo "Do you want this scan verbose? (yes/no):"
#     read -r VERB
#     VERBOSE=$(echo "$VERB" | awk '{print tolower($0)}')

#     if [ "$VERBOSE" = "yes" ] || [ "$VERBOSE" = "y" ]; then
#         VERBOSE_FLAG="-vv"
#         COMP_NAME=$COMP_NAME"_verbose"
#         break;
#     elif [ "$VERBOSE" = "no" ] || [ "$VERBOSE" = "n" ]; then
#         VERBOSE_FLAG=
#         break;
#     else
#         printf 'Sorry, you need to enter either "yes" or "no"\n'
#     fi
# done

FINAL_NAME="${NAME}${COMP_NAME}"

echo "${yellow}[+] Procceeding to scan the open ports with your settings...${reset}"

nmap -sS -v "$AGGRESIVE_FLAG" "$VERBOSE_FLAG" -oN "${FINAL_NAME}".scan -p"$PORTS" "$IP"

printf "${green}[+] Done! you file has been saved as %s.scan" "$FINAL_NAME"
