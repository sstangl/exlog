set xdata time
set timefmt "%Y-%m-%d"
set style data points

set terminal png size 1000,600 enhanced
set output "output.png"

set y2tics

set yrange [340:]

plot "csv-data/pbench-weekly-e1rm.csv" using 1:2 smooth csplines,\
     "csv-data/pbench-weekly-volume.csv" using 1:2 smooth csplines axes x1y2
