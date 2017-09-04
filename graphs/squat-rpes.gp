#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-rpes.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Squat Main Lift Set RPEs"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(squat_rpe10)+column(squat_rpe9)+column(squat_rpe8)+column(squat_rpe7)+column(squat_rpe6)) with boxes axes x1y2 title "squat RPE 10",\
     csvdir."weekly.csv" using date:(column(squat_rpe9)+column(squat_rpe8)+column(squat_rpe7)+column(squat_rpe6)) with boxes axes x1y2 title "squat RPE 9",\
     csvdir."weekly.csv" using date:(column(squat_rpe8)+column(squat_rpe7)+column(squat_rpe6)) with boxes axes x1y2 title "squat RPE 8",\
     csvdir."weekly.csv" using date:(column(squat_rpe7)+column(squat_rpe6)) with boxes axes x1y2 title "squat RPE 7",\
     csvdir."weekly.csv" using date:(column(squat_rpe6)) with boxes axes x1y2 title "squat RPE 6",\
     csvdir."weekly.csv" using date:squat_e1rm smooth csplines ls 8 title "squat e1rm",\
