#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-e1rm-related-rpes.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

set title "Squat E1RM vs RPE volume"

plot \
     csvdir."squat-related-weekly.csv" using date:(column(rperange10)+column(rperange9)+column(rperange8)+column(rperange7)) with boxes axes x1y2 title "10RPE",\
     csvdir."squat-related-weekly.csv" using date:(column(rperange9)+column(rperange8)+column(rperange7)) with boxes axes x1y2 title "9RPE",\
     csvdir."squat-related-weekly.csv" using date:(column(rperange8)+column(rperange7)) with boxes axes x1y2 title "8RPE",\
     csvdir."squat-related-weekly.csv" using date:(column(rperange7)) with boxes axes x1y2 title "7RPE",\
     csvdir."squat-weekly.csv" using date:e1rm smooth csplines ls 1 title "squat week e1rm",\
     csvdir."squat-daily.csv" using date:e1rm title "",\
