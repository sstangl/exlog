#!/usr/bin/env gnuplot

load("common.cfg")

set output "press-e1rm-tonnage-related.jpg"

set y2tics
set xrange [RPESTARTDATE:]

plot csvdir."press-weekly.csv" using date:e1rm smooth csplines title "press week e1rm",\
     csvdir."press-daily.csv" using date:e1rm title "press daily e1rm",\
     csvdir."press-related-weekly.csv" using date:tonnage with boxes axes x1y2 title "press-related week tonnage"
