#! /bin/sh

while true 
do
    xsetroot -name  "$(date +"%a %b %d %r")"
    sleep 1s
done &
exec dwm
