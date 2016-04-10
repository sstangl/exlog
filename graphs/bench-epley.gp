#!/usr/bin/env gnuplot

load("common.cfg")

set output "pbench-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Paused Bench Epley"

plot \
     csvdir."pbench-weekly.csv" using date:epley with lines ls 1 title "pbench week epley",\
     csvdir."pbench-daily.csv" using date:epley title "",\
