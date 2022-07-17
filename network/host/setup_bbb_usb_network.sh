#!/usr/bin/env bash

if ! id | grep -q root; then
	echo "Must run as root."
	exit
fi

while getopts i:u: args
do
	case "${args}" in
		i) host_interface=${OPTARG};;
		u) usb_interface=${OPTARG};;
	esac
done

# make sure ufw is disabled (ubuntu firewall)
if ! ufw status | grep -q inactive; then
	echo "Disabling ufw"
	ufw disable
fi

# flush old rules for iptables and ip6tables (eg. firewall)
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

ip6tables -t nat -F
ip6tables -t mangle -F
ip6tables -F
ip6tables -X

# add iptable firewall rules to forward traffic from USB "Ethernet" interface
# to the WiFi or Ethernet interface
iptables --table nat --append POSTROUTING --out-interface $host_interface -j \
MASQUERADE
iptables --append FORWARD --in-interface $usb_interface -j ACCEPT

ip6tables --table nat --append POSTROUTING --out-interface $host_interface -j \
MASQUERADE
ip6tables --append FORWARD --in-interface $usb_interface -j ACCEPT
