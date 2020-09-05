/* Chapter 16: Creating Output */
/*The Output Delivery System (ODS) */
ods html close;
ods html path="%qsysfunc(pathname(work))";

/*Creating HTML Output with ODS */
ods html body='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\admit.html';
proc print data=cert.admit label;
  var sex age height weight actlevel;
  label actlevel='Activity Level';
run;
ods html close;
ods html path="%qsysfunc(pathname(work))";

* Creating HTML Output with a Table of Contents;

ods html body='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\data.html'
  contents='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\toc.html'
  frame='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\frame.html';
proc print data=cert.admit (obs=10) label;
  var id sex age height weight actlevel;
  label actlevel='Activity Level';
run;
proc print data=cert.stress2 (obs=10); 
  var id resthr maxhr rechr;
run;
ods html close;
ods html path="%qsysfunc(pathname(work))";

* Example: The STYLE= Option (Banker Style);
ods html body='Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\data.html'
  style=banker;
proc print data=cert.admit label;
  var sex age height weight actlevel;
run;
ods html close;
ods html path="%qsysfunc(pathname(work))";

/* Creating PDF Output with ODS */
ods html close;
ods pdf file="SamplePDF";
proc freq data=sashelp.cars;
  tables origin*type;
run;
ods pdf close;

/* Creating RTF Output with ODS */
ods html close;
ods rtf file="SampleRTF" style=FestivalPrinter; 
proc freq data=sashelp.cars;
  tables origin*type;
run;
ods rtf close;

/* Creating EXCEL Output with ODS */
ods excel file='multitablefinal.xlsx'   /*#1*/
  options (sheet_interval="bygroup"             /*#2*/
    suppress_bylines='yes'                      /*#3*/
    sheet_label='country'                       /*#4*/
    embedded_titles='yes');                     /*#5*/
title 'Wage Rates By Manager';
proc means data=cert.usa;
  by manager;
  var wagerate;
run;
ods excel close;                                /*#6*/

ods html path="%qsysfunc(pathname(work))";
proc print data = cert.usa;
run;

/* The EXPORT Procedure */
* Example: Exporting a Subset of Observation to a CSV File;
proc export data=cert.leukemia (where=(survived=1))  /*#1*/
  outfile="Documents\My SAS Files\SAS_Base_Prep\practice-data\cert\leukemia_surv.csv"                /*#2*/
  dbms=csv                                           /*#3*/
  replace;                                           /*#4*/
run;
