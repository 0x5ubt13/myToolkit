# autoEnum, an automatic enumeration tool

Heavily inspired by [autoNmap](../autoNmap/README.md), this tool goes beyond Nmap enumeration.

In many external infra jobs, I found myself using autoNmap and extra enumeration tools afterwards, so I came up with the idea of including extra enumeration tools to the already nice functionality of autoNmap, so we should consider autoEnum as an **"autoNmap on steroids"**

Pass either a single IP address or a targets file to it and will first get the ports open on each host, and then concurrently launch tools appropriate for every open port. These will start working on the background, so allow a few moments for them to run completely.

Due to some new functionality that is not present in autoNmap, autoEnum is written in a non-POSIX compliant manner (at least for now). Make sure you have bash (or zsh) installed, then simply run the script.

## Usage

Give it either a single IP address or a file containing a list of IPs, a name to use for the output files, sit back, and relax:

~~~sh
./autoEnum -h

              _____      __________                         
______ ____  ___  /_________  ____/__________  ________ ___ 
_  __ `/  / / /  __/  __ \_  __/  __  __ \  / / /_  __ `__ \
/ /_/ // /_/ // /_ / /_/ /  /___  _  / / / /_/ /_  / / / / /
\__,_/ \__,_/ \__/ \____//_____/  /_/ /_/\__,_/ /_/ /_/ /_/ 
                    by 0x5ubt13                             


Usage: autoEnum [OPTIONS] <Single target's IP/Targets file>
	-h : Display this help and exit.
	-r : Specify a CIDR range to use tools for whole subnets.
	-t : Run port sweep with nmap and the flag --top-ports=<your input>
	-d : Specify custom DNS servers. Default option: -n.

Examples: 
	autoEnum 192.168.142.93
	autoEnum 10.129.121.60 -d <serv1[,serv2],...>
	autoEnum 10.129.121.60 -r 10.129.121.0/24
	autoEnum targets_file.txt -r 10.10.8.0/24    
~~~

## Wrapped tools currently present
- Nmap
- Rustscan
- Nbtscan-unixwiz
- Responder-RunFinger
- Onesixtyone
- Nikto
- Gobuster
- Hydra
- Smbmap
- Rpcclient
- Nmblookup
- Enum4linux

Do you have any other suggestion? Send a PR or a message!

## Installation
*Rustscan is **no longer** a forced pre-requisite, so if you don't have it, no worries, the initial port sweep will be run with nmap instead. If you don't want to run the [install_requisites](./install_requisites.sh) script, you can try to grab the script and run it, if you have all the tools necessary*

Since this script uses multiple enumeration tools used in Penetration Test engagements, it is expected you will be using a distro like Kali Linux or Pwnbox. All the packages that don't normally come pre-installed in Kali (currently Seclists and Rustscan), are featured in the [install_requisites](./install_requisites.sh) script that you can find in this folder. Run it to automatically update your distro, install `Seclists`, `Homebrew` and `Rustscan` for you if you don't have them yet, and it will also symlink the script to your `/usr/bin` folder, you'll be able to call it just issuing `autoenum`. 

There are other checks involved, like the presence of `locate`, which should cover the installation for other non-Kali-but-Debian-based distros. If you spot an error, please report it and I will adjust as necessary. Also, other distros will be considered under request.

Copy/paste the following:
~~~sh
git clone https://github.com/0x5ubt13/myToolkit.git
chmod +x mytoolkit/autoEnum/autoEnum
./mytoolkit/autoEnum/install_requisites.sh
ln mytoolkit/autoEnum/autoEnum /usr/bin/autoenum
~~~

## TODOs
- [] Finish the core script
- [] Test thoroughly
- [] Containerise
- [] Convert to POSIX compliant
- [] Enumerate the planet