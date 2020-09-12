/* Chapter 7: Creating and Using Macro Variables */
/* ntroducing Macro Variables */
* Example: Using Macro Variables;

title "Employees Hired in 2012";
data work.emp2012;
   set certadv.empdata;
   if year(HireDate)=2012;
run;
proc print data=work.emp2012;
run;


title "Employees Hired in 2011";
data work.emp2011;
   set certadv.empdata;
   if year(HireDate)=2011;
run;
proc print data=work.emp2011;
run;


%let year=2012;
title "Employees Hired in &year";
data work.emp&year;
   set certadv.empdata;
   if year(HireDate)=&year;
run;
proc print data=work.emp&year;
run;

/* The SAS Macro Facility */
* Tokenization;
title "MPG City Over 25";
proc print data=sashelp.cars noobs;
   var Make Model Type MPG_City MPG_Highway MSRP;
   where MPG_City>25;
run;

/* Using Macro Variables */
* Example: Using Automatic Macro Variables;
footnote1 "Created &systime &sysday, &sysdate9";
title "MPG City Over 25";
proc print data=sashelp.cars;
   var Make Model Type MPG_City MPG_Highway MSRP;
   where MPG_City>25;
run; 
  

/* Troubleshooting Macro Variable References */
* Example: Using the SYMBOLGEN Option;
options symbolgen;
%let CarType=Wagon;
proc print data=sashelp.cars;
   var Make Model Type MSRP;
   where Type="&CarType";
   %put The value of the macro variable CarType is: &CarType;
run;
options nosymbolgen;

* Example: Using the %PUT Statement;

* Example: Using the %SYMDEL Statement;

%symdel CarType;

/* Delimiting Macro Variable References */
* Example: Using a Delimiter to Reference Macro Variables;
%let CarType=Wagon;
%let lib=sashelp;
title "&CarType.s from the &lib..CARS Table";
proc freq data=&lib..cars;
   tables Origin/nocum;
   where Type="&CarType";
run;
proc print data=&lib..cars;
  var Make Model Type MSRP;
  where Type="&CarType";
run;

/*
a period at the end of a reference forces the macro processor to recognize 
the end of the reference. The period does not appear in the resulting text.

When the character following a macro variable reference is a period, use 
two periods. The first is the delimiter for the macro reference, and the 
second is part of the text.
*/
