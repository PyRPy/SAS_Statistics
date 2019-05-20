* 6.5 - Column Totals;
* https://newonlinecourses.science.psu.edu/stat480/node/51/;

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

* Example 6.11. The following SAS code uses the PRINT procedure's 
SUM statement to generate a report of the total number of visits 
(no_vis) for patients undergoing physical therapy (type_vis = 190):;

PROC PRINT data = basic;
   id name;
   var clinic no_vis;
   where type_vis = 190;
   sum no_vis;
RUN;

* The ID statement tells SAS to suppress the observation number and 
to place the variable name in the first column of the output. 
The WHERE statement tells SAS to print only the observations 
pertaining to a physical therapy appointment (type_vis = 190). 
The SUM statement tells SAS to provide the total number of visits 
(no_vis) the patients undergoing physical therapy had.;


* Example 6.12. There may be situations in which you want not just 
column totals, but also column subtotals. Using the PRINT procedure's 
BY statement, you can tell SAS to print observations in groups based 
on the values of the different BY variables. When a SUM statement is 
specified in the presence of a BY statement, SAS produces subtotals 
each time the value of a BY variable changes.

The following SAS program illustrates use of the BY statement in 
conjunction with the SUM statement to print the data in our basic 
data set in three groups based on the value of clinic, as well as 
display the total expense for each of the three groups separately:;

PROC SORT data = basic out = srtd_basic;
  by clinic;
RUN;

PROC PRINT data = srtd_basic;
   by clinic;
   var subj name no_vis type_vis expense;
   sum expense;
RUN;

* Example 6.13. If you take a look at the output from the previous 
example, you should see that the columns don't line up across the 
three clinics. The UNIFORM option tells SAS to make sure the columns 
of data line up from one group to the next. Without the UNIFORM 
statement, the PRINT procedure works to fit as many variables and 
observations on the page as possible. As a result, printed columns 
can be shifted from one group to the next. In the PRINT procedure 
in the previous example, no UNIFORM option was specified. Therefore, 
since a different number of characters are needed for name for the 
three groups, the columns are not aligned.

The PRINT procedure in the following SAS program illustrates use 
of the UNIFORM option to remedy this problem:;

PROC SORT data = basic out = srtd_basic;
  by clinic;
RUN;

PROC PRINT data = srtd_basic UNIFORM;
   by clinic;
   var subj name no_vis type_vis expense;
   sum expense;
RUN;

* not applicable for the case above anymore in the new version of SAS

* Example 6.14. In the output from the previous two examples, you 
might have noticed that redundant information is displayed for each 
group. For example, the BY variable clinic is identified across the 
top of the data for each group, as well as for the subtotal for each group. 
To show the BY variable heading only once, you can use an ID statement 
and a BY statement in conjunction with the SUM statement. When an ID 
statement specifies the same variable as the BY statement: 
(1) the observation number is suppressed, 
(2) the ID variable is printed as the first column of the report, and 
(3) each value of the ID variable is printed only at the start of 
each BY group and on the line that contains that group's subtotal.;

PROC SORT data = basic out = srtd_basic;
  by clinic;
RUN;

PROC PRINT data = srtd_basic UNIFORM;
   by clinic;
   var subj name no_vis type_vis expense;
   sum expense;
   id clinic;
RUN;

* Example 6.15. Rather than having SAS display the output for each group 
on the same page, you can take advantage of the PAGEBY statement to 
tell SAS to print each group on a separate page. The following SAS program 
creates the same output as the previous example, except here we request 
that the clinics be printed on separate pages:;

PROC SORT data = basic out = srtd_basic;
  by clinic;
RUN;

PROC PRINT data = srtd_basic UNIFORM;
   by clinic;
   var subj name no_vis type_vis expense;
   sum expense;
   id clinic;
   pageby clinic;
RUN;

