/* Chapter 01 Practice Problem */
/* Ex1.1 */
proc iml;
x1 = {3 4 2 6 8 2 5}`;
x2 = {5 5.5 4 7 10 5 7.5}`;
x1bar = mean(x1);
x2bar = mean(x2);
print x1bar, x2bar;
run;

mat = x1||x2;
covx = cov(mat); /* in SAS it uses (n-1) not n */
print covx;
quit;
/* Ex1.2 */

data used_car;
	input x1 x2;
datalines;
1 18.95
2 19.00
3 17.95
3 15.54
4 14.00
5 12.95
6 8.94
8 7.49
9 6.00
11 3.99  
;
proc print data = used_car;
run;

* scatter plot ;
proc gplot data = used_car;
	plot x2*x1;
run;

* cov sign ;
proc corr  cov data = used_car;
	var x1 x2;
run;
/* cov negative sign, also see from the scatter plot */

* find means S11, s22 s12 and r12 ;
proc corr  cov data = used_car;
	var x1 x2;
run;

* (d) use the format as vectors and matrix ;

/* Ex1.3 */
data measurements;
	input x1 x2 x3;
datalines;
9  12  3
2   8  4
6   6  0
5   4  2 
8  10  1
;
proc print data = measurements;
run;

proc corr cov data = measurements;
run;

/* Ex1.6 */
data air;
	infile "Documents\My SAS Files\STAT505_SAS\PracticeProblems\Data\air.dat";
	input wind sol_rad CO NO NO2 O3 HC;
run;
proc print data = air;
run;
proc corr cov data = air;
run;

/* Ex1.9 */
data measure2;
	input x1 x2;
datalines;
-6  -2
-3  -3 
-2   1
 1  -1
 2   2
 5   1
 6   5
 8   3
;
proc print data = measure2;
run;

* a ;
proc gplot data = measure2;
	plot x2*x1;
run;
proc corr cov data = measure2;
run;


* b ;
data measure2;
	input x1 x2;
	x1new = 0.899*x1 + 0.438*x2;
	x2new = -0.438*x1 + 0.899*x2;
datalines;
-6  -2
-3  -3 
-2   1
 1  -1
 2   2
 5   1
 6   5
 8   3
;
proc print data = measure2;
run;

* c ;
proc corr cov data = measure2;
	var x1new x2new;
run;
* d ;
