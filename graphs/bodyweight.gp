#!/usr/bin/env gnuplot

load("common.cfg")

set output "bodyweight.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Bodyweight"

plot \
     csvdir."bodyweight-daily.csv" using 1:2 with lines ls 1 title "daily bodyweight (lbs)"
