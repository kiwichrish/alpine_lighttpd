#!/bin/ash
set -e

echo "=========== Check config location"
FILE=/etc/lighttpd/lighttpd.conf
if [ -f "$FILE" ]; then
    echo "=========== Config is there, do nothing"
else 
    echo "=========== Config not found, assuming defaults"
    cp /etc/lighttpd.dist/* /etc/lighttpd
fi

# Launch lighttpd
echo "=========== Start lighttpd"
exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
