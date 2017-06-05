CSVDIR = build

all: csv graphs

csv: $(CSVDIR) exlog
	./gen-csv daily > "${CSVDIR}/daily.csv"
	./gen-csv weekly > "${CSVDIR}/weekly.csv"
	./gen-key "${CSVDIR}/weekly.csv" > "${CSVDIR}/gnuplot.key"

$(CSVDIR):
	mkdir $(CSVDIR)

graphs: csv
	$(MAKE) -C graphs

clean:
	rm -rf __pycache__
	rm -rf $(CSVDIR)
	$(MAKE) -C graphs clean
