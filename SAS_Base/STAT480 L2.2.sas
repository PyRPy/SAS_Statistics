LIBNAME stat480 '/folders/myfolders/sasuser.v94/STAT480';  *Specifies the SAS data library (directory);

DATA stat480.temp2;
  input subj 1-4 gender 6 height 8-9 weight 11-13;
  DATALINES;
1024 1 65 125
1167 1 68 140
1168 2 68 190
1201 2 72 190
1302 1 63 115
  ;
RUN;

PROC PRINT data=stat480.temp2;
  title 'Output dataset: STAT480.TEMP2';
RUN;
