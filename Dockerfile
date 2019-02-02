FROM certbot/dns-cloudflare:latest

LABEL maintainer Chris Short <chris@chrisshort.net>

ARG cf_domain
ARG cf_email
ARG cf_key

ENV CF_DOMAIN $cf_domain
ENV CF_EMAIL $cf_email
ENV CF_KEY $cf_key
ENV GOPATH /go
ENV PATH /go/bin:/usr/local/go/bin:$PATH

ADD ini.sh /root/
ADD run.sh /root/
#RUN ls -l /root/*.sh ; 

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

ENTRYPOINT [ "/root/run.sh" ]
