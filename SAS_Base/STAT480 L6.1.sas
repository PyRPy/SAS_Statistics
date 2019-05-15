* 6.1 - Basic Reports;
* Example 6.1. The following SAS code merely creates a baseline data set called 
basic that we can print throughout the lesson:;


OPTIONS LS = 75 PS = 58 NODATE;

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

PROC PRINT data = basic;
RUN;

* Example 6.2. By default, the PRINT procedure lists all of the variables contained 
in a SAS data set. We can use the PRINT procedure's VAR statement to not only select 
variables, but also to control the order in which the variables appear in our reports. 
The following SAS program uses the VAR statement to tell SAS to print just a subset 
of the variables — name, no_vis and expense — contained in the basic data set:;

PROC PRINT data = basic;
   var name no_vis expense;
RUN;

* Example 6.3. Using the NOOBS option, we can suppress the printing of the default 
observation number. The following SAS program illustrates the PRINT procedure's NOOBS 
option:;

PROC PRINT data = basic noobs;
   var name no_vis expense;
RUN;