* 11.1 - The MEANS and SUMMARY Procedures;
* Example 11.1. Throughout our investigation of the MEANS, 
SUMMARY, and UNIVARIATE procedures, we'll use the hematology 
data set arising from the ICDB Study. The following program 
tells SAS to display the contents, and print the first 15 
observations, of the data set:;

OPTIONS PS = 58 LS = 80 NODATE NONUMBER;

LIBNAME icdb 'C:/Data_SAS';

PROC CONTENTS data = icdb.hem2 position;
RUN;

PROC PRINT data = icdb.hem2 (OBS = 15);
RUN;
