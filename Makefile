CSVDIR = csv-data

all: csv-main csv-related graphs

csv: csv-main csv-related csv-misc

csv-main: $(CSVDIR) exlog
	./gen-graph-csv daily all -l squat > $(CSVDIR)/squat-daily.csv
	./gen-graph-csv daily all -l deadlift > $(CSVDIR)/deadlift-daily.csv
	./gen-graph-csv daily all -l press > $(CSVDIR)/press-daily.csv
	./gen-graph-csv daily all -l "paused bench" > $(CSVDIR)/pbench-daily.csv
	./gen-graph-csv weekly all -l squat > $(CSVDIR)/squat-weekly.csv
	./gen-graph-csv weekly all -l deadlift > $(CSVDIR)/deadlift-weekly.csv
	./gen-graph-csv weekly all -l press > $(CSVDIR)/press-weekly.csv
	./gen-graph-csv weekly all -l "paused bench" > $(CSVDIR)/pbench-weekly.csv

csv-related: $(CSVDIR) exlog
	./gen-graph-csv daily all -i -l squat > $(CSVDIR)/squat-related-daily.csv
	./gen-graph-csv daily all -i -l deadlift > $(CSVDIR)/deadlift-related-daily.csv
	./gen-graph-csv daily all -i -l press > $(CSVDIR)/press-related-daily.csv
	./gen-graph-csv daily all -i -l "paused bench" > $(CSVDIR)/pbench-related-daily.csv
	./gen-graph-csv weekly all -i -l squat > $(CSVDIR)/squat-related-weekly.csv
	./gen-graph-csv weekly all -i -l deadlift > $(CSVDIR)/deadlift-related-weekly.csv
	./gen-graph-csv weekly all -i -l press > $(CSVDIR)/press-related-weekly.csv
	./gen-graph-csv weekly all -i -l "paused bench" > $(CSVDIR)/pbench-related-weekly.csv

csv-misc: $(CSVDIR) exlog
	./gen-graph-csv daily bodyweight > $(CSVDIR)/bodyweight-daily.csv
	./gen-graph-csv weekly bodyweight > $(CSVDIR)/bodyweight-weekly.csv

$(CSVDIR):
	mkdir $(CSVDIR)

graphs: csv
	$(MAKE) -C graphs

clean:
	rm -rf __pycache__
	rm -rf $(CSVDIR)
	$(MAKE) -C graphs clean
