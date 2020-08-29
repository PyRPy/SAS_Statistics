/* Example Code 2.1 A Simple SAS Program */

title1 'June Billing';        /*#1*/
data work.junefee;            /*#2*/  
  set cert.admitjune;  
  where age>39;
run;                          /*#3*/
proc print data=work.junefee; /*#4*/
run;

* Example Code 2.2 Processing SAS Programs;
data work.admit2;               /*#1*/
  set cert.admit;
  where age>39;
proc print data=work.admit2;    /*#2*/
run;  

proc freq data=sashelp.cars;  
  table origin*DriveTrain;
run;

proc sort data=cert.admit;
  by sex;
run;

/* SAS Libraries */
/* SAS Data Sets */
