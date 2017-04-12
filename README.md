# ssl-tester

## Description
A small Go app intended to help troubleshoot certificate chains.

A detailed use case that prompted the creation of this code was featured on [opensource.com](https://opensource.com/article/17/4/testing-certificate-chains-34-line-go-program). I highly recommend reading it.

## Requirements
- go
- Valid TLS keys

## Installing

Installation to your $GOPATH is recommended:

```
go get github.com/chris-short/ssl-tester
```

A public and private key at `/etc/ssl-tester/tls.crt` and `/etc/ssl-tester/tls.key` respectively are expected. These paths can be symlinks to keypairs in another path.

If you want to compile ssl-tester for another platform you can clone this repo and use `go build`. I encourage you to read Dave Chaney's [Cross compilation with Go](https://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5) to better understand that process.

## Caveats
You might be able to use it to serve a frontend for a small service too if you'd so desire. Pull requests welcome!

## License
MIT

## Author
Chris Short
https://chrisshort.net
