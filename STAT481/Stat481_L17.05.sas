* 17.2 - The RETAIN Statement;
* Example 17.5. Throughout the remainder of the lesson, we 
will work with the grades data set that is created in the 
following DATA step:;

DATA grades;
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

* Example 17.6. One of the most powerful uses of a RETAIN 
statement is to compare values across observations. The 
following program uses the RETAIN statement to compare values 
across observations, and in doing so determines each student's 
lowest grade of the four semester exams:;

PROC PRINT data = grades NOOBS;
   title 'The grades data set';
RUN;

DATA exams;
  set grades (where = (gtype in ('E1', 'E2', 'E3', 'E4')));
RUN;

DATA lowest (rename = (lowtype = gtype));
   set exams;
   by idno;
   retain lowgrade lowtype;
   if first.idno then lowgrade = grade;
   lowgrade = min(lowgrade, grade);
   if grade = lowgrade then lowtype = gtype;
   if last.idno then output;
   drop gtype;
RUN;

PROC PRINT data=lowest;
   title 'Output Dataset: LOWEST';
RUN;

* 17.3 - Automatic Retention;

* Example 17.7. The following SAS program calculates the students' 
final grades, and in so doing illustrates the automatic retention 
of two variables a variable whose value is assigned in a SUM 
statement (total) and a variable created by the IN = option (lowest):;

PROC SORT data=grades;
  by idno gtype;
RUN;

DATA final;
   merge grades lowest (in=lowest);
   by idno gtype;
   if lowest then delete;  
   if first.idno then total = 0;
   total + grade;
   if last.idno then fnl = (total/600)*100;
   format fnl 5.1;
   drop lowgrade gtype;
RUN;

PROC PRINT data=final;
  title 'Output Dataset: FINAL GRADES';
RUN;

* 17.4 - Transposing a Data Set;

* Example 17.8. The following program illustrates a failed 
attempt at transposing the original "tall" grades data set 
(one observation per grade) to a "fat" data set 
(one observation per student):;

DATA grades2;
   set grades;
   by idno;
          if gtype = 'E1' then E1 = grade;
     else if gtype = 'E2' then E2 = grade;
     else if gtype = 'E3' then E3 = grade;
     else if gtype = 'E4' then E4 = grade;
     else if gtype = 'P1' then P1 = grade;
     else if gtype = 'F1' then F1 = grade;
   if last.idno then output;
   drop gtype grade;
RUN;

PROC PRINT data=grades2;
   title 'Output Dataset: FAULTY TRANSPOSED GRADES';
RUN;

* The following program correctly makes the transposition using 
the RETAIN statement:;

DATA grades3;
   set grades;
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

PROC PRINT data=grades3;
  title 'Output Dataset: TRANSPOSED GRADES';
RUN;

* Now, launch and run  the SAS program, and review the output 
from the PRINT procedure to convince yourself that this time 
the grades E1, E2, ..., F1 are appropriately assigned and 
retained. Also, note that we have successfully transposed 
the grades data set from a "tall" data set to a "fat" data set.

Just to close the loop, the following program calculates the 
final grades of the students using the newly transposed data set:;

DATA grades4;
   set grades3;
         if E1 = min(E1, E2, E3, E4) then E1 = .;
    else if E2 = min(E1, E2, E3, E4) then E2 = .;
    else if E3 = min(E1, E2, E3, E4) then E3 = .;
    else if E4 = min(E1, E2, E3, E4) then E4 = .;
    fnl = sum(E1, E2, E3, E4, P1, F1)/6;
    format fnl 5.1;
RUN;

PROC PRINT data=grades4;
  title 'Output Dataset: FINAL GRADES calculated from TRANSPOSED GRADES';
RUN;

