#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-repranges.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Squat Main Lift Rep Ranges"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(squat_reps8)+column(squat_reps5)+column(squat_reps3)+column(squat_reps1)) with boxes axes x1y2 title "squat 1 reps",\
     csvdir."weekly.csv" using date:(column(squat_reps8)+column(squat_reps5)+column(squat_reps3)) with boxes axes x1y2 title "squat 2-3 reps",\
     csvdir."weekly.csv" using date:(column(squat_reps8)+column(squat_reps5)) with boxes axes x1y2 title "squat 4-6 reps",\
     csvdir."weekly.csv" using date:squat_reps8 with boxes axes x1y2 title "squat 7+ reps",\
     csvdir."weekly.csv" using date:squat_e1rm smooth csplines ls 8 title "squat e1rm",\
