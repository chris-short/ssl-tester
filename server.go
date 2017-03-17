package main

import (
	"crypto/tls"
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		w.Header().Add("Strict-Transport-Security", "max-age=63072000;")
		w.Write([]byte("Hello World!\n"))
	})
	cfg := &tls.Config{
		MinVersion:               tls.VersionTLS12,
		CurvePreferences:         []tls.CurveID{tls.CurveP521, tls.CurveP384, tls.CurveP256},
		PreferServerCipherSuites: true,
		CipherSuites: []uint16{
			tls.ECDHE-ECDSA-AES256-GCM-SHA384,
			tls.ECDHE-RSA-AES256-GCM-SHA384,
			tls.ECDHE-ECDSA-CHACHA20-POLY1305,
			tls.ECDHE-RSA-CHACHA20-POLY1305,
			tls.ECDHE-ECDSA-AES128-GCM-SHA256,
			tls.ECDHE-RSA-AES128-GCM-SHA256,
			tls.ECDHE-ECDSA-AES256-SHA384,
			tls.ECDHE-RSA-AES256-SHA384,
			tls.ECDHE-ECDSA-AES128-SHA256,
			tls.ECDHE-RSA-AES128-SHA256,
		},
	}
	srv := &http.Server{
		Addr:         ":443",
		Handler:      mux,
		TLSConfig:    cfg,
		TLSNextProto: make(map[string]func(*http.Server, *tls.Conn, http.Handler), 0),
	}
	log.Fatal(srv.ListenAndServeTLS("/etc/ssl-tester/tls.crt", "/etc/ssl-tester/tls.key"))
}
