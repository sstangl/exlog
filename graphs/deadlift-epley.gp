#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-epley.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Deadlift Epley"

plot \
     csvdir."deadlift-weekly.csv" using date:epley with lines ls 1 title "deadlift week epley",\
     csvdir."deadlift-daily.csv" using date:epley title "",\
