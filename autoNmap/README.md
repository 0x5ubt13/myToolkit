# autoNmap

Simple wee tool for automating your scans.

If you are a CTF player or box rooter you probably have come across repeating the same first step over and over again: your Nmap scan.

What if I told you: not anymore! With this tool you can automate the process and actually save time in your initial scans. Go ahead, clone the repo and try it now!

## Requisites

- If you run it alone, it's POSIX compliant, so just a shell would do.
- If you want the full experience, you will need to have Docker installed and the Docker Engine running (recommended!!)

## But... Why?
I know there are other cooler tools out there, like [nmapAutomator](https://github.com/21y4d/nmapAutomator), but I wanted to test my skills and create a cool, slim Docker proyect for a quick deployment and, you know, I love to see how it destructs itself!

You will find the Docker image to be as slim as possible. This is, an Alpine distro with the bare minimums for Nmap to be able run. 

The coolest thing? If you use [selfDeploy](./selfDeploy.sh), you will only need to do the following:

```sh
./selfDeploy.sh <Target/TargetsFile> <outputName>
```

... and it will, without you doing anything:

1. Build the Docker image and load `autoNmap` inside it
2. Create an `./nmap/` directory in your current folder
3. Start scanning your target or your list of targets, one by one, only attacking those ports that it finds open, both TCP and the top 1000 UDP ports. (If you want more UDP ports to be scanned, feel free to edit [line 86 of autoNmap](https://github.com/0x5ubt13/myToolkit/blob/dc49f922634373ddbbcac356fabd35e780fa6d5e/autoNmap/autoNmap#L86)
4. It will be saving all the Nmap output files in the `./nmap/` dir we created earlier. Check those initial scans while you wait for the aggressive / UDP ones!
5. 

## Do you want to try it out?
Try it straight away with this one-liner:

```sh
curl -LJO https://raw.githubusercontent.com/0x5ubt13/myToolkit/main/autoNmap/selfDeploy.sh; ./selfDeploy.sh 127.0.0.1 localhost_test
```

To Do:
- [x] Implement ability to directly pass arguments whilst calling the script
- [x] Experimenting with nice colors
- [ ] Open to suggestions!! Your feedback is appreciated :)