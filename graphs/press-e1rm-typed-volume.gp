#!/usr/bin/env gnuplot

load("common.cfg")

set output "press-e1rm-typed-volume.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

set title "Press E1RM vs Typed Volume"

plot \
     csvdir."press-related-weekly.csv" using date:(column(typevolumeyang)+column(typevolumeyin)) with boxes axes x1y2 title "Bench-Type Volume",\
     csvdir."press-related-weekly.csv" using date:(column(typevolumeyin)) with boxes axes x1y2 title "Press-Type Volume",\
     csvdir."press-weekly.csv" using date:e1rm smooth csplines ls 1 title "press week e1rm",\
     csvdir."press-daily.csv" using date:e1rm title "",\
