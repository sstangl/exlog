#!/usr/bin/env gnuplot

load("common.cfg")

set output "deadlift-e1rm-tonnage-related.jpg"

set y2tics

set xrange ["2015-04-01":]

plot csvdir."deadlift-weekly.csv" using date:e1rm smooth csplines title "deadlift week e1rm",\
     csvdir."deadlift-daily.csv" using date:e1rm title "deadlift daily e1rm",\
     csvdir."deadlift-related-weekly.csv" using date:tonnage with boxes axes x1y2 title "deadlift-related week tonnage"
