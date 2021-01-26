#!/bin/sh

echo "Welcome to autoNmap for quickly scanning your box, by 0x5ubt13!"

echo "Enter IP to attack:"
read -r IP
echo "Enter name of the box to name the file:"
read -r NAME

echo "[+] Scanning for open ports..."
PORTS=$(nmap -p- --min-rate=1000 -T4 "$IP" | grep "^[0-9]" | cut -d '/' -f 1 | tr '\n' ',' | sed "s/,$//")

printf "[+] Done! Here is a summary of the ports you will be messing with this time:\n"

for PORT in $(echo "$PORTS" | tr ',' '\n')
do 
    echo "Port $PORT."
done

while true ; do
    echo "[?] Do you want this scan aggresive (flag -A)? (yes/no):"
    read -r AGGR
    AGGRESIVE=$(echo "$AGGR" | awk '{print tolower($0)}')

    if [ "$AGGRESIVE" = "yes" ] || [ "$AGGRESIVE" = "y" ]; then
        AGGRESIVE_FLAG="-A"
        COMP_NAME="_aggresive"
        break;
    elif [ "$AGGRESIVE" = "no" ] || [ "$AGGRESIVE" = "n" ]; then
        AGGRESIVE_FLAG="-sS"
        COMP_NAME="_stealthy"
        break;
    else
        printf '[!] Sorry, you need to enter either "yes" or "no"\n'
    fi
done

while true ; do
    echo "Do you want this scan verbose? (yes/no):"
    read -r VERB
    VERBOSE=$(echo "$VERB" | awk '{print tolower($0)}')

    if [ "$VERBOSE" = "yes" ] || [ "$VERBOSE" = "y" ]; then
        VERBOSE_FLAG="-vv"
        COMP_NAME=$COMP_NAME+"_verbose"
        break;
    elif [ "$VERBOSE" = "no" ] || [ "$VERBOSE" = "n" ]; then
        VERBOSE_FLAG=
        break;
    else
        printf 'Sorry, you need to enter either "yes" or "no"\n'
    fi
done

FINAL_NAME="${NAME}${COMP_NAME}.scan"

printf "\n[+] Procceeding to scan the open ports with your settings..."
nmap "$AGGRESIVE_FLAG" "$VERBOSE_FLAG" -oN "${FINAL_NAME}.scan" -p"$PORTS" "$IP" 2>/dev/null

printf "\n[+] Done! you file has been saved as %s.scan" "$FINAL_NAME"
