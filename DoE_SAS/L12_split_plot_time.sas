data rmanova;
 input trt $ time subject resp;
 datalines;
 A   1  1  10
 A   1  2  12
 A   1  3  13
 A   2  1  16
 A   2  2  19
 A   2  3  20
 A   3  1  25
 A   3  2  27
 A   3  3  28
 B   1  4  12
 B   1  5  11
 B   1  6  10
 B   2  4  18
 B   2  5  20
 B   2  6  22
 B   3  4  25
 B   3  5  26
 B   3  6  27
 C   1  7  10
 C   1  8  12
 C   1  9  13
 C   2  7  22
 C   2  8  23
 C   2  9  22
 C   3  7  31
 C   3  8  34
 C   3  9  33
 ;

/* Split plot in time */
proc mixed data=rmanova method=type3;
class trt time subject;
model resp=trt time trt*time / ddfm=kr;
random subject(trt); title 'Split-Plot in Time'; 
run;


/* Repeated Measures Approach */
/* Fitting covariance structures: */
/* Note:  the code beginning with "ods output...." for each
	run of the Mixed procedure generates an output that
	is tablulated at the end to enable comparison of 
	the candidate covariance structures */
title ;
 proc mixed data=rmanova;
 class trt time subject;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=subject(trt) type=cs rcorr;

ods output FitStatistics=FitCS (rename=(value=CS))
FitStatistics=FitCSp;
title 'Compound Symmetry'; run;

title ;  run;
 proc mixed data=rmanova;
 class trt time subject;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=subject(trt) type=ar(1) rcorr;

ods output FitStatistics=FitAR1 (rename=(value=AR1))
FitStatistics=FitAR1p;
title 'Autoregressive Lag 1'; run;


title ; run;
proc mixed data=rmanova;
 class trt time subject;
 model resp=trt time trt*time / ddfm=kr;
 repeated time / subject=subject(trt) type=un rcorr;


ods output FitStatistics=FitUN (rename=(value=UN))
FitStatistics=FitUNp;
title 'Unstructured'; run;


title 'Covariance Summary'; run;
data fits;
merge FitCS FitAR1 FitUN;
by descr;
run;
ods listing; proc print data=fits; run;
