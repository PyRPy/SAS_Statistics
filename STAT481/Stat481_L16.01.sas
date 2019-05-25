* Lesson 16: Combining SAS Data Sets -- Part II
* One thing to keep in mind, though, is you can't 
match-merge SAS data sets unless they are sorted 
by the variables appearing in the BY statement.;

* Example 16.1. The following program illustrates the 
simplest case of a match-merge, in which the data 
sets to be merged contain the same number of observations, 
and each observation in the first data set matches 
with exactly one observation in the second data set. 
Specifically, the demog and status data sets each 
contains five observations one for each subj 1000, 
1001, 1002, 1003, and 1004:;

DATA demog;
  input subj gender $ age;
  cards;
  1000 M 42
  1001 M 20
  1002 F 53
  1003 F 40
  1004 M 29
;
RUN;

DATA status;
  input subj disease $ test $ ;
  cards;
  1000 Y Y
  1001 N Y
  1002 N N
  1003 Y Y
  1004 N N
;
RUN;

DATA patients;
  merge demog status;
  by subj;
RUN;
 
PROC PRINT data=patients NOOBS;
  title 'The patients data set';
RUN;

* Example 16.2. The following program is another example 
of a simple match-merge, except this time the data 
sets to be merged desc demog and desc status are 
sorted by the BY variable subj in descending 
order:;

PROC SORT data = demog out = descdemog;
   by descending subj;
RUN;

PROC SORT data = status out = descstatus;
   by descending subj;
RUN;

DATA descpatients;
   merge descdemog descstatus;
   by descending subj;
RUN;

PROC PRINT data = descpatients NOOBS;
   title 'The descpatients data set';
RUN;

* Example 16.3. The following program illustrates a 
match-merge in which the data sets to be merged 
contain a different number of observations, and 
each observation in the first data set matches with 
no more than one observation in the second data set. 
Specifically, the newdemog data set contains six 
observations one for each subj 1000, 1001, 1002, 
1003, 1004, and 1005 while the status data set 
contains just five observations one for each subj 
1000, 1001, 1002, 1003, and 1004:;

DATA newdemog;
  input subj gender $ age;
  cards;
  1000 M 42
  1001 M 20
  1002 F 53
  1003 F 40
  1004 M 29
  1005 F 29
;
RUN;

DATA status;
  input subj disease $ test $ ;
  cards;
  1000 Y Y
  1001 N Y
  1002 N N
  1003 Y Y
  1004 N N
;
RUN;

DATA newpatients;
  merge newdemog status;
  by subj;
RUN;
 
PROC PRINT data=newpatients NOOBS;
  title 'The newpatients data set';
RUN;


* Example 16.4. In the examples we've looked at so 
far, the variables in the data sets to be merged 
were unique. That is, the data sets did not share 
any common variable names other than the variable 
that linked the data sets together. The following 
program illustrates how SAS merges two data sets 
when there are common variables across the data sets 
besides the linking variable(s). Specifically, in 
addition to the linking variable subj, the moredemog 
and morestatus data sets share a variable called 
v_date (for visit date):;

DATA moredemog;
  input subj gender $ age v_date mmddyy8.;
  format v_date mmddyy8.;
  DATALINES;
  1000 M 42 03/10/96
  1001 M 20 02/19/96
  1002 F 53 02/01/96
  1003 F 40 12/31/95
  1004 M 29 01/10/97
;
RUN;
  
DATA morestatus;
  input subj disease $ test $ v_date mmddyy8.;
  format v_date mmddyy8.;
  DATALINES;
  1000 Y Y 03/17/96
  1001 N Y 03/01/96
  1002 N N 02/18/96
  1003 Y Y 01/15/96
  1004 N N 02/01/97
;
RUN;

DATA morepatients;
   merge moredemog morestatus;
   by subj;
RUN;

PROC PRINT data=morepatients NOOBS;
  title 'The morepatients data set';
RUN;

* So, in general, if data sets share common variable 
names, the variable in the merged data set takes 
its value from the data set appearing last in the 
MERGE statement. To reinforce the point, the following 
data step merges data sets morestatus and moredemog 
again, but this time with moredemog appearing after 
morestatus in the MERGE statement:;

DATA morepatients2;
   merge morestatus moredemog;
   by subj;
RUN;

PROC PRINT data=morepatients2 NOOBS;
  title 'The morepatients2 data set';
RUN;

* Example 16.5. The following program illustrates a 
match-merge in which the observations in the first 
data set to be merged matches one or more observations 
in the second data set to be merged. Case in point, 
the salesone data set contains two observations for 
the 2004 year, while the salestwo data set contains 
three observations for the 2004 year:;

DATA salesone;
   input year prd sales;
   DATALINES;
   2004 1 100
   2004 2 200
   2005 3 300
   2006 4 400
   2007 5 500
   2008 6 600
  ;
 RUN;

 DATA salestwo;
   input year loc sales;
   DATALINES;
   2004 7  700
   2004 8  800
   2004 9  900
   2006 10 950
   2007 11 960
   2008 12 970
  ;
 RUN;

 DATA allsales;
    merge salesone salestwo;
    by year;
 RUN;

 PROC PRINT data=allsales NOOBS;
   title 'The allsales data set';
 RUN;
 
* So, do you get it? What do you think the data set 
 would look like if you merged in the reverse order? 
 The following DATA step tells SAS to merge salestwo 
 and salesone by year and to store the result in a 
 new data set called allsales2:;

DATA allsales2;
    merge salestwo salesone;
    by year;
 RUN;

 PROC PRINT data=allsales2 NOOBS;
   title 'The allsales2 data set';
 RUN;
 
 
