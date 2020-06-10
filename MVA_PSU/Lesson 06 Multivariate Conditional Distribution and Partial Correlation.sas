/* Lesson 6: Multivariate Conditional Distribution and Partial Correlation */
options ls=78;
title "Partial Correlations - Wechsler Data";
data wechsler;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wechsler.txt";
  input id info sim arith pict;
run;
proc print data = wechsler;
run;
proc glm;
  model info sim = arith pict / nouni;
  manova / printe;
run;
quit;
