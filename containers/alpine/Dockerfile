# jonpulsifer/alpine:tflab
FROM alpine:latest
ARG USER=tflab
RUN addgroup -g 1000 -S ${USER} && \
    adduser  -u 1000 -S ${USER} -G ${USER}

RUN apk --no-cache update \
 && apk --no-cache upgrade \
 && apk add sudo

RUN echo "${USER}    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/${USER}
USER 1000:1000
