LIBNAME stat480 '/folders/myfolders/sasuser.v94/STAT480';   

DATA temp;
  set stat480.temp2;
RUN;

PROC PRINT data=temp;  
  title 'Output dataset: TEMP';
RUN;
