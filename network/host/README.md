Scripts for setting up the network on ubuntu to send internet packets to
the beaglebone black through USB.

https://gist.github.com/pdp7/d2711b5ff1fbb000240bd8337b859412

Dont forget to change ip6tables as well which isnt included in the gist.

Dont forget to follow the first steps in guide to enable forwarding for ipv4/6

grep forward /etcc/sysctl.conf
#uncomment the following lines
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
