FROM certbot/dns-cloudflare:latest as certificate

ARG cf_domain
ARG cf_email
ARG cf_key

ENV CF_DOMAIN $cf_domain
ENV CF_EMAIL $cf_email
ENV CF_KEY $cf_key

ADD ini.sh /var/tmp/

#RUN ls -l /var/tmp/ini.sh ; 

EXPOSE 80 443

RUN mkdir -p /etc/ssl-tester \
#  && ls -ld /etc/ssl-tester \
  && /var/tmp/ini.sh \
#  && cat /etc/ssl-tester/cf.ini \
  && certbot register --agree-tos --eff-email --email ${CF_EMAIL} \
  && certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-propagation-seconds 5 \
  --dns-cloudflare-credentials /etc/ssl-tester/cf.ini \
  -d ${CF_DOMAIN} \
#  && ls -l /etc/letsencrypt/live/* \
  && ln -s /etc/letsencrypt/live/${CF_DOMAIN}/fullchain.pem /etc/ssl-tester/fullchain.pem \
  && ln -s /etc/letsencrypt/live/${CF_DOMAIN}/privkey.pem /etc/ssl-tester/privkey.pem \
  rm -f /var/tmp/ini.sh \
  rm -f /etc/ssl-tester/cf.ini

FROM alpine:latest as build
LABEL maintainer Chris Short <chris@chrisshort.net>

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN apk add --no-cache \
  ca-certificates

COPY . /go/src/github.com/chris-short/ssl-tester

RUN set -x \
  && apk add --no-cache --virtual .build-deps \
  go \
  git \
  gcc \
  libc-dev \
  libgcc \
  && cd /go/src/github.com/chris-short/ssl-tester \
  && go build -o /usr/bin/ssl-tester . \
  && apk del .build-deps \
  && rm -rf /go \
  && echo "Build complete."

EXPOSE 80 443

ENTRYPOINT [ "ssl-tester" ]
