FILENAME patients '/folders/myfolders/sasuser.v94/STAT480/data/temp3.dat';

DATA temp4;
  infile patients;
  input subj 1-4 gender 6 height 8-9 weight 11-13;
RUN;

PROC PRINT data = temp4;
  title 'Output dataset: TEMP4';
RUN;
