FROM alpine:latest

COPY ./autoNmap_minimal /usr/local/sbin/autoNmap

RUN apk update && apk add --no-cache \
    nmap \
    nmap-scripts && \
    rm -f /tmp/* /etc/apk/cache/*

ENTRYPOINT [ "autoNmap" ]