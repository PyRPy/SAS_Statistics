
DATA basic;
  input subj 1-4 name $ 6-23 clinic $ 25-28 
        gender 30 no_vis 32-33 type_vis 35-37
        expense 39-45;
  DATALINES;
1024 Alice Smith        LEWN 1  7 101 1001.98
1167 Maryann White      LEWN 1  2 101 2999.34
1168 Thomas Jones       ALTO 2 10 190 3904.89
1201 Benedictine Arnold ALTO 2  1 190 1450.23
1302 Felicia Ho         MNMC 1  7 190 1209.94
1471 John Smith         MNMC 2  6 187 1763.09
1980 Jane Smiley        MNMC 1  5 190 3567.00
  ;
RUN;

* Example 6.4. Using the ID statement, we can emphasize one or more key variables. 
The ID statement, which automatically suppresses the printing of the observation 
number, tells SAS to print the variable(s) specified in the ID statement as the 
first column(s) of your output. Thus, the ID statement allows you to use the 
values of the variables to identify observations, rather than the 
(usually meaningless) observation number. The following SAS code 
illustrates the use of the ID statement option:;


PROC PRINT data = basic;
   id name;
   var gender expense;
RUN;

* Example 6.5. It is particularly useful to use the ID statement 
when observations are so long that SAS can't print them on one line. 
In that case, SAS breaks up the observations and prints them on 
two (or more lines). When that happens, it is helpful to use an 
ID variable (or more) so that you can keep track of the observations. 
The following SAS code illustrates such a situation:;

OPTIONS LS = 64 PS = 58 NODATE;

PROC PRINT data = basic;
   id name;
   var subj name clinic gender 
       subj no_vis type_vis expense;
RUN;

* not shown as it said above;

* 6.3 - Selecting Observations;
* Example 6.6. The following SAS code uses the PRINT procedure's 
FIRSTOBS= and OBS= options to the second, third, fourth and fifth 
observations of the basic data set:;
OPTIONS LS = 75 PS = 58 NODATE;

PROC PRINT data = basic (FIRSTOBS = 2 OBS = 5);
   var subj name no_vis expense;
RUN;

* Example 6.7. The FIRSTOBS= and OBS= options tell SAS to print 
observations based on their observation numbers, whereas the WHERE 
statement tells SAS to print observations based on whether or not 
they meet the specified condition. The following SAS code uses the 
WHERE statement to tell SAS to print only those observations for 
which the value of the variable no_vis is greater than 5:;

PROC PRINT data = basic;
   var name no_vis type_vis expense;
   where no_vis > 5;
RUN;
* Example 6.8. The following SAS code uses the CONTAINS operator 
to select observations in the basic data set for which the name 
variable contains the substring 'Smi':;

PROC PRINT data = basic;
    var name gender no_vis type_vis expense;
	where name contains 'Smi';
RUN;

* 6.4 - Sorting Data;

* Example 6.9. The following SAS program uses the SORT procedure 
to sort the basic data set first by clinic name (clinic) and then 
by the number of visits (no_vis) before printing the (sorted) data 
set srtd_basic:;

PROC SORT data = basic out = srtd_basic;
   by clinic no_vis;
RUN;

PROC PRINT data = srtd_basic NOOBS;
   var clinic no_vis subj name gender type_vis expense;
RUN;

* Example 6.10. The following SAS program uses the BY statement's DESCENDING 
option to tell SAS to sort the basic data set first by clinic name (clinic) 
in descending order, and then by the number of visits (no_vis) in ascending 
order:;

PROC SORT data = basic out = srtd_basic;
   by descending clinic no_vis;
RUN;

PROC PRINT data = srtd_basic NOOBS;
   var clinic no_vis subj name gender type_vis expense;
RUN;
