options ls=72;
title "Confidence Intervals - Mineral Content Data";
%let p=3; /* here you can change */
data mineral;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\mineral.dat";
  input domradius radius domhumerus humerus domulna ulna;
  variable="domradius"; x=domradius; output;
  variable="domhumerus";    x=domhumerus;    output;
  variable="dumulna"; x=domulna; output;
    keep variable x;
  run;
proc sort;
  by variable;
  run;
proc means noprint;
  by variable;
  var x;
  output out=a n=n mean=xbar var=s2;
  run;
data b;
  set a;
  t1=tinv(1-0.025,n-1);
  tb=tinv(1-0.025/&p,n-1);
  f=finv(0.95,&p,n-&p);
  loone=xbar-t1*sqrt(s2/n);
  upone=xbar+t1*sqrt(s2/n);
  lobon=xbar-tb*sqrt(s2/n);
  upbon=xbar+tb*sqrt(s2/n);
  losim=xbar-sqrt(&p*(n-1)*f*s2/(n-&p)/n);
  upsim=xbar+sqrt(&p*(n-1)*f*s2/(n-&p)/n);
run;
proc print;
run;

/* check intermediate data */
proc print data = mineral;
run;
proc print data = a;
run;

options ls=78;
title "Eigenvalues and Eigenvectors - Wechsler Data";
data wechsler;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wechsler.txt";
  input id info sim arith pict;
run;
proc print;
run;

/* extract Covariance Matrix */
proc princomp cov;
  var info sim arith pict;
run;
