* Example 3.8. The following SAS program uses the @n column pointer control 
and standard numeric informats to read three numeric 
variables , subj, height, and weight , into a temporary SAS data set called temp:;

DATA temp;
  input @1  subj 4. 
        @27 height 2. 
        @30 weight 3.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  ;
RUN;

PROC PRINT data = temp;
  title 'Output dataset: TEMP';
RUN;

* Example 3.9. The following SAS program uses the @n column pointer 
control and standard character and numeric informats to read, respectively, 
two character variables, l_name and f_name, and two numeric variables , 
weight and height , into a temporary SAS data set called temp:;

DATA temp;
  input @18 l_name $6.
        @6  f_name $11. 
	@30 weight 3.
	@27 height 2.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  ;
RUN;

* Example 3.10. In addition to using @n absolute pointer controls with 
numeric and character informats, the following SAS program uses +n relative 
pointer controls with nonstandard informats to create a temporary SAS data 
set called temp containing six variables:;

DATA temp;
  input @1  subj 4. 
        @6  f_name $11. 
	@18 l_name $6.
	+3 height 2. 
        +5 wt_date mmddyy8. 
        +1 calorie comma5.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  ;
RUN;

PROC PRINT data = temp;
  title 'Output dataset: TEMP';
RUN;

