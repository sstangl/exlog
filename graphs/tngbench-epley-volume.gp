#!/usr/bin/env gnuplot

load("common.cfg")

set output "tngbench-epley-related-volume.jpg"

set style line 1 linewidth 2
set style fill solid 0.25 border

set y2tics

set title "TnG Bench Epley and Related Volume"

plot \
     csvdir."tngbench-weekly.csv" using date:epley with lines ls 1 title "tng bench week epley",\
     csvdir."pbench-related-weekly.csv" using date:(column(typevolumeyang)+column(typevolumeyin)) with boxes ls 6 axes x1y2 title "Press-Type Volume",\
     csvdir."pbench-related-weekly.csv" using date:typevolumeyin with boxes ls 8 axes x1y2 title "Bench-Type Volume",\
