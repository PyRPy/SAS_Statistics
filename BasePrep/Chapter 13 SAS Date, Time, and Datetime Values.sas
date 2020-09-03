/* Chapter 13: SAS Date, Time, and Datetime Values */
/* SAS Date and Time Values */
* Example: Date and Time Values;
data work.test; 
  set cert.temp; 
  TotDay=enddate-startdate; 
run;
proc print data=work.test; 
run;

/* Reading Dates and Times with Informats */
* Example: Reading Dates with Formats and Informats;
proc import datafile='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\new_hires.csv'
  out=newhires
  dbms=csv
  replace;
  getnames=yes;
run;
proc print data=work.newhires;
run;
proc contents data=work.newhires;
run;

/* Example: Using Dates and Times in Calculations */
data work.aprhospitalbills;
  set cert.aprbills;
  Days=dateout-datein+1;                  /*#1*/
  RoomCharge=days*roomrate;               /*#2*/
  Total=roomcharge+equipcost;             /*#3*/
run;
proc print data=work.aprhospitalbills;
  format DateIn DateOut mmddyy8.;         /*#4*/
run;

/* Displaying Date and Time Values with Formats */
proc print data=work.aprhospitalbills; 
   format datein dateout weekdate17.; 
run;

proc print data=work.aprhospitalbills; 
   format datein dateout worddate12.; 
run;

* permanently assign a format in data step;
data work.aprhospitalbills;
  set cert.aprbills;
  Days=dateout-datein+1;
  RoomCharge=days*roomrate;
  Total=roomcharge+equipcost;
  format datein dateout worddate12.;
run;
proc print data=work.aprhospitalbills;
run;
