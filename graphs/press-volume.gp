#!/usr/bin/env gnuplot

load("common.cfg")

set output "press-volume.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Press Volume"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(press_volume)+column(press_acc_volume)) with boxes axes x1y2 title "press accessory volume",\
     csvdir."weekly.csv" using date:press_volume with boxes axes x1y2 title "press volume",\
     csvdir."weekly.csv" using date:press_e1rm smooth csplines title "press e1rm",\
     csvdir."daily.csv" using date:press_e1rm title "press daily e1rm",\
