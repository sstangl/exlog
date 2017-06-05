#!/usr/bin/env gnuplot

load("common.cfg")

set output "pausedbench-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Paused Bench Epley"

plot \
     csvdir."weekly.csv" using date:pausedbench_epley with lines ls 1 title "pausedbench epley",\
     csvdir."daily.csv" using date:pausedbench_epley title "",\
