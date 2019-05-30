* Lesson 30: Repeated Measures Designs;
* C. Using the Repeated Statement of PROC ANOVA
Page 243. Here's another example in which you need 
to know the structure of the data that SAS expects 
in order to analyze the data. In the previous example 
in Section B, SAS expected a tall data set, in which 
each observation contains a subject's pain score on a 
particular drug. Here, SAS expects a fat data set, in 
which each observation contains a subject's pain scores 
on all four of the drugs.;

* Page 245. In case you want to see the (extensive) output 
from the SAS code:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA repeat1;
     input subj pain1-pain4;
     DATALINES;
	 1  5  9  6 11
	 2  7 12  8  9
	 3 11 12 10 14
	 4  3  8  5  8
	 ;
RUN;

PROC ANOVA data = repeat1;
    title 'One-way ANOVA using the REPEATED statement';
	model pain1-pain4 = / NOUNI;
	repeated DRUG 4 contrast(1) / NOM SUMMARY;
	repeated DRUG 4 contrast(2) / NOM SUMMARY;
	repeated DRUG 4 contrast(3) / NOM SUMMARY;
RUN;
quit;
