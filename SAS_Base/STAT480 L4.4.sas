
*Example 4.4. The following example contains a calculation that illustrates the 
standard order of operations. Suppose a statistics instructor calculates the final 
grade by weighting the average exam score by 0.6, the project score by 0.2, and the 
final exam by 0.2. The following SAS program illustrates how the 
instructor (incorrectly) calculates the students' final grades:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	final = 0.6*e1+e2+e3+e4/4 + 0.2*p1 + 0.2*f1;
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 p1 f1 final;
RUN;

* Example 4.5. The following example contains a calculation that illustrates the standard
order of operations. Suppose a statistics instructor calculates the final grade by 
weighting the average exam score by 0.6, the project score by 0.2, and the final 
exam by 0.2. The following SAS program illustrates how the instructor (correctly) 
calculates the students' final grades:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	final = 0.6*((e1+e2+e3+e4)/4) + 0.2*p1 + 0.2*f1;
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 p1 f1 final;
RUN;
