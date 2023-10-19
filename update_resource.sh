#!/bin/sh

rethusage=`ps -p $(pgrep reth) -o "%cpu rss" | tail -1`
rethmem=`echo $rethusage | cut -f2 -d' '`
rethmemgb=`expr $rethmem / 1024 / 1024`
rethcpu=`echo $rethusage | cut -f1 -d' '`
lighthouseusage=`ps -p $(pgrep lighthouse) -o "%cpu rss" | tail -1`
lighthousemem=`echo $lighthouseusage | cut -f2 -d' '`
lighthousememgb=`expr $lighthousemem / 1024 / 1024`
lighthousecpu=`echo $lighthouseusage | cut -f1 -d' '`
diskio=`iostat -I -d -x da3 da4 | tail -2`
diskread=`echo "$diskio" | awk '{sum += $4} END {print sum}'`
diskwrite=`echo "$diskio" | awk '{sum += $5} END {print sum}'`

rrdtool update resource.rrd N:$rethmemgb:$rethcpu:$lighthousememgb:$lighthousecpu:$diskread:$diskwrite
