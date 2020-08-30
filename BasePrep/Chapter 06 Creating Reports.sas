/* Chapter 6: Creating Reports */
/* Creating a Basic Report */
libname cert 'Documents\My SAS Files\SAS_Base_Prep\practice-data\cert'; 
proc print data=cert.therapy; 
run;

/* Selecting Variables */
proc print data=cert.admit;
  var age height weight fee; 
run;

* Removing the OBS Column ;
proc print data=cert.admit noobs;
  var age height weight fee; 
run;

* Using the ID Statement in PROC PRINT;
proc print data=cert.reps;
  id idnum lastname;
run;

* Example: ID and VAR Statement;
proc print data=cert.reps;
  id idnum lastname;                 /*#1*/
  var idnum sex jobcode salary;      /*#2*/
run;

* Selecting Observations;
* Example Code 6.1 Using the WHERE Statement in PROC PRINT;
proc print data=cert.admit;
  var age height weight fee;         /*#1*/
  where age>30;                      /*#2*/
run;

* Example Code 6.2 Using the FIRSTOBS= Option;
options firstobs=10;         /*#1*/
proc print data=cert.heart;  /*#2*/
run;

* Example Code 6.3 Using the FIRSTOBS= and OBS= Options;
options firstobs=1 obs=10;      /*#1*/
proc print data=cert.heart;     /*#2*/
run;

* Example Code 6.4 Processing Middle Observations of a Data Set;
options firstobs=10 obs=15;    /*#1*/
proc print data=cert.heart;    /*#2*/
run;

/* Sorting Data */
* Example: PROC SORT;
options firstobs = 1;
proc sort data=cert.admit out=work.wgtadmit;    /*#1*/
  by weight age;
run;
proc print data=work.wgtadmit;                  /*#2*/
  var weight age height fee;                    /*#3*/
  where age>30;                                 /*#4*/
run;

proc print data=cert.admit;
run;
* Figure 6.9 Observations Displayed in Ascending Order of Age within Weight;
proc sort data=cert.admit out=work.wgtadmit; 
   by descending weight age; 
run; 
proc print data=work.wgtadmit; 
   var weight age height fee;  
   where age>30; 
run;

* Generating Column Totals;
proc print data=cert.insure; 
  var name policy balancedue; 
  where pctinsured < 100;  
  sum balancedue; 
run;

* Creating Subtotals for Variable Groups;
proc sort data=cert.admit out=work.activity;     /*#1*/
  by actlevel;
run;
proc print data=work.activity;
  var age height weight fee;
  where age>30;
  sum fee;                                       /*#2*/
  by actlevel;                                   /*#3*/
run;

* Example: ID, BY, and SUM Statements;
proc sort data=cert.admit out=work.activity;    /*#1*/
  by actlevel;
run;
proc print data=work.activity;
  var age height weight fee;
  where age>30;
  sum fee;                                      /*#2*/
  by actlevel;                                  /*#3*/
  id actlevel;                                  /*#4*/
run;

* Creating Subtotals on Separate Pages;
proc sort data=cert.admit out=work.activity;
  by actlevel;
run;
proc print data=work.activity;
  var age height weight fee;
  where age>30;
  sum fee;
  by actlevel;
  id actlevel;
  pageby actlevel;
run;

/* Specifying Titles and Footnotes in Procedure Output */
title1 'Heart Rates for Patients with:';
title3 'Increased Stress Tolerance Levels';
proc print data=cert.stress;
  var resthr maxhr rechr;
  where tolerance='I';
run;

* Example: Creating Footnotes;
footnote1 'Data from Treadmill Tests';
footnote3 '1st Quarter Admissions';
proc print data=cert.stress;
  var resthr maxhr rechr;
  where tolerance='I';
run;

* Modifying and Canceling Titles and Footnotes;

title1 'Heart Rates for Patients with';
title3 'Increased Stress Tolerance Levels';
footnote1 'Data from Treadmill Tests';
footnote3 '1st Quarter Admissions';
proc print data=cert.stress;
  var resthr maxhr rechr;
  where tolerance='I';
run;
proc means data=cert.stress;
  where tolerance='I';
  var resthr maxhr;
run;

title1 'Heart Rates for Patients with';
title3 'Participation in Exercise Therapy';
footnote1 'Data from Treadmill Tests';
footnote3 '1st Quarter Admissions';
proc print data=cert.therapy;
  var swim walkjogrun aerclass;
run;
title2 'Report for March';
proc print data=cert.therapy;
run;

title1;                                  /*#1*/
footnote1 'Data from Treadmill Tests';   /*#2*/
footnote3 '1st Quarter Admissions';      
proc print data=cert.stress;
  var resthr maxhr rechr;
  where tolerance='I';
run;
footnote;                                /*#3*/
proc means data=cert.stress;
  where tolerance='I';
  var resthr maxhr;
run;

/* Assigning Descriptive Labels */
* Example: Using Multiple LABEL Statements;
proc print data=cert.admit label;       /*#1*/
  var age height;
  label age='Age of Patient';           /*#2*/
  label height='Height in Inches';      /*#3*/
run;

* Example: Using a Single LABEL Statement to Assign Multiple               Labels            ;
proc print data=cert.admit label;         /*#1*/
  var actlevel height weight;
  label actlevel='Activity Level'         /*#2*/
        height='Height in Inches'
        weight='Weight in Pounds';
run;

/* Using Permanently Assigned Labels */
data cert.paris;
  set cert.laguardia;
  where dest='PAR' and (boarded=155 or boarded=146);
  label date='Departure Date';
run;
proc print data=cert.paris label;
  var date dest boarded;
run;
