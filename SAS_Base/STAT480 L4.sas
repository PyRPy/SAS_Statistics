* Example 4.1. Throughout this lesson, we'll work on modifying various aspects of the 
temporary data set grades that is created in the following DATA step:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 p1 f1;
RUN;

*Example 4.2. The following SAS program illustrates a very simple assignment statement 
in which SAS adds up the four exam scores of each student and stores the result in a new 
numeric variable called examtotal.;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	* add up each students four exam scores
	  and store it in examtotal;
	examtotal = e1 + e2 + e3 + e4;
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 examtotal;
RUN;

* Example 4.3. In the previous example, the assignment statement created a new variable in 
the data set by simply using a variable name that didn't already exist in the 
data set. You need not always use a new variable name. Instead, you could modify the 
values of a variable that already exists. The following SAS program illustrates 
how the instructor would modify the variable e2, say for example, if she wanted to 
modify the grades of the second exam by adding 8 points to each student's grade:;

DATA grades;
	input name $ 1-15 e1 e2 e3 e4 p1 f1;
	e2 = e2 + 8;  * add 8 to each student's 
	                second exam score (e2);
	DATALINES;
Alexander Smith  78 82 86 69  97 80
John Simon       88 72 86  . 100 85
Patricia Jones   98 92 92 99  99 93
Jack Benedict    54 63 71 49  82 69
Rene Porter     100 62 88 74  98 92
;
RUN;

PROC PRINT data = grades;
	var name e1 e2 e3 e4 p1 f1;
RUN;

