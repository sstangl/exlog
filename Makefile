CSVDIR = csv-data

all: csv csv-related graphs

csv: $(CSVDIR) exlog
	./gen-graph-csv squat daily all > $(CSVDIR)/squat-daily.csv
	./gen-graph-csv deadlift daily all > $(CSVDIR)/deadlift-daily.csv
	./gen-graph-csv press daily all > $(CSVDIR)/press-daily.csv
	./gen-graph-csv "paused bench" daily all > $(CSVDIR)/pbench-daily.csv
	./gen-graph-csv squat weekly all > $(CSVDIR)/squat-weekly.csv
	./gen-graph-csv deadlift weekly all > $(CSVDIR)/deadlift-weekly.csv
	./gen-graph-csv press weekly all > $(CSVDIR)/press-weekly.csv
	./gen-graph-csv "paused bench" weekly all > $(CSVDIR)/pbench-weekly.csv

csv-related: $(CSVDIR) exlog
	./gen-graph-csv -i squat daily all > $(CSVDIR)/squat-related-daily.csv
	./gen-graph-csv -i deadlift daily all > $(CSVDIR)/deadlift-related-daily.csv
	./gen-graph-csv -i press daily all > $(CSVDIR)/press-related-daily.csv
	./gen-graph-csv -i "paused bench" daily all > $(CSVDIR)/pbench-related-daily.csv
	./gen-graph-csv -i squat weekly all > $(CSVDIR)/squat-related-weekly.csv
	./gen-graph-csv -i deadlift weekly all > $(CSVDIR)/deadlift-related-weekly.csv
	./gen-graph-csv -i press weekly all > $(CSVDIR)/press-related-weekly.csv
	./gen-graph-csv -i "paused bench" weekly all > $(CSVDIR)/pbench-related-weekly.csv

$(CSVDIR):
	mkdir $(CSVDIR)

graphs: csv
	$(MAKE) -C graphs

clean:
	rm -rf __pycache__
	rm -rf $(CSVDIR)
	$(MAKE) -C graphs clean
