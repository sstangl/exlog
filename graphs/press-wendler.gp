#!/usr/bin/env gnuplot

load("common.cfg")

set output "press-wendler.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Press Wendler"

plot \
     csvdir."press-weekly.csv" using date:wendler with lines ls 1 title "press week wendler",\
     csvdir."press-daily.csv" using date:wendler title "",\
