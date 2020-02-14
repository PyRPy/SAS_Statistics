/* random sampling of data */
* ref https://www.youtube.com/watch?v=jeeCUwildMw&t=330s;

proc print data = Tutorial.Titanic (obs = 10) label;
run;

proc freq data = tutorial.titanic;
	tables survived;
run;

proc surveyselect data = tutorial.titanic
				  out = SRS
				  sampsize = 100
				  method = srs
				  seed = 12
				  stats;
run;

proc print data = SRS (obs = 10) label;
run;

proc freq data = SRS;
	tables survived;
run;

proc sort data = tutorial.titanic out = sortedTitanic;
	by survived;
run;

proc surveyselect data = sortedTitanic
				  out = stratifiedSRS
				  samprate = 0.6667
				  method = srs
				  seed = 12
				  outall;
	strata survived;
run;

proc freq data = stratifiedSRS;
	tables survived * selected;
run;

