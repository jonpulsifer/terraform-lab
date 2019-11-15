# jonpulsifer/tflab:alpine
FROM alpine:latest
ARG USER=${USER:-tflab}
ARG UID=${UID:-1337}

RUN addgroup -g ${UID} -S ${USER} \
 && adduser  -u ${UID} -S ${USER} -G ${USER}

RUN apk --no-cache upgrade \
 && apk add sudo

RUN echo "${USER}    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/${USER}
USER ${UID}:${UID}
