#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-rpes.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Deadlift Main Lift Set RPEs"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(deadlift_rpe10)+column(deadlift_rpe9)+column(deadlift_rpe8)+column(deadlift_rpe7)+column(deadlift_rpe6)) with boxes axes x1y2 title "deadlift RPE 10",\
     csvdir."weekly.csv" using date:(column(deadlift_rpe9)+column(deadlift_rpe8)+column(deadlift_rpe7)+column(deadlift_rpe6)) with boxes axes x1y2 title "deadlift RPE 9",\
     csvdir."weekly.csv" using date:(column(deadlift_rpe8)+column(deadlift_rpe7)+column(deadlift_rpe6)) with boxes axes x1y2 title "deadlift RPE 8",\
     csvdir."weekly.csv" using date:(column(deadlift_rpe7)+column(deadlift_rpe6)) with boxes axes x1y2 title "deadlift RPE 7",\
     csvdir."weekly.csv" using date:(column(deadlift_rpe6)) with boxes axes x1y2 title "deadlift RPE 6",\
     csvdir."weekly.csv" using date:deadlift_e1rm smooth csplines ls 8 title "deadlift e1rm",\
