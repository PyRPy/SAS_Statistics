* randomize.sas, Section 3.8.1, p53;
;
DATA DESIGN;
  INPUT TRTMT @@;
  RANNO=RANUNI(0);
  LINES;
  1 1 1 2 2 2
;
PROC PRINT; RUN;
;
PROC SORT; BY RANNO;
PROC PRINT; RUN;
