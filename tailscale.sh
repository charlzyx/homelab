# tailscale
opkg install tailscale iptables-nft
service tailscale restart

echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

# 注1：开启路由--accept-routes=true
# 注2：关闭下发dns--accept-dns=false
# 注3：指定本地局域网段路由转发--advertise-routes=192.168.120.0/24
# 注4：自动刷新路由表--reset
# 注5：关闭默认防火墙规则（22.03.x版本必须用这个参数，21.02.x版本不需要）--netfilter-mode=off
# 需要用户手动验证
tailscale up --accept-routes=true --accept-dns=false --advertise-routes=192.168.120.0/24 --reset --netfilter-mode=off


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
