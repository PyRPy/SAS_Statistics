
* 22.3 - SAS Date Informats and Formats;
* Example 22.14. The following SAS program reads in three dates 
(date1, date2, and date3) using an mmddyy informat. Then, the 
dates are printed using a ddmmyy format:;

DATA inputdates1;
     INPUT @6 date1 mmddyy6. @13 date2 mmddyy8. @22 date3 mmddyy10.;
	 FORMAT date1 ddmmyy10. date2 ddmmyyb10. date3 ddmmyyc10.;
	 DATALINES;
     041008 04-10-08 04 10 2008
	 ;
RUN;

PROC PRINT data = inputdates1;
   TITLE 'The mmddyy informat and the ddmmyy format';
RUN;

* Example 22.15. The following SAS program reads in 
three dates (date1, date2, and date3) using a ddmmyy 
informat. Then, the dates are printed using a mmddyy 
format:;
DATA inputdates2;
     INPUT @6 date1 ddmmyy6. @13 date2 ddmmyy8. @22 date3 ddmmyy10.;
	 FORMAT date1 mmddyyd10. date2 mmddyyn8. date3 mmddyyp10.;
	 DATALINES;
     100408 10-04-08 10 04 2008
	 ;
RUN;

PROC PRINT data = inputdates2;
   TITLE 'The ddmmyy informat and the mmddyy format';
RUN;

* NOTE The "d" that appears in the format for the date1 
variable tells SAS to display dashes between the month, 
day and year. The "n" that appears in the format for the 
date2 variable tells SAS to display nothing between the 
month, day and year. (Note that the width of the mmddyyn8. 
format is 8, and not 10. If you specify a width of 10 with 
the "n" extension, SAS will hiccup.) The "p" that appears 
in the format for the date3 variable tells SAS to display 
periods between the month, day and year.;


* Example 22.16. The following SAS program reads in three 
dates (date1, date2, and date3) using a date informat. 
Then, the dates are printed using weekdate, worddate, and 
worddatx formats, respectively:;

DATA inputdates3;
     INPUT @6 date1 date7. @14 date2 date9. @24 date3 date11.;
	 FORMAT date1 weekdate25. 
            date2 worddate19.
            date3 worddatx19.;
	 DATALINES;
     10Apr08 10Apr2008 10-Apr-2008
	 ;
RUN;

PROC PRINT data = inputdates3;
   TITLE 'The date7 informat and the weekdate and worddate formats';
RUN;

* 22.4 - SAS Date System Options;
* Example 22.17. The following SAS program uses the default 
YEARCUTOFF = 1920 to read in nine dates that contain two-digit 
years ranging from 20 to 99, and then from 00 to 19:;

OPTIONS YEARCUTOFF=1920;

DATA twodigits1920;
  INPUT date1 mmddyy8.;
  FORMAT date1 worddatx20.;
  DATALINES;
01/03/20
01/03/21
01/03/49
01/03/50
01/03/51
01/03/99
01/03/00
01/03/01
01/03/19
  ;
RUN;

PROC PRINT data=twodigits1920;
  title 'Years with two-digits when YEARCUTOFF = 1920';
RUN;

* Example 22.18. The following SAS program is identical to 
the previous program except the YEARCUTOFF= system option 
has been changed to 1950. As before, SAS reads in nine dates 
that contain two-digit years ranging from 20 to 99, and then 
from 00 to 19:;

OPTIONS YEARCUTOFF=1950;

DATA twodigits1950;
  INPUT date1 mmddyy8.;
  FORMAT date1 worddatx20.;
  DATALINES;
01/03/20
01/03/21
01/03/49
01/03/50
01/03/51
01/03/99
01/03/00
01/03/01
01/03/19
  ;
RUN;

PROC PRINT data=twodigits1950;
  title 'Years with two-digits when YEARCUTOFF = 1950';
RUN;

* 22.5 - SAS Time Basics;
* Using Informats and Formats to Input and Display a SAS Time;
* Example 22.19. The following SAS program reads five 
observations into a SAS data set called diet. One of 
the variables weight time (wt_time) is in hh:mm:ss 
format, and therefore SAS is told to read the dates using 
the time8. informat:;

DATA diet;
  input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.
        @52 wt_time time8.;
  wtm_fmt1 = wt_time;
  wtm_fmt2 = wt_time;
  wtm_fmt3 = wt_time;
  format wtm_fmt1 hhmm.
         wtm_fmt2 hour5.2
         wtm_fmt3 time8.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60 00:01:00
1167 Maryann     White  1 68 140 12/01/05 01/01/59 00:15:00
1168 Thomas      Jones  2    190 12/2/05  06/15/60 12:00:00
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60 00:00:00
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58 23:59:59
  ;
RUN;

PROC PRINT data=diet;
  title 'The diet data set with formatted weight times';
  var subj wt_time wtm_fmt1 wtm_fmt2 wtm_fmt3;
RUN;

* Using SAS Time Functions;
* Example 22.20. The following SAS program illustrates 
the use of the five time functions mentioned above. 
Specifically, the variable curtime is assigned the current 
time using the time( ) function. Then, the hour( ), 
minute( ) and second( ) functions are used to extract 
the hours, minutes and seconds from the wt_time variable. 
And finally, the hms( ) function is used to put the hours, 
minutes, and seconds back together again to create a new 
variable called wt_time2 that equals the old wt_time 
variable:;

DATA diet;
     input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.
        @52 wt_time time8.;
     curtime = time();
     wt_hr = hour(wt_time);
     wt_min = minute(wt_time);
     wt_sec = second(wt_time);
     wt_time2 = hms(wt_hr, wt_min, wt_sec);
     format curtime wt_time wt_time2 time8.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60 00:01:00
1167 Maryann     White  1 68 140 12/01/05 01/01/59 00:15:00
1168 Thomas      Jones  2    190 12/2/05  06/15/60 12:00:00
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60 00:00:00
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58 23:59:59
  ;
RUN;

PROC PRINT data=diet;
  title 'The diet data set with five new variables';
  var subj curtime wt_time wt_hr wt_min wt_sec wt_time2;
RUN;

* Comparing Times
Again, because SAS time values are numeric values, 
you can easily compare two or more times The comparisons 
are made just as the comparisons between any two numbers 
would take place. For example, because the time 00:10:00 
is stored as a 600 in SAS, it is considered smaller than 
the time 00:15:00, which is stored as a 900 in SAS.

Example 22.21. The following SAS program illustrates how 
to compare the values of a time variable, not to the values 
of some other time variable, but rather to a time constant. 
Specifically, the WHERE= option on the DATA statement tells 
SAS to output to the diet data set only those individuals 
whose wt_time is between midnight and noon, inclusive:;

DATA diet (where = ((wt_time ge '00:00:00't) 
                and (wt_time le '12:00:00't)));
   input subj 1-4 l_name $ 18-23 weight 30-32
        +1 wt_date mmddyy8. @43 b_date mmddyy8.
        @52 wt_time time8.;
   time_int = abs((wt_time - '05:00:00't)/3600);
   format wt_time time8. time_int 4.1;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/05  01/01/60 00:01:00
1167 Maryann     White  1 68 140 12/01/05 01/01/59 00:15:00
1168 Thomas      Jones  2    190 12/2/05  06/15/60 12:00:00
1201 Benedictine Arnold 2 68 190 11/30/05 12/31/60 00:00:00
1302 Felicia     Ho     1 63 115 1/1/06   06/15/58 23:59:59
  ; 
RUN;

PROC PRINT data=diet;
  title 'The subsetted diet data set';
  var subj l_name wt_time time_int;
RUN;





