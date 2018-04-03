package main

import (
	"github.com/prometheus/client_golang/prometheus"
)

const (
	namespace = "tflab_webapp"
	subsystem = "http"
)

var (
	requestCount = prometheus.NewCounter(prometheus.CounterOpts{
		Namespace: namespace,
		Subsystem: subsystem,
		Name:      "request_count_total",
		Help:      "Counter of HTTP requests made.",
	})

	requestDuration = prometheus.NewHistogram(prometheus.HistogramOpts{
		Namespace: namespace,
		Subsystem: subsystem,
		Name:      "request_duration_milliseconds",
		Help:      "Histogram of the time (in milliseconds) each request took.",
		Buckets:   append([]float64{.001, .003}, prometheus.DefBuckets...),
	})
)
