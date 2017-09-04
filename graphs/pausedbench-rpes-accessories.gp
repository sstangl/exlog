#!/usr/bin/env gnuplot

load("common.cfg")

set output "pausedbench-rpes-accessories.jpg"

set style line 1 linewidth 3
set style fill solid 0.25 border

set y2tics

set title "Paused Bench Main Lift and Accessory Set RPEs"
set xrange [RPESTARTDATE:]

plot \
     csvdir."weekly.csv" using date:(column(pausedbench_rpe10)+column(pausedbench_acc_rpe10)+column(pausedbench_rpe9)+column(pausedbench_acc_rpe9)+column(pausedbench_rpe8)+column(pausedbench_acc_rpe8)+column(pausedbench_rpe7)+column(pausedbench_acc_rpe7)+column(pausedbench_rpe6)+column(pausedbench_acc_rpe6)) with boxes axes x1y2 title "pausedbench and acc RPE 10",\
     csvdir."weekly.csv" using date:(column(pausedbench_rpe9)+column(pausedbench_acc_rpe9)+column(pausedbench_rpe8)+column(pausedbench_acc_rpe8)+column(pausedbench_rpe7)+column(pausedbench_acc_rpe7)+column(pausedbench_rpe6)+column(pausedbench_acc_rpe6)) with boxes axes x1y2 title "pausedbench and acc RPE 9",\
     csvdir."weekly.csv" using date:(column(pausedbench_rpe8)+column(pausedbench_acc_rpe8)+column(pausedbench_rpe7)+column(pausedbench_acc_rpe7)+column(pausedbench_rpe6)+column(pausedbench_acc_rpe6)) with boxes axes x1y2 title "pausedbench and acc RPE 8",\
     csvdir."weekly.csv" using date:(column(pausedbench_rpe7)+column(pausedbench_acc_rpe7)+column(pausedbench_rpe6)+column(pausedbench_acc_rpe6)) with boxes axes x1y2 title "pausedbench and acc RPE 7",\
     csvdir."weekly.csv" using date:(column(pausedbench_rpe6)+column(pausedbench_acc_rpe6)) with boxes axes x1y2 title "pausedbench and acc RPE 6",\
     csvdir."weekly.csv" using date:pausedbench_e1rm smooth csplines ls 8 title "pausedbench e1rm",\
