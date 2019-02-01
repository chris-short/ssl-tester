FROM alpine:latest as build
MAINTAINER Chris Short <chris@chrisshort.net>

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go
ENV CF_EMAIL $CF_EMAIL
ENV CF_KEY $CF_KEY

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

RUN certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-propagation-seconds 15 \
  --dns-cloudflare-credentials cloudflare.ini \
  -d $CF_DOMAIN

ENTRYPOINT [ "ssl-tester" ]
