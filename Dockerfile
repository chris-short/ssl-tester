FROM certbot/dns-cloudflare:latest as certificate

ARG cf_domain
ARG cf_email
ARG cf_key

ENV CF_DOMAIN $cf_domain
ENV CF_EMAIL $cf_email
ENV CF_KEY $cf_key

ADD ini.sh /

RUN /ini.sh \
  && certbot register --agree-tos --eff-email --email ${CF_EMAIL} \
  && certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-propagation-seconds 15 \
  --dns-cloudflare-credentials /cf.ini \
  -d ${CF_DOMAIN}

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

ENTRYPOINT [ "ssl-tester" ]
