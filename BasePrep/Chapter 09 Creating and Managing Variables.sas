/* Chapter 9: Creating and Managing Variables */
/* Creating Variables */
* Example 1: Create a New Variable;
data work.stresstest;
  set cert.tests;
  TotalTime=(timemin*60)+timesec;
run;
proc print data=work.stresstest;
run;

*Example 2: Re-evaluating Variables;
data work.stresstest;
  set cert.tests;
  resthr=resthr+(resthr*.10);
run;
proc print data=work.stresstest;
run;

* Example: Assignment Statements and Date Values;
data work.stresstest;
  set cert.tests;
  TotalTime=(timemin*60)+timesec;
  TestDate='01jan2015'd;
run;
proc print data=work.stresstest;
run;

/* Modifying Variables */
* Example: Accumulating Totals;
data work.stresstest; 
  set cert.tests; 
  TotalTime=(timemin*60)+timesec; 
  SumSec+totaltime; 
run;
proc print data=work.stresstest;
run;

* Example: RETAIN Statement;
data work.stresstest;
  set cert.tests;
  TotalTime=(timemin*60)+timesec;
  retain SumSec 5400;
  sumsec+totaltime;
run;
proc print data=work.stresstest;
run;

/* Specifying Lengths for Variables */
data stress; 
  set cert.stress; 
  TotalTime=(timemin*60)+timesec; 
  retain SumSec 5400; 
  sumsec+totaltime; 
  length TestLength $ 6; 
  if totaltime>800 then testlength='Long'; 
  else if 750<=totaltime<=800 then testlength='Normal'; 
  else if totaltime<750 then TestLength='Short'; 
run;
proc print data=work.stress;
run;

/* Subsetting Data */
* Example: Subsetting IF Statement;
data work.stresstest;
  set cert.tests;
  if tolerance='D';
    TotalTime=(timemin*60)+timesec;
run;
proc print data=work.stresstest;
run;

* Example: IF-THEN Statement;
data work.stresstest;
  set cert.tests;
  TotalTime=(timemin*60)+timesec; 
  retain SumSec 5400; 
  sumsec+totaltime; 
  if totaltime>800 then TestLength='Long'; 
run;
proc print data=work.stresstest;
run;

* Examples: Logical Operators ;
data work.stresstest;
  set cert.tests;
  TotalTime=(timemin*60)+timesec;
  retain SumSec 5400;
  sumsec+totaltime;
  length TestLength $6;
  if totaltime>800 then TestLength='Long'; 
      else if 750<=totaltime<=800 then TestLength='Normal'; 
      else if totaltime<750 then TestLength='Short'; 
run;
proc print data=work.stresstest;
run;

* Example: IF-THEN and DELETE Statements;
data work.stresstest;
  set cert.tests;
  if resthr<70 then delete;
  TotalTime=(timemin*60)+timesec;
  retain SumSec 5400;
  sumsec+totaltime;
  length TestLength $6;
  if totaltime>800 then TestLength='Long'; 
    else if 750<=totaltime<=800 then TestLength='Normal'; 
    else if totaltime<750 then TestLength='Short'; 
run;
proc print data=work.stresstest;
run;

* Example: DROP Data Set Option;
data work.stresstest (drop=timemin timesec);
  set cert.tests;
  if resthr<70 then delete;
  TotalTime=(timemin*60)+timesec;
  retain SumSec 5400;
  sumsec+totaltime;
  length TestLength $6;
  if totaltime>800 then TestLength='Long'; 
    else if 750<=totaltime<=800 then TestLength='Normal'; 
    else if totaltime<750 then TestLength='Short'; 
run;
proc print data=work.stresstest;
run;

* Example: Using the DROP Statement;
data work.stresstest;
  set cert.tests;
  if tolerance='D';
  drop timemin timesec;
  TotalTime=(timemin*60)+timesec;
  retain SumSec 5400;
  sumsec+totaltime;
  length TestLength $6;
  if totaltime>800 then TestLength='Long'; 
    else if 750<=totaltime<=800 then TestLength='Normal'; 
    else if totaltime<750 then TestLength='Short'; 
run;
proc print data=work.stresstest;
run;

/* Transposing Variables into Observations */
* Example: Performing a Simple Transposition;
* NOT TRIALS DATA SOMEHOW !!!;
proc transpose data=cert.class out=score_transposed;    /*#1*/
run;
proc print data=score_transposed noobs;                 /*#2*/
  title 'Scores for the Year';
run;

* Transposing Specific Variables;
proc transpose data=cert.trials out=transtrials1;   /*#1*/
   var Cholesterol Triglyc Uric;                    /*#2*/
run;
proc print data=transtrials1;                       /*#3*/
run;

* Naming Transposed Variables;
proc transpose data=cert.trials out=transtrials2;  /*#1*/
   var cholesterol triglyc uric;                   /*#2*/
   id name testdate;                               /*#3*/
run;
proc print data=transtrials2;                      /*#4*/
run;

* Transposing BY Groups;
proc transpose data=cert.trials out=transtrials3;    /*#1*/
   var cholesterol triglyc uric;                     /*#2*/
   id name;                                          /*#3*/
   by testdate;                                      /*#4*/
run;
proc print data=transtrials3;                          /*#5*/
run;

/* Using SAS Macro Variables */
* Example: Using SAS Macro Variables with Numeric Values;
%let Cyl_Count=5;                        /*#1*/
proc print data=sashelp.cars;
   where Cylinders=&Cyl_Count;           /*#2*/
   var Type Make Model Cylinders MSRP;
run;
proc freq data=sashelp.cars;
   where Cylinders=&Cyl_Count;
   tables Type;
run;

* Example: Using SAS Macro Variables with Character Values;
%let CarType=Wagon;               /*#1*/
proc print data=sashelp.cars;
  where Type="&CarType";          /*#2*/
  var Type Make Model MSRP;
run;
proc means data=sashelp.cars;
  where Type="&CarType";
  var MSRP MPG_Highway;
run;
proc freq data=sashelp.cars;
  where Type="&CarType";
  tables Origin Make;
run;

* Example: Using Macro Variables in TITLE Statements;
%let TitleX=PROC PRINT Of Only &Cyl_Count Cylinder Vehicles;
%let Cyl_Count=5;
Title "&TitleX";
proc print data=sashelp.cars;
   where Cylinders=&Cyl_Count;
   var Type Make Model Cylinders MSRP;
run;

%let TitleX=PROC MEANS Of Only &Cyl_Count Cylinder Vehicles;
%let Cyl_Count=12;
Title "&TitleX";
proc means data=sashelp.cars;
   where Cylinders=&Cyl_Count;
   var MSRP;
run;
