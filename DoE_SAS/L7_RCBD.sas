data RCBD_oneway;
	input block fert $ height;
datalines;
1      Control      19.5
2      Control      20.5
3      Control      21
4      Control      21
5      Control      21.5
6      Control      22.5
1      F1      25
2      F1      27.5
3      F1      28
4      F1      28.6
5      F1      30.5
6      F1      32
1      F2      22.5
2      F2      25.2
3      F2      26
4      F2      26.5
5      F2      27
6      F2      28
1      F3      27.5
2      F3      28
3      F3      29.2
4      F3      29.5
5      F3      30
6      F3      31
;
run;

/* CRD for comparison */
proc mixed data=RCBD_oneway method=type3;
class fert;
model height = fert;
run;

/* RCBD */
proc mixed data=RCBD_oneway method=type3;
class block fert;
model height=fert;
random block;
run;
