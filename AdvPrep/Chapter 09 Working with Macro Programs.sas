/* Chapter 9: Working with Macro Programs */
/* Defining and Calling a Macro */

%macro printit;
proc print data=&syslast (obs=5);
   title "Listing of &syslast data set";
run;
%mend printit;
%printit;

* Example: Using the MCOMPILENOTE Option ;
* Example: Calling a Macro;

proc sort data=sashelp.cars out=cars_mpg;
   by MPG_City;
run;
%printit                                        
proc sort data=sashelp.cars out=cars_msrp;
   by MSRP;
run;
%printit                                        

* Example: Executing a Macro;
%printit

/* Passing Information into a Macro Using Parameters */
%macro printdsn(dsn,vars);
   proc print data=&dsn;
      var &vars;
   title "Listing of %upcase(&dsn) data set";
   run;
%mend;

%printdsn(certadv.courses,course_code course_title days)
%printdsn(,course_code course_title days)

* Example: Using Keyword Parameters to Create Macro Variables;
%macro printdsn(dsn=certadv.courses,
               vars=
course_code course_title days);
   proc print data=&dsn;
      var &vars;
   title "Listing of %upcase(&dsn) data set";
   run;
%mend;

%printdsn(vars=teacher course_code begin_date, dsn=certadv.schedule)
%printdsn()
%printdsn(dsn=certadv.courses,vars=course_code course_title days)

* Example: Using Mixed Parameters to Create Macro Variables;
%macro printdsn(dsn, vars=course_title course_code days);
   proc print data=&dsn;
      var &vars;
   title "Listing of %upcase(&dsn) data set";
   run;
%mend;

%printdsn(certadv.schedule, vars=teacher location begin_date)

/* Controlling Variable Scope */
* Example: Using %GLOBAL Statement;
%macro printdsn;
   %global dsn vars;
   %let dsn=certadv.courses;
   %let vars=course_title course_code days;
   proc print data=&dsn;
      var &vars;
   title "Listing of &dsn data set";
   run;
%mend printdsn;

%printdsn

* Example: Using the %LOCAL Statement;
%let dsn=certadv.courses;

%macro printdsn;
   %local dsn;
   %let dsn=certadv.register;
   %put The value of DSN inside Printdsn is &dsn;
%mend;

%printdsn
%put The value of DSN outside Printdsn is &dsn;

* Nested Scope;
%macro test;
   %local x;         /*1*/
   %let x=FALSE;     /*2*/
%macro test;
%test;

/*Debugging Macros */
* Example: Using the MPRINT Option;
%macro prtlast;
   proc print data=&syslast (obs=5);
      title "Listing of &syslast data set";
   run;
%mend prtlast;

data sales;
   price_code=1;
run;
options mprint;
%prtlast

* Example: Use Macro Comments;
%macro printit;
   /*The value of &syslast will be substituted appropriately*/
   /* as long as a data set has been created during this session.*/
   proc print data=&syslast(obs=5);
/* Print only the first 5 observations */
   title "Last Created Data Set Is &syslast";
   run;
%mend;

/* Conditional Processing */
* Example: Using %IF-%THEN, %DO-%END with IF-THEN Statements;
data work.sports;
   set sashelp.cars;
   where Type="Sports";
   AvgMPG=mean(MPG_City, MPG_Highway);
run;
%if &syserr ne 0 %then %do;
   %put ERROR: The rest of the program will not execute;
%end;
%else %do; 
title "Sports Cars";
proc print data=work.sports noobs;
   var Make Model AvgMPG MSRP;
run;
%end;

* Example: Controlling Text Copied to the Input Stack ;
%macro choice(status);
   data fees;
      set certadv.all;
      %if &status=PAID %then %do;
         where paid='Y';
         keep student_name course_code begin_date totalfee;
      %end;
      %else %do;
         where paid='N';
         keep student_name course_code
              begin_date totalfee latechg;
         latechg=fee*.10;
      %end;
      if location='Boston' then totalfee=fee*1.06;
      else if location='Seattle'  then totalfee=fee*1.025;
      else if location='Dallas'  then totalfee=fee*1.05;
   run;
%mend choice;

options mprint mlogic;
%choice(PAID)

options mprint mlogic;
%choice(OWED)

* Example: Using MLOGIC System Option;
data sales;
   price_code=1;
run;
options nomprint mlogic;
%prtlast

/* Iterative Processing */
* Example: Using the %DO Statement;
proc sql noprint;
   select teacher 
      into :teach1-
      from certadv.schedule;
run;

%macro putloop;
   %local i;
   %do i=1 %to &sqlobs;
      %put TEACH&i is &teach&i;
   %end;
%mend;

%putloop

* Example: Generating Complete Steps;
%macro rosters;
   %do class=1 %to 18;
      title "Roster for Class #&class";
      proc print data=certadv.all;
         where Course_Number=&class;
      run;
   %end;
%mend;

%rosters
