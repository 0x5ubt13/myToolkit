# autoNmap

Simple wee tool for automating your scans.

If you are a CTF player or box rooter you probably have come across repeating the same first step over and over again: your Nmap scan.

What if I told you: not anymore! With this tool you can automate the process and actually save time in your initial scans. Go ahead, clone the repo and try it now!

## Requisites

- If you run it alone, it's POSIX compliant, so just a shell would do.
- (Recommended!! ->) If you want the full experience, you will need to have Docker installed and the Docker Engine running 

## But... Why?

I know there are other cooler tools out there, like [nmapAutomator](https://github.com/21y4d/nmapAutomator), but I wanted to test my skills and create my own cool, slim, dockerised tool for a quick deployment and, you know, I love to see how it destructs itself!

You will find the Docker image to be as slim as possible. This is, an Alpine distro with the bare minimums for Nmap to be able to run. Only **11.33MB**!!


The coolest thing? If you use my [autoNmap self-deployer](https://github.com/0x5ubt13/myToolkit/blob/main/autoNmap/autoNmap_self_deploy.sh), you will only need to do the following:

```sh
./autoNmap_self_deploy.sh <Target/TargetsFile> <outputName>
```

... and it will, without you doing anything:

1. Build/pull the Docker image and load `autoNmap` inside it
2. Create `./nmap/` directory in your current folder
3. Start scanning your target or your list of targets, one by one, only attacking those ports that it finds open, both TCP and the top 1000 UDP ports. (If you want more UDP ports to be scanned, feel free to edit [line 86 of autoNmap](https://github.com/0x5ubt13/myToolkit/blob/dc49f922634373ddbbcac356fabd35e780fa6d5e/autoNmap/autoNmap#L86)
4. It will be saving all the Nmap output files in the `./nmap/` dir we created earlier. Check those initial scans while you wait for the aggressive / UDP ones!
5. Self destruction!!!!!! It will kill the container from your machine to saving up any dangling resources

## Do you want to try it out?
Try it straight away with this one-liner:

```sh
curl -LJO https://raw.githubusercontent.com/0x5ubt13/myToolkit/main/autoNmap/autoNmap_self_deploy.sh; sh ./autoNmap_self_deploy.sh 127.0.0.1 localhost_test
```

## Disclaimer

As you see, a lot of dangerous `sudo` stuff happens behind the scenes. All the code involved is here for you to review, so make sure you know what you are doing and if you have any doubts, feel free to reach out.


### To Do:

- [x] Implement ability to directly pass arguments whilst calling the script
- [x] Experimenting with nice colors
- [ ] Open to suggestions!! Your feedback is appreciated :)
