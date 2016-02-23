#!/usr/bin/env gnuplot

load("common.cfg")

set output "pbench-fatigue-related.jpg"

set y2tics

set xrange ["2015-04-01":]

plot csvdir."pbench-weekly.csv" using date:e1rm smooth csplines title "pbench week e1rm",\
     csvdir."pbench-daily.csv" using date:e1rm title "pbench daily e1rm",\
     csvdir."pbench-related-weekly.csv" using date:fatigue with boxes axes x1y2 title "pbench-related week fatigue",\
     csvdir."pbench-related-daily.csv" using date:fatigue axes x1y2 title "pbench-related daily fatigue",\
