# Multi-stage Dockerfile
# This first container will build our static golang binary named webapp
FROM golang:1.10-alpine AS builder
ENV CGO_ENABLED=0 \
    GOARCH=amd64 \
    GOOS=linux
WORKDIR /go/src/tflab/webapp
COPY . .
RUN go install -a \
      --ldflags \
      -extldflags="-static" \
      -installsuffix=netgo \
      -tags=netgo \
      tflab/webapp

# In the second stage, we copy the static binary out of
# the builder and into our new "scratch" container which
# discards the (build) container above
FROM scratch
COPY --from=builder /go/bin/webapp /webapp

# nobody:nobody
USER 65534:65534
ENTRYPOINT ["/webapp"]
