[![Go Report Card](https://goreportcard.com/badge/github.com/chris-short/ssl-tester)](https://goreportcard.com/report/github.com/chris-short/ssl-tester)
[![GoDoc](https://godoc.org/github.com/chris-short/ssl-tester?status.svg)](https://godoc.org/github.com/chris-short/ssl-tester)
[![Build Status](https://travis-ci.org/chris-short/ssl-tester.svg?branch=master)](https://travis-ci.org/chris-short/ssl-tester)
[![Docker Repository on Quay](https://quay.io/repository/chrisshort/ssl-tester/status "Docker Repository on Quay")](https://quay.io/repository/chrisshort/ssl-tester)
[![SSL Rating](https://sslbadge.org/?domain=ssl-tester.chrisshort.net)](https://www.ssllabs.com/ssltest/analyze.html?d=ssl-tester.chrisshort.net)

# ssl-tester

## Description

A small Go app intended to help troubleshoot certificate chains.

A detailed use case that prompted the creation of this code was featured on [opensource.com](https://opensource.com/article/17/4/testing-certificate-chains-34-line-go-program). I highly recommend reading it.

## Requirements

- go (if you want to modify paths to certificates you will need to run: `go build`)
- Valid TLS keys

## Installing

Installation to your $GOPATH is recommended:

```
go get github.com/chris-short/ssl-tester
```

A public and private key at `/etc/ssl-tester/tls.crt` and `/etc/ssl-tester/tls.key` respectively are expected. These paths can be symlinks to keypairs in another path.

If you want to compile ssl-tester for another platform you can clone this repo and use `go build`. I encourage you to read Dave Chaney's [Cross compilation with Go](https://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5) to better understand that process.

## Container

To build the container you will need to set environment variables in your local environment and pass them through to the container.

Container uses Let's Encrypt (certbot) and Cloudflare to obtain DNS. Say what you want about Cloudflare but it's free and good so it's the lowest barrier to entry.

`docker build --build-arg cf_email=$CF_EMAIL --build-arg cf_key=$CF_KEY --build-arg cf_domain=$CF_DOMAIN -t quay.io/chrisshort/ssl-tester .`

Yes, this README is not great. Check me, Boo.

## Caveats

You might be able to use it to serve a frontend for a small service too if you'd so desire. Pull requests welcome!

## License

MIT

## Author

Chris Short  
https://chrisshort.net
