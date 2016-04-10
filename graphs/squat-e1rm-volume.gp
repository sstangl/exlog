#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-e1rm-volume.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

plot \
     csvdir."squat-weekly.csv" using date:volume with boxes axes x1y2 title "squat week volume",\
     csvdir."squat-daily.csv" using date:volume axes x1y2 title "squat daily volume",\
     csvdir."squat-weekly.csv" using date:e1rm smooth csplines title "squat week e1rm",\
     csvdir."squat-daily.csv" using date:e1rm title "squat daily e1rm",\
