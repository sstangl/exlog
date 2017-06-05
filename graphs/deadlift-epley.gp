#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Deadlift Epley"

plot \
     csvdir."weekly.csv" using date:deadlift_epley with lines ls 1 title "deadlift epley",\
     csvdir."daily.csv" using date:deadlift_epley title "",\
