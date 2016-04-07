#!/usr/bin/env gnuplot

load("common.cfg")

set output "pbench-e1rm-related-rpes.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

set title "Paused Bench E1RM vs RPE volume"

plot \
     csvdir."pbench-related-weekly.csv" using date:(column(rperange10)+column(rperange9)+column(rperange8)+column(rperange7)) with boxes axes x1y2 title "10RPE",\
     csvdir."pbench-related-weekly.csv" using date:(column(rperange9)+column(rperange8)+column(rperange7)) with boxes axes x1y2 title "9RPE",\
     csvdir."pbench-related-weekly.csv" using date:(column(rperange8)+column(rperange7)) with boxes axes x1y2 title "8RPE",\
     csvdir."pbench-related-weekly.csv" using date:(column(rperange7)) with boxes axes x1y2 title "7RPE",\
     csvdir."pbench-weekly.csv" using date:e1rm smooth csplines ls 1 title "pbench week e1rm",\
     csvdir."pbench-daily.csv" using date:e1rm title "",\
