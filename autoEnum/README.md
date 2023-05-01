# autoEnum, an automatic enumeration tool

Heavily inspired by [autoNmap](../autoNmap/README.md), this tool goes beyond Nmap enumeration. 

In many jobs I found myself using autoNmap and extra enumeration tools afterwards, so I came up with the idea of including extra enumeration tools to the already nice functionality of autoNmap.

Pass either a single IP address or a targets file to it and will first get the ports open on each host, and then concurrently launch tools appropriate for every open port. These will start working on the background, so allow a few moments for them to run completely.

Due to some new functionality that is not present in autoNmap, autoEnum is written in a non-POSIX complaint manner (at least for now). Make sure you have bash (or zsh) installed, then simply run the script.

## Usage
Give it either a single IP address or a file containing a list of IPs, a name to use for the output files, sit back, and relax:

~~~sh
sudo autoEnum localhost -r localhost/24
~~~

## Installation
Since this script uses multiple enumeration tools used in Penetration Test engagements, it is expected you will be using a distro like Kali Linux. All the packages that don't normally come pre-installed in Kali (currently Seclists and Rustscan), are featured in the [install_requisites](./install_requisites.sh) script that you can find in this folder. Run it for it to automatically install Seclists, Homebrew and Rustscan for you if you don't have these tools, and it will also symlink the script to your bin folder.

~~~sh
git clone https://github.com/0x5ubt13/myToolkit.git
sudo /bin/bash mytoolkit/autoEnum/install_requisites.sh
~~~

or

~~~sh
git clone https://github.com/0x5ubt13/myToolkit.git
ln mytoolkit/autoEnum/autoenum /usr/bin/autoenum
~~~


