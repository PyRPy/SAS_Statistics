* 11.4 - Creating Summarized Data Sets;
* Example 11.10. The following program uses the MEANS 
procedure's OUTPUT statement (and NOPRINT option) to 
create a temporary data set called hospsummary that 
has one observation for each hospital that contains 
summary statistics for the hospital:;

PROC MEANS data=icdb.hem2 NOPRINT;
    var rbc wbc hcrit;
	class hosp;
	output out = hospsummary 
	       mean = MeanRBC MeanWBC MeanHCRIT
		   median = MedianRBC MedianWBC MedianHCRIT;
RUN;
* Note that, for each keyword, the variables must be 
listed in the same order as they appear in the VAR 
statement.;

PROC PRINT;
  title 'Hospital Statistics';
RUN;

* Example 11.11. You can also create a summarized data set 
using the SUMMARY procedure. The following program is 
identical to the program in the previous example except 
for two things: (1) The MEANS keyword has been replaced 
with the SUMMARY keyword, and (2) the NOPRINT option has 
been removed from the PROC statement:;

PROC SUMMARY data=icdb.hem2;
    var rbc wbc hcrit;
	class hosp;
	output out = hospsummary 
	       mean = MeanRBC MeanWBC MeanHCRIT
		   median = MedianRBC MedianWBC MedianHCRIT;
RUN;

PROC PRINT;
  title 'Hospital Statistics';
RUN;

* Example 11.12. You can also create a summarized data 
set similar to the hospsummary data set created in the 
previous two examples by using a BY statement instead 
of a CLASS statement. The following program does just 
that:;

PROC SORT data = icdb.hem2 out = srtdhem2;
   by hosp;
RUN;

PROC MEANS data=srtdhem2 NOPRINT;
    var rbc wbc hcrit;
	by hosp;
	output out = hospsummary 
	       mean = MeanRBC MeanWBC MeanHCRIT
		   median = MedianRBC MedianWBC MedianHCRIT;
RUN;

PROC PRINT;
  title 'Hospital Statistics';
RUN;

