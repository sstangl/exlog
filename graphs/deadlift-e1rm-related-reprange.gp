#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-e1rm-related-reprange.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set xrange ["2015-04-01":]

set title "Deadlift E1RM vs Related Rep Range"

plot \
     csvdir."deadlift-related-weekly.csv" using date:(column(reprange1)+column(reprange3)+column(reprange5)+column(reprange8)) with boxes axes x1y2 title "singles",\
     csvdir."deadlift-related-weekly.csv" using date:(column(reprange3)+column(reprange5)+column(reprange8)) with boxes axes x1y2 title "2-3 reps",\
     csvdir."deadlift-related-weekly.csv" using date:(column(reprange5)+column(reprange8)) with boxes axes x1y2 title "4-6 reps",\
     csvdir."deadlift-related-weekly.csv" using date:(column(reprange8)) with boxes axes x1y2 title "7+ reps",\
     csvdir."deadlift-weekly.csv" using date:e1rm smooth csplines ls 1 title "deadlift week e1rm",\
     csvdir."deadlift-daily.csv" using date:e1rm title "",\
