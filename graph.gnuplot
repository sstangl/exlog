set xdata time
set timefmt "%Y-%m-%d"
set style data points

# Sadly JPG looks a lot better than non-antialiased PNG.
set terminal jpeg size 1000,600 enhanced
set output "output.jpg"

set y2tics

#set y2range [0:]
set xrange ["2015-04-01":]

plot "csv-data/squat-weekly-e1rm.csv" using 1:2 smooth csplines title "squat week e1rm",\
     "csv-data/squat-daily-e1rm.csv" using 1:2 title "squat daily e1rm",\
     "csv-data/squat-weekly-tonnage.csv" using 1:2 with boxes axes x1y2 title "squat week tonnage"
