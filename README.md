# Linux Swap Space Generator

## Background
<p>
Linux VM's (droplets) created on DigitalOcean by default come with no swap space configured.  
</p>
<p>
This is a simple script which will take a couple of parameters (size and path) and generate the swap partition for you
</p>
## Usage
<p>
Copy the generate_swap.sh to your server (or droplet), make file executable and run.
</p>
<p>
The default will be to create a swap partition mounted to /swapfile thats 512MB in size
</p>
<p>
This script has been tested on DigitalOcean with CentOS 6.5 x86_64 and also 64bit Ubuntu 14.04
</p>
## References
https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04
https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-centos-6
