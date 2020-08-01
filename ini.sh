#!/bin/sh

cat <<EOF > /root/.credentials/cf.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $CF_EMAIL
dns_cloudflare_api_key = $CF_KEY
EOF

chmod 0600 /root/.credentials/cf.ini