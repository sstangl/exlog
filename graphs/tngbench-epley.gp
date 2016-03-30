#!/usr/bin/env gnuplot

load("common.cfg")

set output "tngbench-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Press Epley"

plot \
     csvdir."tngbench-weekly.csv" using date:epley with lines ls 1 title "tng bench week epley",\
     csvdir."tngbench-daily.csv" using date:epley title "",\
     csvdir."pbench-weekly.csv" using date:epley with lines ls 3 title "paused bench week epley",\
