* Lesson 29: Analysis of Variance;
* E. Interpreting Significant Interactions
Page 215. I really like this application of a nested 
DO loop... that is, using a nested DO loop as a way 
of creating an experimental design in your data set. 
If it's not obvious to you what the ritalin data set 
looks like, you might want to take a peak at the output 
from the program:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA ritalin;
    do group = 'NORMAL', 'HYPER';
	   do drug = 'PLACEBO', 'RITALIN';
	      do subj = 1 to 4;
		     input activity @;
			 output;
		  end;
	   end;
	end;
DATALINES;
50 45 55 52 67 60 58 65 70 72 68 75 51 57 48 55
;
RUN;

PROC PRINT data = ritalin NOOBS;
   title 'The ritalin data set';
RUN;


PROC MEANS data = ritalin nway noprint;
   class group drug;
   var activity;
   output out = means mean = m_hr;
RUN;

PROC PRINT data = means NOOBS;
   title 'Cell means from ritalin experiment';
RUN;
