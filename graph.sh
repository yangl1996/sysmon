#!/bin/sh
rrdtool graph cpu.png --title "cpu usage" --vertical-label "%core" DEF:lighthousecpu=resource.rrd:lighthousecpu:AVERAGE DEF:rethcpu=resource.rrd:rethcpu:AVERAGE AREA:rethcpu#0000ff:"reth" STACK:lighthousecpu#00ff00:"lighthouse"

rrdtool graph mem.png --title "mem usage" --vertical-label "GB" DEF:lighthousemem=resource.rrd:lighthousemem:AVERAGE DEF:rethmem=resource.rrd:rethmem:AVERAGE AREA:rethmem#0000ff:"reth" STACK:lighthousemem#00ff00:"lighthouse"

rrdtool graph reth.png -A -Y --title "reth progress" --vertical-label "blocks" DEF:reth=progress.rrd:reth:MAX DEF:block=progress.rrd:rethblock:MAX DEF:execution=progress.rrd:rethexec:MAX VDEF:rethprog=reth,MAXIMUM VDEF:rethblock=block,MAXIMUM VDEF:rethexec=execution,MAXIMUM LINE1:block#ff0000:"download\t" GPRINT:rethblock:"%.0lf blocks\n" LINE1:execution#00ff00:"execute\t" GPRINT:rethexec:"%.0lf\n" LINE1:reth#0000ff:"finish\t" GPRINT:rethprog:"%.0lf\n"

rrdtool graph lighthouse.png -A -Y --title "lighthouse progress" --vertical-label "beacon slots" DEF:lighthouse=progress.rrd:lighthouse:MAX VDEF:lighthouseprog=lighthouse,MAXIMUM LINE1:lighthouse#0000ff:"finish\t" GPRINT:lighthouseprog:"%.0lf slots\n"
