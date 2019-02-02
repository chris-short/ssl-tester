#!/bin/sh

cat <<EOF > /etc/ssl-tester/cf.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $CF_EMAIL
dns_cloudflare_api_key = $CF_KEY
EOF

chmod 0600 /etc/ssl-tester/cf.ini