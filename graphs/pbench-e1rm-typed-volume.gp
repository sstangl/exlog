#!/usr/bin/env gnuplot

load("common.cfg")

set output "pbench-e1rm-typed-volume.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

set title "PBench E1RM vs Typed Volume"

plot \
     csvdir."pbench-related-weekly.csv" using date:(column(typevolumeyang)+column(typevolumeyin)) with boxes axes x1y2 title "Press-Type Volume",\
     csvdir."pbench-related-weekly.csv" using date:(column(typevolumeyin)) with boxes axes x1y2 title "Bench-Type Volume",\
     csvdir."pbench-weekly.csv" using date:e1rm smooth csplines ls 1 title "pbench week e1rm",\
     csvdir."pbench-daily.csv" using date:e1rm title "",\
