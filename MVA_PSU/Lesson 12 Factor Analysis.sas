/* Lesson 12: Factor Analysis */

/* Example 12-1: Places Rated */
options ls=78;
title "Factor Analysis - Principal Component Method - Places Rated";
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
proc factor method=principal nfactors=3 rotate=varimax simple scree ev preplot
     plot residuals;
  var climate housing health crime trans educate arts recreate econ;
  run;

/* Example 12-2: Places Rated  */
options ls=78;
title "Factor Analysis - Maximum Likelihood - Places Rated";
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
proc factor method=ml nfactors=3;
  var climate housing health crime trans educate arts recreate econ;
  run;
/* more options or remedies*/
proc factor method=ml nfactors=3 heywood;
  var climate housing health crime trans educate arts recreate econ;
  run;
