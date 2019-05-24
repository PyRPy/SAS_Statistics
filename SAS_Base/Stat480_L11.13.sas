* 11.5 - Interaction Plots;
* Example 11.13. The following program uses data 
from the ICDB Background data set to illustrate 
how to create a simple plot to depict whether an 
interaction exists between two class variables, 
sex and race, when the analysis variable of interest 
is education level (ed_level):;

PROC SORT data=icdb.back out=back;
  by sex race;
RUN;

PROC MEANS data=back noprint;
   by sex race;
   var ed_level;
   output out=meaned mean=mn_edlev;
RUN;

PROC PRINT;
   title 'Mean Education Level for Sex and Race combinations';
RUN;

PROC PLOT data=meaned;
   title 'Interaction Plot of SEX, RACE, and Mean Education Level';
   plot mn_edlev*race=sex;
RUN;

* 11.6 - The UNIVARIATE procedure;
* Example 11.14. The following UNIVARIATE procedure 
illustrates the (almost) simplest version of the procedure, 
in which it tells SAS to perform a univariate analysis 
on the red blood cell count (rbc) variable in the icdb.hem2 
data set:;

PROC UNIVARIATE data = icdb.hem2;
   title 'Univariate Analysis of RBC';
   var rbc;
RUN;

* Example 11.15. When you specify the NORMAL option, 
SAS will compute four different test statistics for 
the null hypothesis that the values of the variable 
specified in the VAR statement are a random sample 
from a normal distribution. The four test statistics 
calculated and presented in the output are: Shapiro-Wilk, 
Kolmogorov-Smirnov, Cramer-von Mises, and Anderson-Darling.;

PROC UNIVARIATE data = icdb.hem2 NORMAL PLOT;
   title 'Univariate Analysis of RBC with NORMAL and PLOT Options';
   var rbc;
RUN;

* Example 11.16. When you use the UNIVARIATE procedure's ID 
statement, SAS uses the values of the variable specified in 
the ID statement to indicate the five largest and five smallest 
observations rather than the (usually meaningless) observation 
number. The following UNIVARIATE procedure uses the subject 
number (subj) to indicate extreme values of red blood cell 
count (rbc):;

PROC UNIVARIATE data = icdb.hem2;
   title 'Univariate Analysis of RBC with ID Option';
   var rbc;
   id subj;
RUN;

   
