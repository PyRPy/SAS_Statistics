/* Chapter 4: Creating SAS Data Sets */

filename exercise 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\new_hires.csv';
proc import datafile = exercise dbms=dlm out=exstress replace;
	getnames = no;
run;
proc print data = exstress;
run;

* Example: Importing an Excel File with an XLSX Extension;
options validvarname=v7;                                  /*#1*/
proc import datafile='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\boots.xlsx'  /*#2*/
  dbms=xlsx
  out=work.bootsales
  replace;
  sheet=boot;                                             /*#3*/
  getnames=yes;                                           /*#4*/
run;
proc contents data=bootsales;                             /*#5*/
run;
proc print data=bootsales;
run;

* Example: Importing a Space-Delimited File with a TXT Extension;
options validvarname=v7;
filename stdata 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\state_data.txt' lrecl=100;  /*#1*/
proc import datafile=stdata                                         /*#2*/
  dbms=dlm
  out=states
  replace;
  delimiter=' ';                                                    /*#3*/
  getnames=yes;
run;
proc print data=states;
run;

* Example: Importing a Comma-Delimited File with a CSV Extension;
options validvarname=v7;
proc import datafile='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\boot.csv'  /*#1*/
  dbms=csv
  out=shoes
  replace;
  getnames=no;                                          /*#2*/
run;
proc print data=work.shoes;
run;

* Example: Importing a Tab-Delimited File;
proc import datafile='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\class.txt'   /*#1*/
  dbms=tab
  out=class
  replace;
  delimiter='09'x;                                        /*#2*/
run;
proc print data=class;
run;

/* Reading and Verifying  Data */
options obs=5;
proc import datafile="Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\boot.csv"
  dbms=csv
  out=shoes
  replace;
  getnames=no;
run;

proc print data=work.shoes;
run;

options obs=max;
proc import datafile="Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\boot.csv"
  dbms=csv
  out=shoes
  replace;
  getnames=no; 
run;

proc print data=work.shoes;
run;

/* Using the Imported Data in a DATA Step */
* Example: Using the SET Statement to Specify Imported Data;
proc import datafile="Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\boot.csv"
  out=shoes
  dbms=csv
  replace;
  getnames=no; 
run;
data boots;
  set shoes;
  where var1='South America' OR var1='Canada';
run;

proc print data=boots;
run;

/* Reading a Single SAS Data Set to Create Another */
libname cert 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\';
libname Men50 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\Men50';
data Men50.males;
  set cert.admit;
  where sex='M' and age>50;   
run;

proc print data=Men50.males;
   title 'Men Over 50';
run;

* Specifying DROP= and KEEP= Data Set Options;
data cert.drug1h(drop=placebo);
  set cert.cltrials(drop=triglyc uric);
  if placebo='YES';
run;
proc print data=cert.drug1h;
run;

/* Reading Microsoft Excel Data with the XLSX Engine */
libname certxl XLSX 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\exercise.xlsx';
data work.stress;
   set certxl.ActivityLevels;
run;

data work.stress;
   set certxl.ActivityLevels;
   where ActLevel='HIGH';
run;
proc print data = stress;
run;

* Printing an Excel Worksheet as a SAS Data Set;
libname certxl xlsx 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\stock.xlsx';
data work.bstock;
  set certxl.'boots stock'n;
run;
proc print data=work.bstock;
run;
* no data;

/* Creating Excel Worksheets */
libname excelout xlsx 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\newExcel.xlsx';
data excelout.HighStress;
  set cert.stress;
run;

/* Writing Observations Explicitly */
data work.usa5; 
  set cert.usa(keep=manager wagerate);
  if _n_=5 then output;
run; 
proc print data=work.usa5; 
run;

data empty full; 
  set cert.usa; 
  output full; 
run;

proc print data=full; 
run;
