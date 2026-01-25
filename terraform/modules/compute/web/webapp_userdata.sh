#!/bin/bash
set -eux
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y nginx

cat >/etc/nginx/sites-available/default <<EOF
server {
  listen 80;
  server_name _;

  location / {
    proxy_pass http://${app_lb_dns}:8080;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
  }
  location /health {
  return 200 "ok";
  }

}
EOF

nginx -t
systemctl enable nginx
systemctl reload nginx