FROM certbot/dns-cloudflare:latest

LABEL maintainer Chris Short <chris@chrisshort.net>

ARG cf_domain
ARG cf_email
ARG cf_id
ARG cf_key
ARG cf_zone

ENV CF_DOMAIN $cf_domain
ENV CF_EMAIL $cf_email
ENV CF_ID $cf_id
ENV CF_KEY $cf_key
ENV CF_ZONE $cf_zone
ENV GOPATH /go
ENV PATH /go/bin:/usr/local/go/bin:$PATH

ADD cert.sh /root/

EXPOSE 80 443

COPY . /go/src/github.com/chris-short/ssl-tester

RUN set -x \
  && apk add --no-cache --virtual .build-deps \
  ca-certificates \
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

RUN /root/cert.sh

ENTRYPOINT [ "ssl-tester" ]
