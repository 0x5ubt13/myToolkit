# autoEnum, an automatic enumeration tool

Heavily inspired by [autoNmap](../autoNmap/README.md), this tool goes beyond Nmap enumeration.

In many jobs I found myself using autoNmap and extra enumeration tools afterwards, so I came up with the idea of including extra enumeration tools to the already nice functionality of autoNmap, so we should consider autoEnum as an **"autoNmap on steroids"**

Pass either a single IP address or a targets file to it and will first get the ports open on each host, and then concurrently launch tools appropriate for every open port. These will start working on the background, so allow a few moments for them to run completely.

Due to some new functionality that is not present in autoNmap, autoEnum is written in a non-POSIX complaint manner (at least for now). Make sure you have bash (or zsh) installed, then simply run the script.

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

## Installation
*Rustscan is **no longer** a forced pre-requisite, so if you don't have it, no worries, the initial port sweep will be run with nmap instead. If you don't want to run the install_requisites.sh script, use this to grab the script:*

~~~sh
git clone https://github.com/0x5ubt13/myToolkit.git
chmod +x mytoolkit/autoEnum/autoEnum
ln mytoolkit/autoEnum/autoEnum /usr/bin/autoenum
autoenum -h
~~~

Since this script uses multiple enumeration tools used in Penetration Test engagements, it is expected you will be using a distro like Kali Linux. All the packages that don't normally come pre-installed in Kali (currently Seclists and Rustscan), are featured in the [install_requisites](./install_requisites.sh) script that you can find in this folder. Run it for it to automatically install Seclists, Homebrew and Rustscan for you if you don't have these tools, and it will also symlink the script to your bin folder.

~~~sh
git clone https://github.com/0x5ubt13/myToolkit.git
cd mytoolkit/autoEnum/
chmod +x ./install_requisites.sh
./install_requisites.sh
~~~