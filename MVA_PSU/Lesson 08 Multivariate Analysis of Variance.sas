/* Lesson 8: Multivariate Analysis of Variance */
/* Example 8-1 Pottery Data (MANOVA) */

options ls=78;
title "Check for normality - Pottery Data";
data pottery;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\pottery.txt";
  input site $ al fe mg ca na;
  run;
proc print data = pottery;
run;

proc glm;
  class site;
  model al fe mg ca na = site;
  output out=resids r=ral rfe rmg rca rna;
  run;
proc print;
  run;

/* Example 8-2: Pottery Data */
options ls=78;
title "Bartlett's Test - Pottery Data";
data pottery;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\pottery.txt";
  input site $ al fe mg ca na;
  run;
proc discrim pool=test;
  class site;
  var al fe mg ca na;
  run;

* We find no statistically significant evidence against the null hypothesis ;
* that the variance-covariance matrices are homogeneous (L' = 27.58; d.f. = 45; p = 0.98);

/* Example 8-3: Pottery Data (MANOVA) */
* After we have assessed the assumptions, our next step is to proceed with the MANOVA;

options ls=78;
title "MANOVA - Pottery Data";
data pottery;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\pottery.txt";
  input site $ al fe mg ca na;
  run;
proc print;
  run;
proc glm;
  class site;
  model al fe mg ca na = site;
  contrast 'C+L-A-I' site  8 -2  8 -14;
  contrast 'A vs I ' site  1  0 -1   0;
  contrast 'C vs L ' site  0  1  0  -1;
  estimate 'C+L-A-I' site  8 -2  8 -14/ divisor=16;
  estimate 'A vs I ' site  1  0 -1   0;
  estimate 'C vs L ' site  0  1  0  -1;
  lsmeans site / stderr;
  manova h=site / printe printh;
  run;

options ls=78;
title "Profile Plot for Pottery Data";
data pottery;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\pottery.txt";
  input site $ al fe mg ca na;
  chemical="al"; amount=al; output;
  chemical="fe"; amount=fe; output;
  chemical="mg"; amount=mg; output;
  chemical="ca"; amount=ca; output;
  chemical="na"; amount=na; output;
proc print data = pottery;
run;

proc sort;
  by site chemical;
proc means;
  by site chemical;
  var amount;
  output out=a mean=mean;
proc gplot;
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot mean*chemical=site / vaxis=axis1 haxis=axis2;
  symbol1 v=J f=special h=2 l=1 i=join color=black;
  symbol2 v=K f=special h=2 l=1 i=join color=black;
  symbol3 v=L f=special h=2 l=1 i=join color=black;
  symbol4 v=M f=special h=2 l=1 i=join color=black;

/* Example 8-4: Pottery Data (ANOVA) */
options ls=78;
title "MANOVA - Pottery Data";
data pottery;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\pottery.txt";
  input site $ al fe mg ca na;
  run;
proc print;
  run;
proc glm;
  class site;
  model al fe mg ca na = site;
  contrast 'C+L-A-I' site  8 -2  8 -14;
  contrast 'A vs I ' site  1  0 -1   0;
  contrast 'C vs L ' site  0  1  0  -1;
  estimate 'C+L-A-I' site  8 -2  8 -14/ divisor=16;
  estimate 'A vs I ' site  1  0 -1   0;
  estimate 'C vs L ' site  0  1  0  -1;
  lsmeans site / stderr;
  manova h=site / printe printh;
  run;

/* Example 8-8: Pottery Data */
* same as 8-4;

/* Example 8-11: Rice Data */

options ls=78;
title "Two-Way MANOVA: Rice Data";
data rice;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\rice.txt";
  input block variety $ height tillers;
  run;

proc print data = rice;
run;

proc glm;
  class block variety;
  model height tillers=block variety;
  lsmeans variety;
  manova h=variety / printe printh;
  run;
quit;
