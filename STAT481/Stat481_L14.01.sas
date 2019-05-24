* Lesson 14: Data Step Options;

* Example 14.1. The DATA step in the following program 
uses the OBS= option to tell SAS to create a temporary 
data set called back by selecting the first 25 observations 
from the permanent background data set icdb.back:;

OPTIONS PS=58 LS=80 NODATE NONUMBER;

LIBNAME icdb 'C:/Data_SAS';
 
 DATA back;
   set icdb.back (obs=25);
 RUN;

 PROC PRINT data=back;
   title 'A Subset of the Background Data Set';
 RUN;


