#!/bin/bash -e
#
# IPv4
#
sudo iptables -N TCP
sudo iptables -N UDP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
sudo iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP
sudo iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
sudo iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable


if [ -n "`pacman -Qs nginx`" ]; then
    sudo iptables -A TCP -p tcp --dport 80 -j ACCEPT
    sudo iptables -A TCP -p tcp --dport 443 -j ACCEPT
else
    echo "nginx not installed blocking port 80/443 for IPv4"
fi
sudo iptables -A TCP -p tcp --dport 22 -j ACCEPT
sudo iptables -t raw -I PREROUTING -m rpfilter --invert -j DROP
sudo iptables -I INPUT 1 -p udp --dport 60000:61000 -j ACCEPT

sudo iptables -I UDP -p udp -m recent --update --seconds 60 --name UDP-PORTSCAN -j REJECT --reject-with icmp-port-unreachable
sudo iptables -D INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
sudo iptables -A INPUT -p udp -m recent --set --name UDP-PORTSCAN -j REJECT --reject-with icmp-port-unreachable

sudo iptables -D INPUT -j REJECT --reject-with icmp-proto-unreachable
sudo iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable

sudo iptables-save | sudo tee /etc/iptables/iptables.rules

sudo systemctl enable iptables
sudo systemctl start iptables

#
# IPv6
#
sudo ip6tables -N TCP
sudo ip6tables -N UDP
sudo ip6tables -P FORWARD DROP
sudo ip6tables -P OUTPUT ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo ip6tables -A INPUT -i lo -j ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo ip6tables -A INPUT -p icmpv6 --icmpv6-type 128 -m conntrack --ctstate NEW -j ACCEPT
sudo ip6tables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
sudo ip6tables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP
sudo ip6tables -A INPUT -p udp -j REJECT --reject-with icmp6-port-unreachable
sudo ip6tables -A INPUT -p tcp -j REJECT --reject-with tcp-reset
sudo ip6tables -A INPUT -j REJECT

if [ -n "`pacman -Qs nginx`" ]; then
    sudo ip6tables -A TCP -p tcp --dport 80 -j ACCEPT
    sudo ip6tables -A TCP -p tcp --dport 443 -j ACCEPT
else
    echo "nginx not installed blocking port 80/443 for IPv6"
fi
sudo ip6tables -A TCP -p tcp --dport 22 -j ACCEPT
sudo ip6tables -t raw -A PREROUTING -m rpfilter -j ACCEPT
sudo ip6tables -t raw -A PREROUTING -j DROP
sudo ip6tables -I INPUT 1 -p udp --dport 60000:61000 -j ACCEPT

sudo ip6tables -A INPUT -s fe80::/10 -p icmpv6 -j ACCEPT

sudo ip6tables -D INPUT -j REJECT
sudo ip6tables -A INPUT -j REJECT

sudo ip6tables-save | sudo tee /etc/iptables/ip6tables.rules

sudo systemctl enable ip6tables
sudo systemctl start ip6tables
