#!/usr/bin/env gnuplot

load("common.cfg")

set output "pbench-e1rm-tonnage-related.jpg"

set y2tics
set xrange ["2015-04-01":]

plot csvdir."pbench-weekly.csv" using date:e1rm smooth csplines title "pbench week e1rm",\
     csvdir."pbench-daily.csv" using date:e1rm title "pbench daily e1rm",\
     csvdir."pbench-related-weekly.csv" using date:tonnage with boxes axes x1y2 title "pbench-related week tonnage"
