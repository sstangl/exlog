#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-wendler.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Deadlift Wendler"

plot \
     csvdir."deadlift-weekly.csv" using date:wendler with lines ls 1 title "deadlift week wendler",\
     csvdir."deadlift-daily.csv" using date:wendler title "",\
