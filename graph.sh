#!/bin/sh
cat << STOP
<!doctype html>
<html lang="en-US">
  <head>
    <meta charset="utf-8" />
    <title>System status</title>
    <meta name="viewport" content="width=device-width" />
  </head>
  <body>
STOP
# rrdtool reuses SVG element IDs across multiple invocations, so we need to prefix them with strings unique to each graph to make the IDs unique (otherwise the texts are corrputed)
rrdtool graph - -a SVG --title "cpu usage" --vertical-label "%core" -l 0 DEF:lighthousecpu=resource.rrd:lighthousecpu:AVERAGE DEF:rethcpu=resource.rrd:rethcpu:AVERAGE CDEF:totalcpu=lighthousecpu,rethcpu,+ AREA:rethcpu#0000ff:"reth\n" STACK:lighthousecpu#00ff00:"lighthouse\n" LINE0.5:totalcpu#000000:"total\n" | sed 's/glyph/glyph-img0/g'

rrdtool graph - -a SVG --title "mem usage" --vertical-label "GB" -l 0 DEF:lighthousemem=resource.rrd:lighthousemem:AVERAGE DEF:rethmem=resource.rrd:rethmem:AVERAGE CDEF:totalmem=lighthousemem,rethmem,+ VDEF:currlighthousemem=lighthousemem,LAST VDEF:currrethmem=rethmem,LAST VDEF:currtotalmem=totalmem,LAST AREA:rethmem#0000ff:"reth\t\t" GPRINT:currrethmem:"%.0lf GB\n" STACK:lighthousemem#00ff00:"lighthouse\t" GPRINT:currlighthousemem:"%.0lf\n" LINE0.5:totalmem#000000:"total\t\t" GPRINT:currtotalmem:"%.0lf\n" | sed 's/glyph/glyph-img1/g'

rrdtool graph - -a SVG --title "disk io" --vertical-label "MB/s" -l 0 DEF:diskread=resource.rrd:diskread:AVERAGE DEF:diskwrite=resource.rrd:diskwrite:AVERAGE CDEF:writemb=diskwrite,1024,/ CDEF:readmb=diskread,1024,/ CDEF:totalmb=writemb,readmb,+ AREA:readmb#0000ff:"read\n" STACK:writemb#ff0000:"write\n" LINE0.5:totalmb#000000:"total\n" | sed 's/glyph/glyph-img4/g'

rrdtool graph - -a SVG -A -Y --title "reth progress" --vertical-label "blocks" DEF:reth=progress.rrd:reth:MAX DEF:block=progress.rrd:rethblock:MAX DEF:execution=progress.rrd:rethexec:MAX VDEF:rethprog=reth,LAST VDEF:rethblock=block,LAST VDEF:rethexec=execution,LAST LINE1:block#ff0000:"download\t" GPRINT:rethblock:"%.0lf blocks\n" LINE1:execution#00ff00:"execute\t" GPRINT:rethexec:"%.0lf\n" LINE1:reth#0000ff:"finish\t" GPRINT:rethprog:"%.0lf\n" | sed 's/glyph/glyph-img2/g'

rrdtool graph - -a SVG -A -Y --title "lighthouse progress" --vertical-label "beacon slots" DEF:lighthouse=progress.rrd:lighthouse:MAX VDEF:lighthouseprog=lighthouse,MAXIMUM LINE1:lighthouse#0000ff:"finish\t" GPRINT:lighthouseprog:"%.0lf slots\n" | sed 's/glyph/glyph-img3/g'

cat << STOP
</body>
</html>
STOP
