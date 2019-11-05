#!/bin/bash

xrdb -merge .Xresources
setxkbmap -option caps:escape  # switch caps lock for esc
dropbox start &
tpb &
#xset fp+ /usr/local/share/fonts/misc/ &
#xset fp rehash &

if [ -x /usr/bin/xfce4-power-manager ] ; then
   sleep 1
   xfce4-power-manager &
fi

while true; do
    sh .xsetroot.sh
    sleep 10
done &

exec dwm

