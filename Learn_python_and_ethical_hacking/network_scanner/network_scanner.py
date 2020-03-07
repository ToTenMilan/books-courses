#!/usr/bin/env python

# 1. create arp request directed to broadcast MAC asking for IP
#    - use ARP to ask who has target IP
#    - set destination MAC to broadcast MAC
# 2. send packet and receive response
# 3. parse the response
# 4. print result

import scapy.all as scapy
import argparse


def get_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--range", dest="range", help="IP or IP range to scan")
    options = parser.parse_args()
    if not options.range:
        parser.error("[-] Please provide IP address or IP range to scan")
    return options


def scan(ip):
    arp_request = scapy.ARP(pdst=ip) # who has this IP?
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff") # sned to broadcast address, so everybody will receive it
    arp_request_broadcast = broadcast/arp_request
    answered_list = scapy.srp(arp_request_broadcast, timeout=1, verbose=False)[0] # send packet to the network and receive it
    clients_list = []
    for element in answered_list:
        client_dict = {"ip": element[1].psrc, "mac": element[1].hwsrc}
        clients_list.append(client_dict)
    return clients_list


def print_result(results_list):
    print("IP\t\t\tMAC Address\n-----------------------------------------")
    for client in results_list:
        print(client["ip"] + "\t\t"  + client["mac"])


options = get_arguments()
scan_result = scan(options.range)
print_result(scan_result)




