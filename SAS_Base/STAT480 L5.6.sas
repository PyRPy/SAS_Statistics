* Example 5.6. The following SAS program illustrates the use of several mutually 
exclusive conditions within an if-then-else statement. The program uses the AND 
operator to define the conditions. Again, when comparisons are connected by AND, 
all of the comparisons must be true in order for the condition to be true.;

DATA grades;
    length overall $ 10;
   	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	avg = round((e1+e2+e3+e4)/4,0.1);   
             if (avg = .)               then overall = 'Incomplete';
	else if (avg >= 90)                 then overall = 'A';
	else if (avg >= 80) and (avg < 90)  then overall = 'B';
	else if (avg >= 70) and (avg < 80)  then overall = 'C';
	else if (avg >= 65) and (avg < 70)  then overall = 'D';
	else if (avg < 65)                  then overall = 'F';	
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name avg overall;
RUN;

* Example 5.7. In the previous program, the conditions were written using the AND 
operator. Alternatively, we could have just used straightforward numerical intervals. 
The following SAS program illustrates the use of alternative intervals as well as 
the alternative syntax for the comparison operators:;

DATA grades;
    length overall $ 10;
   	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	avg = round((e1+e2+e3+e4)/4,0.1);   
		 if (avg EQ .)         then overall = 'Incomplete';
	else if (90 LE avg LE 100) then overall = 'A';
	else if (80 LE avg LT  90) then overall = 'B';
	else if (70 LE avg LT  80) then overall = 'C';
	else if (65 LE avg LT  70) then overall = 'D';
	else if (0  LE avg LT  65) then overall = 'F';	
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name avg overall;
RUN;

*Example 5.8. Now, suppose an instructor wants to give bonus points to students who 
show some sign of improvement from the beginning of the course to the end of the 
course. Suppose she wants to add two points to a student's overall average if either 
her first exam grade is less than her third and fourth exam grade or her second 
exam grade is less than her third and fourth exam grade. (Don't ask why! I'm just 
trying to motivate something here.) The operative words here are "either" and "or". 
In order to accommodate the instructor's wishes, we need to take advantage of the 
OR comparison operator. When comparisons are connected by OR, only one of the 
comparisons needs to be true in order for the condition to be true. The following 
SAS program illustrates the use of the OR operator, the AND operator, and the use 
of the OR and AND operators together:;

DATA grades;
   	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	avg = round((e1+e2+e3+e4)/4,0.1); 
		 if    ((e1 < e3) and (e1 < e4)) 
            or ((e2 < e3) and (e2 < e4)) then adjavg = avg + 2;
    else adjavg = avg;
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 avg adjavg;
RUN;

* Example 5.9. Suppose our now infamous instructor wants to identify those students 
who either did not complete the course or failed. Because SAS is case-sensitive, 
any if-then-else statements written to identify the students have to check for 
those students whose status is 'failed' or 'Failed' or 'FAILED' or ... you get 
the idea. One rather tedious solution would be to check for all possible "typings" 
of the word "failed" and "incomp" (for incomplete). Alternatively, we could use 
the UPCASE function to first produce an uppercase value, and then make our 
comparisons only between uppercase values. The following SAS program takes such 
an approach:;

DATA grades;
    length action $ 7 
           action2 $ 7; 
    input name $ 1-15 e1 e2 e3 e4 p1 f1 status $;
	     if (status = 'passed') then action = 'none';
    else if (status = 'failed') then action = 'contact';
	else if (status = 'incomp') then action = 'contact';
	     if (upcase(status) = 'PASSED') then action2 = 'none';
	else if (upcase(status) = 'FAILED') then action2 = 'contact';
	else if (upcase(status) = 'INCOMP') then action2 = 'contact';
	DATALINES;
Alexander Smith  78 82 86 69  97 80 passed
John Simon       88 72 86  . 100 85 incomp
Patricia Jones   98 92 92 99  99 93 PAssed
Jack Benedict    54 63 71 49  82 69 FAILED
Rene Porter     100 62 88 74  98 92 PASSED
;
RUN;

PROC PRINT data = grades;
	var name status action action2;
RUN;


* Example 5.10. Suppose our instructor wants to assign a grade of zero to any 
student who missed the fourth exam, as well as notify the student that she has 
done so. The following SAS program illustrates the use of the DO-END clause to 
accommodate the instructors wishes:;

DATA grades;
   	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	if e4 = . then do;
	    e4 = 0;
		notify = 'YES';
	end;
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 p1 f1 notify;
RUN;


