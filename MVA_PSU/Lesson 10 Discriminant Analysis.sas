/* Lesson 10: Discriminant Analysis */
options ls=78;
title "Discriminant Analysis - Insect Data";
data insect;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\insect.txt";
  input species $ joint1 joint2 aedeagus;
  run;
data test;
  input joint1 joint2 aedeagus;
  cards;
194 124 49
;
proc discrim data=insect pool=test crossvalidate testdata=test testout=a;
  class species;
  var joint1 joint2 aedeagus;
  run;
/* print out the prediction result */
proc print;
  run;

/* with priors */
proc discrim data=insect pool=test crossvalidate testdata=test testout=a;
  class species;
  var joint1 joint2 aedeagus;
	priors "a" = 0.9 "b" = 0.1;
  run;
/* print out the prediction result */
proc print;
  run;

/* Example 10-6: Swiss Bank notes Section */
options ls=78;
title "Discriminant - Swiss Bank Notes";
data banknotes;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\swiss3.txt";
  input type $ length left right bottom top diag;
  run;

 proc print data = banknotes;
 run;
data test;
  input length left right bottom top diag;
  cards;
214.9 130.1 129.9 9 10.6 140.5
;
  run;
proc discrim data=banknotes pool=test crossvalidate testdata=test testout=a;
  class type;
  var length left right bottom top diag;
  priors "real"=0.99 "fake"=0.01;
  run;
proc print;
  run;
