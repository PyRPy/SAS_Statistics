* 19.5 - Array Bounds;
* Example 19.12. The following program reads the yes/no 
responses of five subjects to six survey questions 
(q1, q2, ..., q6) into a temporary SAS data set called survey. 
A yes response is coded and entered as a 2, while a no 
response is coded and entered as a 1. Just four of the 
variables (q3, q4, q5, and q6) are stored in a one-dimensional 
array called qxs. Then, a DO LOOP, in conjunction with the 
DIM function, is used to recode the responses to the four 
variables so that a 2 is changed to a 1, and a 1 is changed 
to a 0:;

DATA survey (DROP = i);
   INPUT subj q1 q2 q3 q4 q5 q6;
   ARRAY qxs(4) q3-q6;
   DO i = 1 to dim(qxs);
      qxs(i) = qxs(i) - 1;
   END;
   DATALINES;
   1001 1 2 1 2 1 1
   1002 2 1 2 2 2 1
   1003 2 2 2 1 . 2
   1004 1 . 1 1 1 2
   1005 2 1 2 2 2 1
   ;
RUN;

PROC PRINT data = survey;
   TITLE 'The survey data using dim function';
RUN;

* Example 19.13. As previously discussed and illustrated, 
if you do not specifically tell SAS the lower bound of 
an array, SAS assumes that the lower bound is 1. For most 
arrays, 1 is a convenient lower bound and the number of 
elements is a convenient upper bound, so you usually don't 
need to specify both the lower and upper bounds. However, 
in cases where it is more convenient, you can modify both 
bounds for any array dimension.;

DATA survey2 (DROP = i);
   INPUT subj q1 q2 q3 q4 q5 q6;
   ARRAY qxs(3:6) q3-q6;
   DO i = 3 to 6;
      qxs(i) = qxs(i) - 1;
   END;
   DATALINES;
   1001 1 2 1 2 1 1
   1002 2 1 2 2 2 1
   1003 2 2 2 1 . 2
   1004 1 . 1 1 1 2
   1005 2 1 2 2 2 1
   ;
RUN;

PROC PRINT data = survey2;
   TITLE 'The survey data using bounded arrays';
RUN;

* Example 19.14. Now, there's still a little bit more that 
we can do to automate the handling of the bounds of an array 
dimension. The following program again uses a one-dimensional 
array qxs to recode four survey variables as did the previous 
two programs. Here, though, an asterisk (*) is used to tell 
SAS to determine the dimension of the qxs array, and the LBOUND 
and HBOUND functions are used to tell SAS to determine, 
respectively, the lower and upper bounds of the DO loop's index 
variable dynamically:;

DATA survey3 (DROP = i);
   INPUT subj q1 q2 q3 q4 q5 q6;
   ARRAY qxs(*) q3-q6;
   DO i = lbound(qxs) to hbound(qxs);
      qxs(i) = qxs(i) - 1;
   END;
   DATALINES;
   1001 1 2 1 2 1 1
   1002 2 1 2 2 2 1
   1003 2 2 2 1 . 2
   1004 1 . 1 1 1 2
   1005 2 1 2 2 2 1
   ;
RUN;

PROC PRINT data = survey3;
   TITLE 'The survey data by changing upper and lower bounds automatically';
RUN;

* 19.6 - Using Arrays to Transpose a Data Set;
* Example 19.15. Throughout this section, we will work 
with the tallgrades data set that is created in the 
following DATA step:;

DATA tallgrades;
    input idno 1-2 l_name $ 5-9 gtype $ 12-13 grade 15-17;
    cards;
10  Smith  E1  78
10  Smith  E2  82
10  Smith  E3  86
10  Smith  E4  69
10  Smith  P1  97
10  Smith  F1 160
11  Simon  E1  88
11  Simon  E2  72
11  Simon  E3  86
11  Simon  E4  99
11  Simon  P1 100
11  Simon  F1 170
12  Jones  E1  98
12  Jones  E2  92
12  Jones  E3  92
12  Jones  E4  99
12  Jones  P1  99
12  Jones  F1 185
;
RUN;

PROC PRINT data = tallgrades NOOBS;
   TITLE 'The tall grades data set';
RUN;

* Example 19.16. (You might recall seeing this program a 
few lessons ago.) Using RETAIN and OUTPUT statements, 
the following program takes advantage of BY-group processing, 
as well as RETAIN and OUTPUT statements, to transpose the 
tallgrades data set (one observation per grade) into the 
fatgrades data set (one observation per student):;

DATA fatgrades;
   set tallgrades;
   by idno;
          if gtype = 'E1' then E1 = grade;
     else if gtype = 'E2' then E2 = grade;
     else if gtype = 'E3' then E3 = grade;
     else if gtype = 'E4' then E4 = grade;
     else if gtype = 'P1' then P1 = grade;
     else if gtype = 'F1' then F1 = grade;
   if last.idno then output;
   retain E1 E2 E3 E4 P1 F1;
   drop gtype grade;
RUN;

PROC PRINT data=fatgrades;
  title 'The fat grades data set';
RUN;

* Example 19.17. The following program uses an array to 
transpose the tallgrades data set (one observation per grade) 
into the fatgrades data set (one observation per student):;

DATA fatgrades;
   set tallgrades;
   by idno;
   array allgrades (6) G1 - G6;
   if first.idno then i = 1;
   allgrades(i) = grade;
   if last.idno then output;
   i + 1;
   retain G1 - G6;
   drop i gtype grade;
RUN;

PROC PRINT data=fatgrades;
  title 'The fat grades data set';
RUN;
* In the previous example, perhaps you find it a little 
awkward that the array element qxs(1) corresponds to the 
q3 variable, the array element qxs(2) corresponds to the q4 
variable, and so on. Perhaps you would find it more clear 
for the array element qxs(3) to correspond to the q3 
variable, the array element qxs(4) to correspond to the q4 
variable, ..., and the array element qxs(6) to correspond 
to the q6 variable. The following program is similar in 
function to the previous program, except here the task of 
recoding is accomplished by defining the lower bound of 
the qxs array to be 3 and the upper bound to be 6:;


* 19.7 - Two-Dimensional Arrays ;
* Example 19.18. The following program reads 14 family 
history variables (fhx1, ..., fhx14) arising from five 
subjects and stores the data in a one-dimensional array 
called edit. Then, SAS searches the edit array to determine 
whether or not any data values are missing. Fourteen (14) 
status variables (stat1, ..., stat14) are created to correspond 
to each of the 14 data variables. The status (1 if missing and 
0 if nonmissing) is stored in another one-dimensional array 
called status:;

DATA fhx;
  input subj v_date mmddyy8. fhx1-fhx14;
  array edit(14) fhx1-fhx14;
  array status(14) stat1-stat14;
  do i = 1 to 14;
      status(i) = 0;
      if edit(i) = . then status(i) = 1;
  end;
  DATALINES;
220004  07/27/93  0  0  0  .  8  0  0  1  1  1  .  1  0  1
410020  11/11/93  0  0  0  .  0  0  0  0  0  0  .  0  0  0
520013  10/29/93  0  0  0  .  0  0  0  0  0  0  .  0  0  1
520068  08/10/95  0  0  0  0  0  1  1  0  0  1  1  0  1  0
520076  08/25/95  0  0  0  0  1  8  0  0  0  1  1  0  0  1
;
RUN;

PROC PRINT data = fhx;
   var fhx1-fhx14;
   TITLE 'The FHX data itself';
RUN;

PROC PRINT data = fhx;
   var stat1-stat14;
   TITLE 'The presence of missing values in FHX data';
RUN;

* Example 19.19. The previous program was written merely 
as a prelude to this example, in which the code is modified 
to illustrate the use of two-dimensional arrays. This program 
performs exactly the same task as the previous program, namely 
searching a subset of family history data for missing values. 
Here, though, we use one two-dimensional array called edit 
instead of two one-dimensional arrays:;

DATA fhx2;
  input subj v_date mmddyy8. fhx1-fhx14;
  array edit(2,14) fhx1-fhx14 stat1-stat14;
  do i = 1 to 14;
      edit(2,i) = 0;
      if edit(1,i) = . then edit(2,i) = 1;
  end;
  DATALINES;
220004  07/27/93  0  0  0  .  8  0  0  1  1  1  .  1  0  1
410020  11/11/93  0  0  0  .  0  0  0  0  0  0  .  0  0  0
520013  10/29/93  0  0  0  .  0  0  0  0  0  0  .  0  0  1
520068  08/10/95  0  0  0  0  0  1  1  0  0  1  1  0  1  0
520076  08/25/95  0  0  0  0  1  8  0  0  0  1  1  0  0  1
;
RUN;

PROC PRINT data = fhx2;
   var fhx1-fhx14;
   TITLE 'The FHX2 data itself';
RUN;

PROC PRINT data = fhx2;
   var stat1-stat14;
   TITLE 'The presence of missing values in FHX2 data';
RUN;

* First, if you compare this program with the previous 
program, you should notice that the two programs have 
more similarities than differences. Here, we have just 
one ARRAY statement that defines the two-dimensional array 
edit containing 2 rows and 14 columns. The ARRAY statement 
tells SAS to group the family history variables (fhx1, ..., fhx14) 
into the first dimension and to group the status variables 
(stat1, ..., stat14) into the second dimension. Then, 
the DO loop tells SAS to review the contents of the 14 
variables and to assign each element of the status 
dimension a value of 0 ("edit(2,i) = 0")

* If the element of the edit dimension is missing, 
however, then SAS is told to change the element of 
the status dimension from a 0 to a 1 ("if edit(1,i) = . 
then edit(2,i) = 1");


