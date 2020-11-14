# Overview

A small docker lighttpd alpine:latest to host simple / static websites.

Does not currently have https support turned on, although it exposes port 443 and you can modify the config if you want.

# Usage:
If you connect a volume to the container for the lighttpd config that is empty the startup.sh script copies the default config for the current version of lighttpd into that volume.

Modify the config as you want, and then if you re-start the container with the volume attached you'll get that config back.  Simple.

## docker-compose

<pre>
version: '3'
services:
  lighttpd:
    hostname: lighttpd
    image: kiwichrish/alpine_lighttpd:latest
    environment:
      - TZ=Pacific/Auckland
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - "./lighttpd-data:/var/www/localhost/htdocs"  # You probably only need this one for most things.
      - "./lighttpd-etc:/etc/lighttpd"               # for non-default settings
      - "./lighttpd-logs:/var/log/lighttpd"          # Persistent logs uid/gid = 100:101 for logs
</pre>