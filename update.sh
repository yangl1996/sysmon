rethusage=`ps -p $(pgrep reth) -o "%cpu rss" | tail -1`
rethmem=`echo $rethusage | cut -f2 -d' '`
rethmemgb=`expr $rethmem / 1024 / 1024`
rethcpu=`echo $rethusage | cut -f1 -d' '`
lighthouseusage=`ps -p $(pgrep lighthouse) -o "%cpu rss" | tail -1`
lighthousemem=`echo $lighthouseusage | cut -f2 -d' '`
lighthousememgb=`expr $lighthousemem / 1024 / 1024`
lighthousecpu=`echo $lighthouseusage | cut -f1 -d' '`
rrdtool update resource.rrd N:$rethmemgb:$rethcpu:$lighthousememgb:$lighthousecpu
