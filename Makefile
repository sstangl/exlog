csv: csv-data
	./gen-graph-csv squat daily e1rm > csv-data/squat-daily-e1rm.csv
	./gen-graph-csv deadlift daily e1rm > csv-data/deadlift-daily-e1rm.csv
	./gen-graph-csv "paused bench" daily e1rm > csv-data/pbench-daily-e1rm.csv
	./gen-graph-csv squat daily volume > csv-data/squat-daily-volume.csv
	./gen-graph-csv deadlift daily volume > csv-data/deadlift-daily-volume.csv
	./gen-graph-csv "paused bench" daily volume > csv-data/pbench-daily-volume.csv
	./gen-graph-csv squat daily tonnage > csv-data/squat-daily-tonnage.csv
	./gen-graph-csv deadlift daily tonnage > csv-data/deadlift-daily-tonnage.csv
	./gen-graph-csv "paused bench" daily tonnage > csv-data/pbench-daily-tonnage.csv
	./gen-graph-csv squat weekly e1rm > csv-data/squat-weekly-e1rm.csv
	./gen-graph-csv deadlift weekly e1rm > csv-data/deadlift-weekly-e1rm.csv
	./gen-graph-csv "paused bench" weekly e1rm > csv-data/pbench-weekly-e1rm.csv
	./gen-graph-csv squat weekly volume > csv-data/squat-weekly-volume.csv
	./gen-graph-csv deadlift weekly volume > csv-data/deadlift-weekly-volume.csv
	./gen-graph-csv "paused bench" weekly volume > csv-data/pbench-weekly-volume.csv
	./gen-graph-csv squat weekly tonnage > csv-data/squat-weekly-tonnage.csv
	./gen-graph-csv deadlift weekly tonnage > csv-data/deadlift-weekly-tonnage.csv
	./gen-graph-csv "paused bench" weekly tonnage > csv-data/pbench-weekly-tonnage.csv


csv-data:
	mkdir csv-data

clean:
	rm -rf __pycache__
	rm -rf csv-data
