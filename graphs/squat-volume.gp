#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-volume.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Squat Volume"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(squat_volume)+column(squat_acc_volume)) with boxes axes x1y2 title "squat accessory volume",\
     csvdir."weekly.csv" using date:squat_volume with boxes axes x1y2 title "squat volume",\
     csvdir."weekly.csv" using date:squat_e1rm smooth csplines title "squat e1rm",\
     csvdir."daily.csv" using date:squat_e1rm title "squat daily e1rm",\
