#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Squat Epley and Wilks"

plot \
     csvdir."weekly.csv" using date:squat_epley with lines title "squat epley",\
     csvdir."weekly.csv" using date:squat_epley_wilks with lines axis x1y2 title "squat wilks",\
