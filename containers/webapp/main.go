package main

import (
	"fmt"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"log"
	"net/http"
	"os"
	"strings"
	"time"
)

func init() {
	prometheus.MustRegister(requestCount)
	prometheus.MustRegister(requestDuration)
}

func handler(w http.ResponseWriter, r *http.Request) {
	// check the time (for requestDuration metric)
	start := time.Now()

	// log the request
	log.Printf("%s %s %s %s\n", r.RemoteAddr, r.Method, r.URL, r.Header.Get("User-Agent"))

	// display the banner
	fmt.Fprintf(w, ` _                       __                        _       _
| |_ ___ _ __ _ __ __ _ / _| ___  _ __ _ __ ___   | | __ _| |__
| __/ _ \ '__| '__/ _' | |_ / _ \| '__| '_ ' _ \  | |/ _' | '_ \
| ||  __/ |  | | | (_| |  _| (_) | |  | | | | | | | | (_| | |_) |
 \__\___|_|  |_|  \__,_|_|  \___/|_|  |_| |_| |_| |_|\__,_|_.__/
-----------------------------------------------------------------

`)
	// display the request details
	fmt.Fprintln(w, "Remote Address :", r.RemoteAddr)
	fmt.Fprintln(w, "Forwarded For  :", r.Header.Get("x-forwarded-for"))
	fmt.Fprintln(w, "Host           :", r.Host)
	fmt.Fprintln(w, "URL            :", r.URL)
	fmt.Fprintln(w, "User-Agent     :", r.Header.Get("User-Agent"))
	fmt.Fprintln(w, "-----------------------------------------------------------------")

	// print environment variables beginning with TFLAB_
	for _, env := range os.Environ() {
		if strings.HasPrefix(env, "TFLAB_") {
			fmt.Fprintln(w, env)
		}
	}

	// metrics :)
	duration := time.Now().Sub(start).Seconds() * 1e3
	requestCount.Inc()
	requestDuration.Observe(duration)
}

// simple golang webserver that
// serves environment variables on http://:8080/
func main() {

	srv := &http.Server{
		Addr:         ":8080",
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 10 * time.Second,
	}
	http.HandleFunc("/", handler)
	http.Handle("/metrics", promhttp.Handler())

	go func(msg string) {
		// log some extraneous words
		for {
			t := time.Now()
			fmt.Println(t.Format("2006-01-02 15:04:05"), msg)
			time.Sleep(10 * time.Second)
		}
	}("heartbeat")
	log.Fatal(srv.ListenAndServe())
}
