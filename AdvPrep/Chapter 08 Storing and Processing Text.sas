/* Chapter 8: Storing and Processing Text */
/* Processing Text with Macro Functions */
* Example: Using the %UPCASE Function;

%let paidval=n;
title "Uncollected Fees for Each Course";
proc means data=certadv.all sum maxdec=0;
   where paid="&paidval";
   var fee;
   class course_title;
run;

* use %upcase function;
%let paidval=n;
title "Uncollected Fees for Each Course";
proc means data=certadv.all sum maxdec=0;
   where paid="%upcase(&paidval)";
   var fee;
   class course_title;
run;

* Example: Using the %SUBSTR Function;
proc print data=certadv.schedule;
     where begin_date between
         "30%substr(&sysdate9,3)"d and
         "&sysdate9"d;
   title "All Courses Held So Far This Month";
   title2 "(as of &sysdate9)";
run;
* nothing returned;

* Example: Using the %INDEX Function;
%let a=a very long value;
%let b=%index(&a,v);
%put The character v appears at position &b;

* The %SCAN Function;
%let a=one:two-three four;

%put First word is %scan(&a,1);
%put Second word is %scan(&a,2,:-);
%put Last word is %scan(&a,-1);

/* Using SAS Functions with Macro Variables */
* Example: Using the %SYSFUNC Function;
%let string=william SMITH;
%put %sysfunc(propcase(&string));

* Example: Using the %EVAL Function;
%let a=1+2;
%let b=10*3;
%let c=5/3;
%let eval_a=%eval(&a);
%let eval_b=%eval(&b);
%let eval_c=%eval(&c);

%put &a is &eval_a;
%put &b is &eval_b;
%put &c is &eval_c;

* Example: Using the %SYSEVALF Function;
%macro figureit(a,b);
   %let y=%sysevalf(&a+&b);
   %put The result with SYSEVALF is: &y;
   %put  The BOOLEAN value is: %sysevalf(&a +&b, boolean);
   %put  The CEIL value is: %sysevalf(&a+&b, ceil);
   %put  The FLOOR value is: %sysevalf(&a+&b, floor);
   %put  The INTEGER value is: %sysevalf(&a+&b, int);
%mend figureit;

%figureit(100,1.597)

/* Using SAS Macro Functions to Mask Special Characters */
* Macro Quoting Functions;
data one;
   var='text';
   text='example';
   var2=text;
run;

proc print;
   title "Joan's Report";
run;

* Example: Using %STR Function;
options symbolgen;
%let text=Joan's Report;
proc print data=certadvadv.courses;
   where days > 3;
title "&text";
run;


%let text=%str(Joan%'s Report);
%let text=Joan%str(%')s Report;
proc print data=certadv.courses;
   where days > 3;
title "&text";
run;

* Example: Using %NRSTR Function;
%let Period=%str(May&Jun);
%put Period resolves to: &period;
%let Period=%nrstr(May&Jun);
%put Period resolves to: &period;
* SAS interprets the ampersand as a macro;

* Example: Using the %SUPERQ Function;
data _null_;
   call symputx('mv1','Smith&Jones');
   call symputx('mv2','%macro abc;');
run;
%let testmv1=%superq(mv1);
%let testmv2=%superq(mv2);
%put Macro variable TESTMV1 is &testmv1;
%put Macro variable TESTMV2 is &testmv2;

* Example: Using the %BQUOTE Function;
data _null_;
   call symputx('text',"Sally's Seashell Store at Old Towne's Beach");
run;
data _null_;
   put "%bquote(&text)";
run;

* Example: Using the %QUPCASE Function;
%let a=%nrstr(Address&name); 
%put QUPCASE produces: %qupcase(&a); 

* Example: Using the %QSUBSTR Function;
%let a=one;
%let b=two;
%let c=%nrstr(&a &b);

%put C: &c;
%put With SUBSTR: %substr(&c,1,2);
%put With QSUBSTR: %qsubstr(&c,1,2);

* Example: Using the %QSCAN Function;
%macro a;
   aaaaaa
%mend a;
%macro b;
   bbbbbb
%mend b;
%macro c;
   cccccc
%mend c;

%let x=%nrstr(%a*%b*%c);
%put X: &x
%put The third word in X, with SCAN: %scan(&x,3,*);
%put The third word in X, with QSCAN: %qscan(&x,3,*);

* Example: Using the %QSYSFUNC Function;
title "Report Produced on %sysfunc(left(%qsysfunc(today(),worddate.)))";

/* Creating Macro Variables during PROC SQL Step Execution */
* Example: Using the INTO Clause and the NOPRINT Option;
proc sql noprint;
   select sum(fee) format=dollar10. 
      into :totalfee trimmed 
      from certadv.all;
quit;

proc means data=certadv.all sum maxdec=0;
   class course_title;
   var fee;
   title "Grand Total for All Courses Is &totalfee";
run;

* Example: Creating Variables with the INTO Clause;
proc sql noprint;
   select course_code, location, begin_date format=mmddyy10.
      into :crsid1- ,
         :place1- ,
         :date1- 
      from certadv.schedule
      where year(begin_date)=2019
      order by begin_date;
quit;

%put There are &sqlobs courses in 2019;
%put _user_;

* Example: Creating a Delimited List of Values;
proc sql noprint;
   select distinct location 
      into :sites separated by ' '
      from certadv.schedule;
quit;

title1 'Total Revenue from Course Sites:';
title2 &sites;
proc means data=certadv.all sum maxdec=0;
   var fee;
run;
* HOW TO INTERACT WITH PROC FUNCTIONS WITH SQL !!!;

/* Creating Macro Variables during DATA Step Execution */
* Example: Using the CALL SYMPUTX Routine;
%let crsnum=3;
data revenue;
   set certadv.all end=final;
   where course_number=&crsnum;
   total+1;
   if paid='Y' then paidup+1;
   if final then do;
      call symputx('crsname',course_title);
      call symputx('date',put(begin_date,mmddyy10.));
      call symputx('due',put(fee*(total-paidup),dollar8.));
   end;
run;
proc print data=revenue;
   var student_name student_company paid;
   title "Fee Status for &crsname (#&crsnum) Held &date";
   footnote "Note: &due in Unpaid Fees";
run;

* Example: Using the CALL SYMPUTX Routine with Literal Strings;
options symbolgen pagesize=30;
%let crsnum=3;
data revenue;
   set certadv.all end=final;
   where course_number=&crsnum;
   total+1;
   if paid='Y' then paidup+1;
   if final then do;
   if paidup<total then do;
      call symputx('foot','Some Fees Are Unpaid');
   end;
   else do;
      call symputx('foot','All Students Have Paid');
   end;
end;
run;

proc print data=work.revenue;
   var student_name student_company paid;
   title "Payment Status for Course &crsnum";
   footnote "&foot";
run;

* Example: Using the CALL SYMPUTX Routine with a DATA Step Variable;
%let crsnum=3;
data revenue;
   set certadv.all end=final;
   where course_number=&crsnum;
   total+1;
   if paid='Y' then paidup+1;
   if final then do;
      call symputx('numpaid',paidup);
      call symputx('numstu',total);
      call symputx('crsname',course_title);
   end;
run;
proc print data=revenue noobs;
   var student_name student_company paid;
   title "Fee Status for &crsname (#&crsnum)";
   footnote "Note: &numpaid Paid out of &numstu Students";
run;

* Example: Creating Multiple Macro Variables with CALL SYMPUTX;
data _null_;
   set certadv.courses;
   call symputx(course_code,course_title);
run;
%put _user_;

* Schedule for Artificial Intelligence;
%let crsid=C005;
proc print data=certadv.schedule noobs label;
   where course_code="&crsid";
   var location begin_date teacher;
   title1 "Schedule for &c005";
run;


* Schedule for Structured Query Language;
%let crsid=C002;
proc print data=certadv.schedule noobs label;
   where course_code="&crsid";
   var location begin_date teacher;
   title1 "Schedule for &c002";
run;

* Example: Using the PUT Function;
%let crsnum=3;
data revenue;
   set certadv.all end=final;
   where course_number=&crsnum;
   total+1;
   if paid='Y' then paidup+1;
   if final then do;
     call symputx('crsname',trim(course_title));
     call symputx('date',put(begin_date,mmddyy10.));
     call symputx('due',strip(put(fee*(total-paidup),dollar8.)));
   end;
run;

proc print data=revenue;
   var student_name student_company paid;
   title "Fee Status for &crsname (#&crsnum) Held &date";
   footnote "Note: &due in Unpaid Fees";
run;

/* Referencing Macro Variables Indirectly */
data _null_;
   set certadv.courses;
   call symputx(course_code,(course_title));
run;

%let crsid=C002;
proc print data=certadv.schedule noobs label;
   where course_code="&crsid";
   var location begin_date teacher;
   title1 "Schedule for ???";
run;

proc print data = certadv.schedule;
run;

* Example: Creating a Series of Macro Variables;
options symbolgen;
data _null_;
   set certadv.schedule;
   call symputx(cats('teach',course_number),teacher);
run;

* Roster for Course 3 Taught by Forest, Mr. Peter;
%let crs=3;
proc print data=certadv.register noobs;
   where course_number=&crs;
   var student_name paid;
   title1 "Roster for Course &crs";
   title2 "Taught by &&teach&crs";
run;
