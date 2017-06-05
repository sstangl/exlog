#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-fatigue.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Squat Fatigue"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(squat_fatigue)+column(squat_acc_fatigue)) with boxes axes x1y2 title "squat accessory fatigue",\
     csvdir."weekly.csv" using date:squat_fatigue with boxes axes x1y2 title "squat fatigue",\
     csvdir."weekly.csv" using date:squat_e1rm smooth csplines ls 8 title "squat e1rm",\
     csvdir."daily.csv" using date:squat_e1rm title "squat daily e1rm",\
