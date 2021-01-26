#!/bin/sh

echo "Welcome to autoNmap for quickly scanning your box, by 0x5ubt13!"

read -rp "IP to attack: " IP
read -rp "Name of the box to name the file: " NAME

echo "[+] Scanning for open ports..."
PORTS=$(nmap -p- --min-rate=1000 -T4 "$IP" | grep "^[0-9]" | cut -d '/' -f 1 | tr '\n' ',' | sed "s/,$//")

printf "[!] Done!\nHere is a summary of the ports you will be messing with this time:\n"

for PORT in $PORTS
do 
    echo "'$PORT'"
done

while true ; do
    read -rp "Do you want this scan aggresive (flag -A)? (yes/no): " AGGR
    AGGRESIVE=${AGGR,,}

    if [ "$AGGRESIVE" == "yes" ] || [ "$AGGRESIVE" == "y" ]; then
        AGGRESIVE_FLAG="-A"
        COMP_NAME="_aggresive"
        break;
    elif [ "$AGGRESIVE" == "no" ] || [ "$AGGRESIVE" == "n" ]; then
        AGGRESIVE_FLAG="-sS"
        COMP_NAME="_stealthy"
        break;
    else
        printf 'Sorry, you need to enter either "yes" or "no"\n'
    fi
done

while true ; do
    read -rp "Do you want this scan verbose? (yes/no): " VERB
    VERBOSE=${VERB,,}

    if [ "$VERBOSE" == "yes" ] || [ "$VERBOSE" == "y" ]; then
        VERBOSE_FLAG="-vv"
        COMP_NAME.="_verbose"
        break;
    elif [ "$VERBOSE" == "no" ] || [ "$VERBOSE" == "n" ]; then
        VERBOSE_FLAG=
        break;
    else
        printf 'Sorry, you need to enter either "yes" or "no"\n'
    fi
done

echo -n "[+] Procceeding to scan the open ports with your settings..."
nmap "$AGGRESIVE_FLAG" "$VERBOSE_FLAG" -oN "${NAME}${COMP_NAME}.scan" -p"$PORTS" "$IP" 2>/dev/null

