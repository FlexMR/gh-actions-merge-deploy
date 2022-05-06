FROM alpine:latest

RUN apk --no-cache add bash curl git

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
