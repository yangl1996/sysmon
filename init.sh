rrdtool create resource.rrd --step 1 DS:rethmem:GAUGE:10:0:3072 DS:rethcpu:GAUGE:10:0:100 DS:lighthousemem:GAUGE:10:0:3072 DS:lighthousecpu:GAUGE:10:0:100 RRA:AVERAGE:0.5:1:86400 RRA:AVERAGE:0.5:60:43200 RRA:AVERAGE:0.5:3600:8760 

rrdtool create progress.rrd --step 1 DS:lighthouse:GAUGE:10:0:U DS:rethblock:GAUGE:10:0:U DS:rethexec:GAUGE:10:0:U DS:reth:GAUGE:10:0:U RRA:MAX:0.5:10:8640 RRA:MAX:0.5:60:43200 RRA:MAX:0.5:3600:8760
