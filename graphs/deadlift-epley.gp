#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Deadlift Epley and Wilks"

plot \
     csvdir."weekly.csv" using date:deadlift_epley with lines title "deadlift epley",\
     csvdir."weekly.csv" using date:deadlift_epley_wilks with lines axis x1y2 title "deadlift wilks",\
