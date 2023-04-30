# autoEnum, an automatic enumeration tool

Heavily inspired by ![autoNmap](../autoNmap/README.md), this tool goes beyond Nmap enumeration. 

In many jobs I found myself using autoNmap and extra enumeration tools afterwards, so I came up with the idea of including extra enumeration tools to the already nice functionality of autoNmap. 

## Usage
Give it either a single IP address or a file containing a list of IPs, a name to use for the output files, sit back, and relax:

~~~sh
./autoEnum localhost my_test_enum
~~~

NB: Nmap Stealthy scans and UDP scans are disabled for autoEnum for performance purposes. If you want these enabled just uncomment the lines on the script.

