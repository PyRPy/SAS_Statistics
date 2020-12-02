* soap.sas, soap experiment, Table 3.8, p54;

OPTIONS LINESIZE = 72;
DATA SOAP;
  INPUT WTLOSS SOAP;
  DATALINES;
  -0.30 1
  -0.10 1
  -0.14 1
   0.40 1
   2.63 2
   2.61 2
   2.41 2
   3.15 2
   1.86 3
   2.03 3
   2.26 3
   1.82 3
;
PROC PRINT;

PROC SGPLOT;
  SCATTER X = SOAP Y = WTLOSS;
  XAXIS TYPE = DISCRETE LABEL = 'Soap';
  YAXIS LABEL = 'Weight Loss (grams)';
RUN;

PROC GLM;
  CLASSES SOAP;
  MODEL WTLOSS = SOAP;
  LSMEANS SOAP;
RUN; 
QUIT;

* soap2.sas, soap experiment, Table 3.9, p57;
DATA POWER;
  V = 3;
  DEL = 0.25;
  SIGMA2 = 0.007;
  ALPHA = 0.05;
  NU1 = V - 1;
  LHTPB = 1 - ALPHA;

DO R = 3 TO 6 BY 1;
  NU2 = V*(R - 1);
  PHI = (SQRT(R / (2*V*SIGMA2)))*DEL;
  FVALUE = FINV(LHTPB, NU1, NU2);
  NONCN = V*PHI**2;
  POWER = 1 - PROBF(FVALUE, NU1, NU2, NONCN);
  OUTPUT;
END;

PROC PRINT;
  VAR R POWER;

run;
