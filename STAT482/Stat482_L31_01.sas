* Lesson 31: Multiple Regression Analysis;
DATA REGRESSN;
   INPUT ID DOSAGE EXERCISE LOSS;
DATALINES;
   1        100         0         -4
   2        100         0          0
   3        100         5         -7
   4        100         5         -6
   5        100        10         -2
   6        100        10        -14
   7        200         0         -5
   8        200         0         -2
   9        200         5         -5
  10        200         5         -8
  11        200        10         -9
  12        200        10         -9
  13        300         0          1
  14        300         0          0
  15        300         5         -3
  16        300         5         -3
  17        300        10         -8
  18        300        10        -12
  19        400         0         -5
  20        400         0         -4
  21        400         5         -4
  22        400         5         -6
  23        400        10         -9
  24        400        10         -7 
;
PROC REG DATA=REGRESSN;
   TITLE 'Weight Loss Experiment - Regression Example';
   MODEL LOSS = DOSAGE EXERCISE / P R;
RUN;
QUIT;
