#!/bin/bash

echo "Welcome to autoNmap for quickly scan your box, by 0x5ubt13!"

read -rp "IP to attack: " IP
read -rp "Name of the box: " NAME

echo "[+] Scanning for open ports..."
PORTS=$(nmap -p- --min-rate=1000 -T4 "$IP" | grep "^[0-9]" | cut -d '/' -f 1 | tr '\n' ',' | sed "s/,$//")

printf "[!] Done!\nHere is a list of the ports you will be messing with this time:\n"

for PORT in $PORTS
do 
    echo "Port '$PORT'"
done

while true ; do
    read -rp "Do you want this scan aggresive (flag -A)? (yes/no): " AGGR
    AGGRESIVE=${AGGR,,}

    if [ "$AGGRESIVE" == "yes" ] || [ "$AGGRESIVE" == "y" ]; then
        AGGRESIVE_FLAG="-vv"
        break;
    elif [ "$AGGRESIVE" == "no" ] || [ "$AGGRESIVE" == "n" ]; then
        AGGRESIVE_FLAG="-sS"
        break;
    else
        printf 'Sorry, you need to enter either "yes" or "no"\n'
    fi
done

while true ; do
    read -rp "Do you want this scan verbose? (yes/no)" VERB
    VERBOSE=${VERB,,}

    if [ "$VERBOSE" == "yes" ] || [ "$VERBOSE" == "y" ]; then
        VERBOSE_FLAG="-vv"
        break;
    elif [ "$VERBOSE" == "no" ] || [ "$VERBOSE" == "n" ]; then
        VERBOSE_FLAG=""
        break;
    else
        printf 'Sorry, you need to enter either "yes" or "no"\n'
    fi
done

echo -n "[+] Procceeding to aggresively scan the open ports..."
nmap "$AGGRESIVE_FLAG" "$VERBOSE_FLAG" -oN "${NAME}_initial.scan" -p"$PORTS" "$IP"

