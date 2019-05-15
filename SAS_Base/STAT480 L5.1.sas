* Example 5.1. There is nothing really new here. You've already seen an 
if-then(-else) statement in the previous lesson. Our focus there was primarily 
on the assignment statement. Here, we'll focus on the entire if-then statement, 
including the condition. The following SAS program creates a character variable 
status, whose value depends on whether or not the student's first exam grade is 
less than 65:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* if the first exam is less than 65 indicate failed;
	if (e1 < 65) then status = 'Failed';
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 status;
RUN;

* Example 5.2. The following SAS program uses the IN operator to identify those 
students who scored a 98, 99, or 100 on their project score. That is, students 
whose p1 value equals either 98, 99, or 100 are assigned the value 'Excellent' for 
the project variable:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	if p1 in (98, 99, 100) then project = 'Excellent';
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name p1 project;
RUN;

* Example 5.3. The following SAS program creates a character variable status, 
whose value is "Failed" IF the student's first exam grade is less than 65, 
otherwise (i.e., ELSE) the value is "Passed":;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* if the first exam is less than 65 indicate failed;
	if (e1 < 65) then status = 'Failed';
	* otherwise indicate passed;
	else status = 'Passed';
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 status;
RUN;


* Example 5.4. This if-then-else stuff seems easy enough! Let's try creating 
another status variable for our grades data set, but this time let's allow its 
value to depend on the value of the student's fourth exam (e4) rather than the 
value of the student's first exam (e1):;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* if the fourth exam is less than 65 indicate failed;
	if (e4 < 65) then status = 'Failed';
	* otherwise indicate passed;
	else status = 'Passed';
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e4 status;
RUN;


* Example 5.5. Now, let's look at our SAS program again, but this time having 
written the program so that SAS is told to assign status a missing value 
(a blank space ' ' since it is a character variable) if e4 is missing (a period . 
since it is a numeric variable):;

DATA grades;
    length status $ 6;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* if the fourth exam is missing indicate missing;
	* else if the fourth exam is less than 65 indicate failed;
	* otherwise indicate passed;
	     if (e4 = .)  then status = ' ';
	else if (e4 < 65) then status = 'Failed';
	else                   status = 'Passed';
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e4 status;
RUN;
