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

FROM certbot/dns-cloudflare:latest

ARG cf_domain
ARG cf_email
ARG cf_key

ENV CF_DOMAIN $cf_domain
ENV CF_EMAIL $cf_email
ENV CF_KEY $cf_key

COPY cloudflare.ini cf.ini

RUN certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-propagation-seconds 15 \
  --dns_cloudflare_email ${CF_EMAIL} \
  --dns_cloudflare_api_key ${CF_KEY} \
#  --dns-cloudflare-credentials cf.ini \
  -d ${CF_DOMAIN}
#  && cat /var/log/letsencrypt/letsencrypt.log

ENTRYPOINT [ "ssl-tester" ]
