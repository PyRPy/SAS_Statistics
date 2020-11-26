* EXAMPLE: MULTILEVEL CORRELATION STRUCTURE;
* https://support.sas.com/resources/papers/proceedings14/SAS030-2014.pdf;
* data set ;
data Wellness2Mult;
input Treatment $ WS1P WS1M WS3P WS3M WS6P WS6M Alloc;
datalines;
Placebo 33 31 36 36 37 41 2
SGF 36 34 40 40 46 50 1
;

proc print data = Wellness2Mult;
run;

*  mixed model;
proc glm data = Wellness2Mult;
class Treatment;
model WS1P WS1M WS3P WS3M WS6P WS6M = Treatment;
repeated Time 3 (1 3 6), Dim 2 identity;
run;

* MANOVA method ?;
proc glm data=Wellness2Mult;
class Treatment;
weight Alloc;
model WS1P WS1M WS3P WS3M WS6P WS6M = Treatment / nouni;
repeated Time 3 (1 3 6), Dim 2 identity / printm;
run;

* calculate the required sample size in PROC POWER;
proc glmpower data=Wellness2Mult;
	class Treatment;
	weight Alloc;
	model WS1P WS1M WS3P WS3M WS6P WS6M = Treatment;
	manova "TimeAndDim" M=(1 0 0 0 -1 0,
						   0 1 0 0 0 -1,
						   0 0 1 0 -1 0,
						   0 0 0 1 0 -1);
	power
	effects=(Treatment)
	mtest = hlt
	alpha = 0.05
	power = .9
	ntotal = .
	matrix ("TimeCorr") = lear(0.85, 1, 3, 1 3 6)
	matrix ("DimCorr") = lear(0.4, 0, 2)
	matrix ("WellCorr") = "TimeCorr" @ "DimCorr"
	matrix ("StdDevs") = (2.4 2.8 2.4 2.8 2.4 2.8)
	corrmat = "WellCorr"
	sqrtvar = "StdDevs";
run;

* e slightly more efficient than the study ?;

* power curve;
ods graphics on;
proc glmpower data=Wellness2Mult plotonly;
	class Treatment;
	weight Alloc;
	model WS1P WS1M WS3P WS3M WS6P WS6M = Treatment;
	manova "TimeAndDim" M=(1 0 0 0 -1 0,
							0 1 0 0 0 -1,
							0 0 1 0 -1 0,
							0 0 0 1 0 -1);
	power
		effects=(Treatment)
		mtest = hlt
		alpha = 0.05
		power = .
		ntotal = 12
		matrix ("StdDevs") = (2.4 2.8 2.4 2.8 2.4 2.8)
		matrix ("TimeCorr") = lear(0.85, 1, 3, 1 3 6)
		matrix ("DimCorr") = lear(0.4, 0, 2)
		matrix ("WellCorr") = "TimeCorr" @ "DimCorr"
		corrmat = "WellCorr"
		sqrtvar = "StdDevs";
	plot x=n min=6 max=30 step=3 yopts=(ref=.9);
run;
ods graphics off;
