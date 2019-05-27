* Lesson 22: Date and Time Processing;
* So, for example, SAS stores:

a 0 for January 1, 1960
a 1 for January 2, 1960
a 2 for January 3, 1960
and so on ...
And, SAS stores:

a -1 for December 31, 1959
a -2 for December 30, 1959
a -3 for December 29, 1959
and so on ...;

* Example 22.1. The following SAS program reads five 
observations into a SAS data set called diet. Two of 
the variables weight date (wt_date) and birth date 
(b_date)are in mm/dd/yy format, and therefore SAS is 
told to read the dates using the mmddyy8. informat:;
DATA diet;
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
RUN;

PROC PRINT data=diet;
  TITLE 'The unformatted diet data set';
RUN;

* Example 22.2. The following SAS program is identical 
to the previous program, except a FORMAT statement has 
been added to tell SAS to display the wt_date and b_date 
variables in date7. format:;

* Using a Format to Display a SAS Date;

DATA diet;
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.;
  format wt_date b_date date7.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
RUN;

PROC PRINT data=diet;
  title 'The formatted diet data set';
RUN;

* Example 22.3. The following SAS program illustrates how 
you can treat date variables as any other numeric variable, 
and therefore can use the dates in numeric calculations. 
Assuming that individuals in the diet data set need to be 
weighed every 14 days, a new variable nxt_date, the anticipated 
date of the individual's next visit, is determined by merely 
adding 14 to the individual's current weight date (wt_date). 
Then, a crude estimate of each individual's age is also calculated 
by subtracting b_date from wt_date and dividing the resulting 
number of days by 365.25 to get an approximate age in years. 
And, the MEAN function is used to calculate avg_date, the average 
of each individual's birth and weight dates:;

* Using SAS Dates in Calculations;

DATA diet;
   input  subj 1-4 l_name $ 18-23 weight 30-32
          +1 wt_date mmddyy8. @43 b_date mmddyy8.;
   nxt_date = wt_date + 14;
   age_wt = (wt_date - b_date)/365.25;
   avg_date = MEAN(wt_date, b_date);
   format wt_date b_date nxt_date avg_date date7. 
          age_wt 4.1; 
   DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
RUN;

PROC PRINT data=diet;
  title 'The diet data set with three new variables';
RUN;

* Example 22.4. The following SAS program illustrates again 
how you can treat date variables as any other numeric variable, 
and therefore can sort dates. The diet data set is sorted by 
nxt_date in ascending order, so that the individuals whose next 
weigh-in date is closest in time appear first:;

PROC SORT data = diet out = sorteddiet;
   by nxt_date;
RUN;

PROC PRINT data = sorteddiet;
   TITLE 'The diet data set sorted by nxt_date';
RUN;

* Example 22.5. The following SAS program illustrates how 
to compare the values of a date variable, not to the values 
of some other date variable, but rather to a date constant. 
Specifically, the WHERE= option that appears on the DATA 
statement tells SAS to output to the diet data set only 
those individuals whose b_date is before January 1, 1960:;

* used in the WHERE= option. In general, a SAS date 
constant takes the form 'ddMONyyyy'd where dd denotes 
the day of the month (0, ..., 31), MON denotes the first 
three letters of the month, and yyyy denotes the four-digit 
year. The letter d that follows the date in single quotes 
tells SAS to treat the date string like a constant. Note 
that regardless of how you have informatted or formatted 
your SAS dates, the SAS date constant always takes the 
above form.;

* Comparing Dates;
DATA diet (where = (b_date < '01jan1960'd));
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.; 
  format wt_date b_date date9.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
RUN;
 
PROC PRINT data=diet;
  title 'Birthdays in the diet data set before 01/01/1960';
RUN;

* Example 22.6. The following SAS program creates a 
temporary SAS data set called createdates that contains 
six date variables. The variables current1 and current2 
are assigned the current date using the date( )and today( ) 
functions. The variable current3 is assigned the 95th day 
of the 2008 year using the datejul( ) function. The 
variables current4 and current5 are assigned the date 
April 4th, 2008 using the mdy( ) function. And, the 
variable current6 is assigned the date April 1st, 2008 
using the yyq( ) function.;

* Using functions to create date values;

DATA createdates;
  current1= date();
  current2 = today();
  current3 = datejul(2008095);
  mon = 4; day = 4; year = 2008;
  current4 = mdy(mon, day, year);
  current5 = current4;
  current6 = yyq(2008, 2);
  format current1 current2 current3 current5 current6 date9.;
RUN;

PROC PRINT data=createdates;
  title 'The createdates data set';
  var current1 current2 current3 current4 current5 current6;
RUN;

* Example 22.7. The following SAS program uses the day( ), 
month( ) and year( ) functions to extract the month, day 
and year from the wt_date variable:;

DATA takeapart;
   input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.;
   wt_mo = month(wt_date);
   wt_day = day(wt_date);
   wt_yr = year(wt_date);
   format wt_date b_date date9.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
  
RUN;
 
PROC PRINT data=takeapart;
  title 'The dissected weight dates';
  var wt_date wt_mo wt_day wt_yr;
RUN;

* Example 22.8. The following SAS program contains four assignment 
statements that "massage" the wt_date variable. The variable wt_jul1 
is assigned the SAS Julian date in yyddd format. The variable 
wt_jul2 is assigned the SAS Julian date in yyyyddd format. 
The variable wt_qtr is assigned the quarter in which the 
wt_date occurs, and the variable wt_day is assigned the weekday 
on which the wt_date occurs:;

DATA massaged;
   input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.;
   wt_jul1 = juldate(wt_date);
   wt_jul2 = juldate7(wt_date);
   wt_qtr = qtr(wt_date);
   wt_day = weekday(wt_date);
   format wt_date b_date date9.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
  
RUN;

PROC PRINT data = massaged;
  title 'The massaged data set';
  var wt_date wt_jul1 wt_jul2 wt_qtr wt_day;
RUN;

* Example 22.9. The following SAS program uses the yrdif( ) 
function to calculate the difference between the subject's 
birth date (b_date) and first weight date (wt_date1) in 
order to determine the subject's age. And, the datdif( ) 
function is used to calculate days, the difference between 
the subject's first (wt_date1) and second (wt_date2) 
weight dates:;

DATA diet;
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date1 mmddyy8. @43 wt_date2 mmddyy8. @52 
        b_date mmddyy8.;
  age  = yrdif(b_date, wt_date1, 'act/act');
  days = datdif(wt_date1, wt_date2, 'act/act');
  format wt_date1 wt_date2 b_date date9.  age 4.1;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  03/04/06 01/01/60
1167 Maryann     White  1 68 140 12/01/05 03/07/06 01/01/59
1168 Thomas      Jones  2    190 12/2/05  3/30/06  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 2/27/06  12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   4/1/06   06/15/58
  ;
RUN;

PROC PRINT data=diet;
   TITLE "The calculation of subject's age";
   var subj b_date wt_date1 age;
RUN;

PROC PRINT data=diet;
   TITLE 'The calculation of days between weighings';
   var subj wt_date1 wt_date2 days;
RUN;

* Example 22.10. Recall that the intck( ) function 
returns the number of time intervals, such as the number 
of days or years, that occur between two dates. The following 
SAS program is identical to the previous program, except 
here the subjects' ages at their first weigh-in are determined 
using both the yrdif( ) and intck( ) functions to get age_yrdif
and age_intchk, respectively. Similarly, the numbers of days 
between the subjects' two weigh-ins are determined using both 
the datdif( ) and intck( ) functions to get days_datdif and 
days_intchk, respectively:;

DATA diet;
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date1 mmddyy8. @43 wt_date2 mmddyy8. @52 
         b_date mmddyy8.;
  age_yrdif  = yrdif(b_date, wt_date1, 'act/act');
  age_intck = intck('year', b_date, wt_date1);
  days_datdif = datdif(wt_date1, wt_date2, 'act/act');
  days_intck = intck('day', wt_date1, wt_date2);
  format wt_date1 wt_date2 b_date date9.  age 4.1;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  03/04/06 01/01/60
1167 Maryann     White  1 68 140 12/01/05 03/07/06 01/01/59
1168 Thomas      Jones  2    190 12/2/05  3/30/06  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 2/27/06  12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   4/1/06   06/15/58
  ;
RUN;

PROC PRINT data=diet;
   TITLE "The calculation of subject's age";
   var subj b_date wt_date1 age_yrdif age_intck;
RUN;

PROC PRINT data=diet;
   TITLE 'The calculation of days between weighings';
   var subj wt_date1 wt_date2 days_datdif days_intck;
RUN;

* Example 22.11. The following SAS program uses the intck( ) 
function and SAS date constants to determine the number of 
days, weeks, months, and years between December 31, 2006 and 
January 1, 2007. It also calculates the number of years 
(years2) between January 1, 2007 and December 31, 2007, 
and the number of years (years3) between January 1, 2007 and 
January 1, 2008:;

DATA timeintervals1;
     days = intck('day', '31dec2006'd,'01jan2007'd);
     weeks = intck('week', '31dec2006'd,'01jan2007'd);
	 months = intck('month', '31dec2006'd,'01jan2007'd);
	 years = intck('year', '31dec2006'd,'01jan2007'd);
	 years2 = intck('year', '01jan2007'd, '31dec2007'd);
	 years3 = intck('year', '01jan2007'd, '01jan2008'd);
RUN;

PROC PRINT data = timeintervals1;
    TITLE 'Time intervals as calculated by intck function';
RUN;

* Example 22.12. In an attempt to explore the intck( ) 
function further, the following SAS program uses the intck( ) 
function and SAS date constants to determine the number of 
days, weeks, weekdays, months, qtrs, and years between 
March 15, 2007 and March 15, 2008:;

DATA timeintervals2;
    days = intck('day', '15mar2007'd,'15mar2008'd);
	weeks = intck('week', '15mar2007'd,'15mar2008'd);
	weekdays = intck('weekday', '15mar2007'd,'15mar2008'd);
	months = intck('month', '15mar2007'd,'15mar2008'd);
	qtrs = intck('qtr', '15mar2007'd,'15mar2008'd);
	years = intck('year', '15mar2007'd,'15mar2008'd);
RUN;

PROC PRINT data = timeintervals2;
    TITLE 'Time intervals as calculated by intck function';
RUN;

* Example 22.13. Now, suppose that each subject appearing in 
the diet data set needs to be weighed again in three months. 
The following SAS program uses the subject's previous weight 
date (wt_date) and various versions of the intnx( ) function 
to determine various versions of each subject's next weight 
date:;

DATA diet;
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.;
  nxdate_b1 = intnx('month', wt_date, 3);
  nxdate_b2 =  intnx('month', wt_date, 3, 'beginning');
  nxdate_m = intnx('month', wt_date, 3, 'middle');
  nxdate_e = intnx('month', wt_date, 3, 'end');
  nxdate_s = intnx('month', wt_date, 3, 'sameday');
  format wt_date b_date nxdate_b1 nxdate_b2 
         nxdate_m nxdate_e nxdate_s date9.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60
1167 Maryann     White  1 68 140 12/01/05 01/01/59
1168 Thomas      Jones  2    190 12/2/05  06/15/60
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58
  ;
RUN;

PROC PRINT data=diet;
  TITLE 'The data set containing next weight dates';
  VAR subj wt_date nxdate_b1 nxdate_b2 
      nxdate_m nxdate_e nxdate_s;
RUN;

