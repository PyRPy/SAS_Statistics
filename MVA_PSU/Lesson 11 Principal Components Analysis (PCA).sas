/* Lesson 11: Principal Components Analysis (PCA) */
/* Example 11-2: Places Rated  */
options ls=78;
title "PCA - Covariance Matrix - Places Rated";
data places;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\places.txt";
  input climate housing health crime trans educate arts recreate econ id;
  climate=log10(climate);
  housing=log10(housing);
  health=log10(health);
  crime=log10(crime);
  trans=log10(trans);
  educate=log10(educate);
  arts=log10(arts);
  recreate=log10(recreate);
  econ=log10(econ);
  run;

proc print data = places;
run;

proc princomp cov out=a;
  var climate housing health crime trans educate arts recreate econ;
  run;
proc corr;
  var prin1 prin2 prin3 climate housing health crime trans educate arts 
      recreate econ;
  run;
proc gplot;
  axis1 length=5 in;
  axis2 length=5 in;
  plot prin2*prin1 / vaxis=axis1 haxis=axis2;
  symbol v=J f=special h=2 i=none color=black;
  run;


/* Example 11-3: Place Rated (after Standardization) */
options ls=78;
title "PCA - Correlation Matrix - Places Rated";
data places;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\places.txt";
  input climate housing health crime trans educate arts recreate econ id;
  climate=log10(climate);
  housing=log10(housing);
  health=log10(health);
  crime=log10(crime);
  trans=log10(trans);
  educate=log10(educate);
  arts=log10(arts);
  recreate=log10(recreate);
  econ=log10(econ);
  run;
proc princomp out=a;
  var climate housing health crime trans educate arts recreate econ;
  run;
proc corr;
  var prin1 prin2 prin3 climate housing health crime trans educate arts 
      recreate econ;
  run;
proc gplot;
  axis1 length=5 in;
  axis2 length=5 in;
  plot prin2*prin1 / vaxis=axis1 haxis=axis2;
  symbol v=J f=special h=2 i=none color=black;
  run;
