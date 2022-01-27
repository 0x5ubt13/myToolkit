FROM alpine:latest

COPY . /usr/local/sbin/

RUN apk update && apk add \ 
    nmap && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "autoNmap" ]