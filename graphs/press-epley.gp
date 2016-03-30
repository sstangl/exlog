#!/usr/bin/env gnuplot

load("common.cfg")

set output "press-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Press Epley"

plot \
     csvdir."press-weekly.csv" using date:epley with lines ls 1 title "press week epley",\
     csvdir."press-daily.csv" using date:epley title "",\
