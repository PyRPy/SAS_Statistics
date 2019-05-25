* Lesson 17: Using the OUTPUT and RETAIN statements;

* Example 17.1. This example uses the OUTPUT statement to 
tell SAS to write observations to data sets based on certain 
conditions. Specifically, the following program uses the 
OUTPUT statement to create three SAS data sets s210006, 
s310032, and s410010 based on whether the subject identification 
numbers in the icdblog data set meet a certain condition:;

OPTIONS PS=58 LS=80 NODATE NONUMBER;
LIBNAME stat481 'C:\Data_SAS';

DATA s210006 s310032 s410010;
   set stat481.icdblog;
        if (subj = 210006) then output s210006;
   else if (subj = 310032) then output s310032;
   else if (subj = 410010) then output s410010;
 RUN;

 PROC PRINT data = s210006 NOOBS;
   title 'The s210006 data set';
 RUN;
 
 PROC PRINT data = s310032 NOOBS;
   title 'The s310032 data set';
 RUN;

 PROC PRINT                NOOBS;
   title 'The s410010 data set';
 RUN;
 
 
