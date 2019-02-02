#!/bin/sh

cat <<EOF > /cf.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $CF_EMAIL
dns_cloudflare_api_key = $CF_KEY
EOF

chmod 0600 /cf.ini

mkdir -p /etc/ssl-tester
ln -s /etc/letsencrypt/live/$CF_DOMAIN/fullchain.pem /etc/ssl-tester/fullchain.pem
ln -s /etc/letsencrypt/live/$CF_DOMAIN/privkey.pem /etc/ssl-tester/privkey.pem