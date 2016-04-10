#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-epley-volume.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "Squat Epley (Fixed) with Volume"

plot \
     csvdir."squat-weekly.csv" using date:epley with lines ls 1 title "squat week epley",\
     csvdir."squat-daily.csv" using date:epley title "",\
     csvdir."squat-related-weekly.csv" using date:volume with boxes ls 6 title "squat-related volume",
