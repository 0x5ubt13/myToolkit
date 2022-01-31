#!/bin/sh

usage() {
    echo
    printf "${GREEN}Usage: ${RESTORE}%s [OPTIONS] <Single target/Targets file> <Output filename>\n" "$(basename "$0")"
    printf "${YELLOW}\t-h : ${RESTORE} Display this help and exit.\n"
    printf "${YELLOW}\t-d : ${RESTORE} Specify custom DNS servers. Default option: ${YELLOW}-n${RESTORE}.\n"
    printf "${GREEN}\nExamples: \n\t%s 10.129.121.60 TEST-012 \n\t%s 192.168.0.254 router\n\t%s -d <serv1[,serv2],...> 10.10.14.80 previse_htb" "$(basename "$0")" "$(basename "$0")" "$(basename "$0")"
    exit 1
}

# Print red error messages and call usage
error_msg() {
    printf "${RED}[-] Error: $1 %s" 1>&2; usage;
}

# ---------- Constants ----------
RESTORE="\033[0m"
RED="\033[031m"
GREEN="\033[32m"
YELLOW="\033[33m"

# Check 1: Ensure there is a target
if [ -n "$1" ]; then
    IP="$1"
else
    error_msg "You must provide a Target hostname/IP address AND a name for the output to start the attack"
fi

# Check 2: Determine whether it is a single target or multi-target
if [ ! -f "$IP" ]; then # Single target
    # Check 3: Ensure $IP is an IP or a URL
    if ! expr "${IP}" : "\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)" >/dev/null && \
       ! expr "${IP}" : "\(\([[:alnum:]-]\{1,63\}\.\)*[[:alpha:]]\{2,6\}\)" >/dev/null; then
        error_msg "Invalid IP or URL!"
        usage
    fi
fi

# Check 4: Ensure output files are named
if [ ! -n "$2" ]; then
    error_msg "Second argument must be name of output files"
fi

# Check 5: I AM GROOT?????
if [ "$(whoami)" != 'root' ]; then
    printf "${RED}[-] I unfortunately need to be run as root. Elevating...\n"
    printf "${YELLOW}[+] IF it failed, run me again as root. Copy+paste: ./$(basename "$0") %s %s" "$1" "$2"
    sudo ./$(basename "$0") "$1" "$2"
    exit 1
fi

# ---------- All good! Pull the container and do some dockery + nmap magic ----------
mkdir "nmap"; cd "./nmap/"
if [ -f ./Dockerfile ]; then
    docker build --network host -t gagarter/autonmap . 
else
    docker pull gagarter/autonmap
fi
docker run --network host -v "$(pwd)":/nmap --name autodeployed gagarter/autonmap "$1" "$2"
printf "[+] Cleaning myself up: killing container -> "
docker rm autodeployed