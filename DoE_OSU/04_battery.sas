* battery.sas, battery experiment, Table 4.1, p94;
;
DATA BATTERY;
  INPUT TYPE LPUC ORDER; 
  DATALINES;
  1 611  1
  2 923  2
  1 537  3
  4 476  4
  1 542  5
  1 593  6
  2 794  7
  3 445  8
  4 569  9
  2 827 10
  2 898 11
  3 490 12
  4 480 13
  3 384 14
  4 460 15
  3 413 16
; 
PROC PRINT DATA = BATTERY;
RUN;

PROC GLM; 
  CLASS TYPE; 
  MODEL LPUC = TYPE; 
  ESTIMATE 'DUTY'      TYPE  1  1 -1 -1 / DIVISOR = 2;
  ESTIMATE 'BRAND'     TYPE  1 -1  1 -1 / DIVISOR = 2;
  ESTIMATE 'INTERACTN' TYPE  1 -1 -1  1 / DIVISOR = 2;
  CONTRAST 'BRAND'     TYPE  1 -1  1 -1;
  LSMEANS TYPE / ADJUST=TUKEY CL PDIFF ALPHA=0.01;
run;
QUIT;
