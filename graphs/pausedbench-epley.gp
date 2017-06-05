#!/usr/bin/env gnuplot

load("common.cfg")

set output "pausedbench-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Paused Bench Epley and Wilks"

plot \
     csvdir."weekly.csv" using date:pausedbench_epley with lines title "pausedbench epley",\
     csvdir."weekly.csv" using date:pausedbench_epley_wilks with lines axis x1y2 title "pausedbench wilks",\
