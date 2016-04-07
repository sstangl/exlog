#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-e1rm-tonnage.jpg"

set y2tics

set xrange [RPESTARTDATE:]

plot csvdir."squat-weekly.csv" using date:e1rm smooth csplines title "squat week e1rm",\
     csvdir."squat-daily.csv" using date:e1rm title "squat daily e1rm",\
     csvdir."squat-weekly.csv" using date:tonnage with boxes axes x1y2 title "squat week tonnage",\
     csvdir."squat-daily.csv" using date:tonnage axes x1y2 title "squat daily tonnage"
