#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-e1rm-typed-volume.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

set title "Squat E1RM vs Typed Volume"

plot \
     csvdir."squat-related-weekly.csv" using date:(column(typevolumeyang)+column(typevolumeyin)) with boxes axes x1y2 title "DL-Type Volume",\
     csvdir."squat-related-weekly.csv" using date:(column(typevolumeyin)) with boxes axes x1y2 title "Squat-Type Volume",\
     csvdir."squat-weekly.csv" using date:e1rm smooth csplines ls 1 title "squat week e1rm",\
     csvdir."squat-daily.csv" using date:e1rm title "",\
