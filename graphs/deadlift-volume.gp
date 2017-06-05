#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-volume.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]
set title "Deadlift Volume"

plot \
     csvdir."weekly.csv" using date:(column(deadlift_volume)+column(deadlift_acc_volume)) with boxes axes x1y2 title "deadlift accessory volume",\
     csvdir."weekly.csv" using date:deadlift_volume with boxes axes x1y2 title "deadlift volume",\
     csvdir."weekly.csv" using date:deadlift_e1rm smooth csplines title "deadlift e1rm",\
     csvdir."daily.csv" using date:deadlift_e1rm title "deadlift daily e1rm",\
