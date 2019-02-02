#!/bin/sh

cat <<EOF > /root/cf.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = ${CF_EMAIL}
dns_cloudflare_api_key = ${CF_KEY}
EOF

chmod 0600 /root/cf.ini

mkdir -p /etc/ssl-tester &&
    certbot register --agree-tos --register-unsafely-without-email &&
    certbot certonly --dry-run \
    --dns-cloudflare \
    --dns-cloudflare-propagation-seconds 5 \
    --dns-cloudflare-credentials /root/cf.ini \
    -d ${F_DOMAIN} &&
    ln -s /etc/letsencrypt/live/${CF_DOMAIN}/fullchain.pem /etc/ssl-tester/fullchain.pem &&
    ln -s /etc/letsencrypt/live/${CF_DOMAIN}/privkey.pem /etc/ssl-tester/privkey.pem &&
    rm -f /root/ini.sh &&
    rm -f /root/cf.ini