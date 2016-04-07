#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-e1rm-related-reprange.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange [RPESTARTDATE:]

set title "Squat E1RM vs Related Rep Range"

plot \
     csvdir."squat-related-weekly.csv" using date:(column(reprange1)+column(reprange3)+column(reprange5)+column(reprange8)) with boxes axes x1y2 title "singles",\
     csvdir."squat-related-weekly.csv" using date:(column(reprange3)+column(reprange5)+column(reprange8)) with boxes axes x1y2 title "2-3 reps",\
     csvdir."squat-related-weekly.csv" using date:(column(reprange5)+column(reprange8)) with boxes axes x1y2 title "4-6 reps",\
     csvdir."squat-related-weekly.csv" using date:(column(reprange8)) with boxes axes x1y2 title "7+ reps",\
     csvdir."squat-weekly.csv" using date:e1rm smooth csplines ls 1 title "squat week e1rm",\
     csvdir."squat-daily.csv" using date:e1rm title "",\
