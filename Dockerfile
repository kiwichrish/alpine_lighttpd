# Lighttpd container
# Chris H <chris@trash.co.nz>

FROM alpine:latest

EXPOSE 80/tcp
EXPOSE 443/tcp

RUN apk add --update --no-cache lighttpd curl \
    && mkdir /etc/lighttpd.dist \
    && mv /etc/lighttpd/* /etc/lighttpd.dist/

ADD startup.sh /startup.sh
ADD index.html /var/www/localhost/htdocs/index.html

# the html root.
VOLUME /var/www/localhost/htdocs

# Check every minute if lighttpd responds within 1 second and update
# container health status accordingly.
HEALTHCHECK --interval=1m --timeout=1s \
  CMD curl -f http://localhost/ || exit 1

# settings dir.  if you mount a volume then the config is written here and you can edit.
VOLUME /etc/lighttpd

# log dir, just in case you want logging outside the container
VOLUME /var/log/lighttpd

ENTRYPOINT ["/startup.sh"]
