* EXAMPLE: TIME BY TREATMEN;
* https://support.sas.com/resources/papers/proceedings14/SAS030-2014.pdf;
* data set ;
data WellnessMult;
input Treatment $ WellScore1 WellScore3 WellScore6 Alloc;
datalines;
Placebo 32 36 39 2
SGF 35 40 48 1
;
proc print data = WellnessMult;
run;

/*
proc mixed data = WellnessMult;
class Treatment Time Subject;
model WellScore = Treatment|Time / ddfm=kr;
repeated Time / subject=Subject type=un;
run;
*/

*  PROC GLM analysis;
proc glm data = WellnessMult;
class Treatment;
model WellScore1 WellScore3 WellScore6 = Treatment;
repeated Time;
run;

* power analysis;
proc glmpower data=WellnessMult;
	class Treatment;
	weight Alloc;
	model WellScore1 WellScore3 WellScore6 = Treatment;
	repeated Time;
	power
	effects=(Treatment)
	mtest = hlt
	alpha = 0.05
	power = .9
	ntotal = .
	stddev = 3.2
	matrix ("WellCorr") = lear(0.85, 1, 3, 1 3 6)
	corrmat = "WellCorr";
run;

* power curve;
ods graphics on;
proc glmpower data=WellnessMult;
class Treatment;
weight Alloc;
model WellScore1 WellScore3 WellScore6 = Treatment;
repeated Time;
power
effects=(Treatment)
mtest = hlt
alpha = 0.05
ntotal = 30
power = .
stddev = 3.2
matrix ("WellCorr") = lear(0.85, 1, 3, 1 3 6)
corrmat = "WellCorr";
plot x=n min=6 step=3
vary(symbol by stddev, panel by dependent source)
xopts=(ref=15 30 crossref=yes);
run;
ods graphics off;
