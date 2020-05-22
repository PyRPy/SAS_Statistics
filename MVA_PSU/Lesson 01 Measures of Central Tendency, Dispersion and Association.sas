/*
Lesson 1: Measures of Central Tendency, Dispersion and Association
https://online.stat.psu.edu/stat505/lesson/1/1.6
*/


/* Example 1-1 Pulse rates */
proc iml;
x = { 64, 68, 74, 76, 78};
xbar = mean(x);
print xbar;

n = nrow(x);
stdsquare = sum((x - xbar)##2) / n;
print stdsquare;

std = sqrt(stdsquare);
print std;

* the normal std shoul be like this ;
std_normal = std(x);
print std_normal;


/* Example 1-2 */
x1 = {6 10 12 12}`;
x2 = {3 4 7 6}`;
x1bar = mean(x1);
x2bar = mean(x2);

n= nrow(x1);
s12 = sum((x1 - x1bar)#(x2 - x2bar)) / (n - 1);
print s12;

/*Example 1-3 Body meansurements - covariance */
quit;

* nutrient example ;
options ls=78;
title "Example: Nutrient Intake Data - Descriptive Statistics";
data nutrient;
  infile "Documents\My SAS Files\STAT505_SAS\Data\nutrient.txt";
  input id calcium iron protein a c;
run;
proc means;
  var calcium iron protein a c;
run;
proc corr pearson cov;
  var calcium iron protein a c;
run;

* nutrient3.sas ;
options ls=78;
title "Example: Nutrient Intake Data - Generalized Variance";
data nutrient;
  infile "Documents\My SAS Files\STAT505_SAS\Data\nutrient.txt";
  input id calcium iron protein a c;
 run;
proc iml;
  start genvar;
    one=j(nrow(x),1,1);
    ident=i(nrow(x));
    s=x`*(ident-one*one`/nrow(x))*x/(nrow(x)-1.0);
    genvar=det(s);
    print s genvar;
  finish;
  use nutrient;
  read all var{calcium iron protein a c} into x;
  run genvar;
quit;
