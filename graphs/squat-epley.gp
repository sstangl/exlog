#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Squat Epley"

plot \
     csvdir."weekly.csv" using date:squat_epley with lines ls 1 title "squat epley",\
     csvdir."daily.csv" using date:squat_epley title "",\
