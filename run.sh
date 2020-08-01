#!/bin/sh

mkdir -p /etc/ssl-tester &&
    #  && ls -ld /etc/ssl-tester \
    ini.sh &&
    #  && cat /root/cf.ini \
    certbot register --agree-tos --eff-email --email ${CF_EMAIL} &&
    certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-propagation-seconds 5 \
    --dns-cloudflare-credentials /root/.credentials/cf.ini \
    -d ${CF_DOMAIN} &&
    #  && ls -l /etc/letsencrypt/live/* \
    ln -s /etc/letsencrypt/live/${CF_DOMAIN}/fullchain.pem /etc/ssl-tester/fullchain.pem &&
    ln -s /etc/letsencrypt/live/${CF_DOMAIN}/privkey.pem /etc/ssl-tester/privkey.pem &&
    rm -f /root/.credentials/cf.ini

ssl-tester