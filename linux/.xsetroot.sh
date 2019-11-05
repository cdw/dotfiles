#!/bin/bash
DATE=$(date +"%-m/%d %-l:%M%P")
LOAD=$(cut -d ' ' -f 1-3 /proc/loadavg | sed 's/\([0-9]\.[0-9]\)[0-9]/\1/g')
MEM=$(free | grep Mem | awk '{printf "%03.1f%\n", $3/$2 * 100.0}')
BAT=$(acpi -b | cut -d : -f 2 | sed -e 's/ //g' -e 's/,/ /')
xsetroot -name "| L:${LOAD} | M:${MEM} | B:${BAT} | ${DATE} |"

