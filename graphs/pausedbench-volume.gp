#!/usr/bin/env gnuplot

load("common.cfg")

set output "pausedbench-volume.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]
set title "Paused Bench Volume"

plot \
     csvdir."weekly.csv" using date:(column(pausedbench_volume)+column(pausedbench_acc_volume)) with boxes axes x1y2 title "pausedbench accessory volume",\
     csvdir."weekly.csv" using date:pausedbench_volume with boxes axes x1y2 title "pausedbench volume",\
     csvdir."weekly.csv" using date:pausedbench_e1rm smooth csplines ls 8 title "pausedbench e1rm",\
     csvdir."daily.csv" using date:pausedbench_e1rm title "pausedbench daily e1rm",\
