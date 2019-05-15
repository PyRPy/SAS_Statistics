* Example 4.6. In the previous example, we calculated students' average exam scores by 
adding up their four exam grades and dividing by 4. Alternatively, we could use the 
MEAN function. The following SAS program illustrates the calculation of the average 
exam scores in two ways — by definition and by using the MEAN function:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* calculate the average by definition;
	avg1 = (e1+e2+e3+e4)/4;   
	* calculate the average using the mean function;
	avg2 = mean(e1,e2,e3,e4); 
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 avg1 avg2;
RUN;

* Example 4.7. The following SAS program uses the INT function to extract the area codes 
from a set of ten-digit telephone numbers:;

DATA grades;
	input name $ 1-15 phone e1 e2 e3 e4 p1 f1;
	areacode = int(phone/10000000);
	DATALINES;
Alexander Smith 8145551212  78 82 86 69  97 80
John Simon      8145562314  88 72 86  . 100 85
Patricia Jones  7175559999  98 92 92 99  99 93
Jack Benedict   5705551111  54 63 71 49  82 69
Rene Porter     8145542323 100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name phone areacode;
RUN;

* Example 4.8. One really cool thing is that you can nest functions in SAS (as you can in 
most programming languages). That is, you can compute a function within another function. 
When you nest functions, SAS works from the inside out. That is, SAS performs the action 
in the innermost function first. It uses the result of that function as the argument of 
the next function, and so on. You can nest any function as long as the function that is 
used as the argument meets the requirements for the argument. The following SAS program 
illustrates nested functions when it rounds the students' exam average to the 
nearest unit:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	*calculate the average using the mean function
	 and then round it to the nearest digit;
	avg = round(mean(e1,e2,e3,e4),1);
	DATALINES;
Alexander Smith   78 82 86 69  97 80
John Simon        88 72 86  . 100 85
Patricia Jones    98 92 92 99  99 93
Jack Benedict     54 63 71 49  82 69
Rene Porter      100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 avg;
RUN;

* Example 4.9. When creating a new character variable in a data set, most often you will 
want to assign the values based on certain conditions. For example, suppose an instructor 
wants to create a character variable called status which indicates whether a student 
"passed" or "failed" based on their overall final grade. A grade below 65, say, might be 
considered a failing grade, while a grade of 65 or higher might be considered a passing 
grade. In this case, we would need to make use of an if-then-else statement. We'll learn 
more about this kind of statement in the next lesson, but you'll get the basic idea here. 
The following SAS program illustrates the creation of a new character variable called 
status using an assignment statement in conjunction with an if-then-else statement: 
SAS Program;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* calculate the average using the mean function;
	avg = mean(e1,e2,e3,e4); 
	* if the average is less than 65 indicate failed,
	  otherwise indicate passed;
	if (avg < 65) then status = 'Failed';
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
	var name e1 e2 e3 e4 avg status;
RUN;
