# start
service tailscale restart
tailscale up --accept-routes=true  --advertise-routes=192.168.8.0/24
