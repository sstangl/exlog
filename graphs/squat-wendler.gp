#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-wendler.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Squat Wendler"

plot \
     csvdir."squat-weekly.csv" using date:wendler with lines ls 1 title "squat week wendler",\
     csvdir."squat-daily.csv" using date:wendler title "",\
