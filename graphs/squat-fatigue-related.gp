#!/usr/bin/env gnuplot

load("common.cfg")

set output "squat-fatigue-related.jpg"

set y2tics

set xrange ["2015-04-01":]

plot csvdir."squat-weekly.csv" using date:e1rm smooth csplines title "squat week e1rm",\
     csvdir."squat-daily.csv" using date:e1rm title "squat daily e1rm",\
     csvdir."squat-related-weekly.csv" using date:fatigue with boxes axes x1y2 title "squat-related week fatigue",\
     csvdir."squat-related-daily.csv" using date:fatigue axes x1y2 title "squat-related daily fatigue"
