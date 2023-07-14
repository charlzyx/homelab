# --- tailscale
# echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
# echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
# sysctl -p /etc/sysctl.d/99-tailscale.conf
echo "export LANG=zh_CN.UTF-8" >> /etc/profile && source /etc/profile

uci add network tailscale
uci set network.tailscale=interface
uci set network.tailscale.proto=none
uci set network.tailscale.device=tailscale0
uci commit network

uci add firewall zone
uci set firewall.@zone[-1]=zone
uci set firewall.@zone[-1].name=tailscale
uci set firewall.@zone[-1].input=ACCEPT
uci set firewall.@zone[-1].output=ACCEPT
uci set firewall.@zone[-1].forward=ACCEPT
uci set firewall.@zone[-1].masq=1
uci set firewall.@zone[-1].mtu_fix=1
uci set firewall.@zone[-1].network=tailscale
uci commit firewall

uci add firewall forwarding
uci set firewall.@forwarding[-1].src=tailscale
uci set firewall.@forwarding[-1].dest=wan
uci commit firewall

uci add firewall forwarding
uci set firewall.@forwarding[-1].src=lan
uci set firewall.@forwarding[-1].dest=tailscale
uci commit firewall

uci add firewall forwarding
uci set firewall.@forwarding[-1].src=tailscale
uci set firewall.@forwarding[-1].dest=lan
uci commit firewall

# -- /dev/dri
chmod -R 766 /dev/dri
