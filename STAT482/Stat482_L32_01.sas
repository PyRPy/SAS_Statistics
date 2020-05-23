* Lesson 32: Introduction to SAS SQL;
* Example 32.1  The following SAS SQL code is just query 
that retrieves data from a single table:;
libname stat482 "C:\Data_SAS";

PROC SQL;
	select ID,
           SATM,
           SATV
	from stat482.survey2;
QUIT;

* Example 32.2  The following SAS program changes the 
ODS destination from listing to pdf. So the output will 
be saved under the predefined directory as pdf file.;

ods listing close;
ods pdf file="C:\Data_SAS\sat_scores.pdf";

PROC SQL;
	select ID,
               SATM,
               SATV
	from stat482.survey2;
run;
quit;

ods pdf close;
ods listing;

* Example 32.3  The following SAS program uses CREATE TABLE 
statement to create a new table named SAT_scores, which 
contains student id, SAT math scores and verbal scores.;

PROC SQL;
	CREATE TABLE SAT_Scores as
	select ID,
       	       SATM,
               SATV
	from stat482.survey2;
run;
quit;

* Example 32.4  The following SAS program creates a new 
temporary table with all columns retrieved from permanent 
file traffic.sas7bdat:;

PROC SQL;
CREATE TABLE traffic as
	select *
	from stat482.traffic;
QUIT;

PROC CONTENTS data=traffic VARNUM; 
RUN;

PROC CONTENTS data=stat482.traffic VARNUM;
RUN;


* Example 32.5  The following program is to create new columns 
with the SELECT statement:;
* scan is a char function ;
PROC SQL;
	select id, 
               count_location,
	       scan(count_location,-1,' ') as orientation,
	       street,
	       passing_vehicle_volume * 0.5 as weekends_traffic_volume
	from  traffic;
QUIT;

* Example 32.6  The following program adds the format to 
dates, labels columns and add titles to the output:;

PROC SQL;
	TITLE "Traffic volume in Area SS";
	TITLE2 "During weekdays and weekends";
	select id, 
               Date_of_count label='Date of Count' format=mmddyy10.,
               count_location label='Location',
	       street,
	       passing_vehicle_volume label='Daily Volume' format=comma6.,
	       passing_vehicle_volume * 0.5 as weekends_traffic_volume label='Weekends Volume' format=comma6.
        from  traffic;
QUIT;
