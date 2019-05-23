* 7.6 - Good Programming Practices;
/*
Write programs that are easy to read.
Test each part of your program before proceeding to the next part.
Test your programs with small data sets.
Test your programs with representative data.
*/

data example1; input a b c; d=a
+ b-c;e=a-c;f=c+b;g=c-b;datalines;
1 2 3
4 5 6
7 8 9
;
run; proc means; var a; run; proc print; run;

* rewrite the code above;
data example1; 
input a b c; 
d=a + b-c; e=a-c; f=c+b; g=c-b;
datalines;
1 2 3
4 5 6
7 8 9
;
run; 
proc means; 
var a; 
run; 

proc print; 
run;

* Example 7.13. The following program may appear to work just fine as 
SAS does indeed produce an answer. If you you look carefully at both 
the input and output, though, you'll see that the answer is not what 
we should expect:;
DATA example2;
   INPUT a b c;
   DATALINES;
112 234 345
115 367 
190 110 111
;
RUN;

PROC PRINT DATA = example2;
RUN;

PROC MEANS;
  var c;
RUN; 

* Example 7.14. While testing your programs, you might find the PUT 
statement to be particularly useful. The following program reads in 
the tree data into the trees data set and calculates the volume of 
each tree as in Example 7.3. Here though a few PUT statements have been 
added to help the programmer verify that the program is doing what she 
expects:;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght_ft)*(0.0000163*circ_in**2);
    if volume = . then do;
	     PUT ' ';
	     PUT 'DATA ERROR!!! ';
		 PUT ' ';
		 PUT ' ';
	end;
	else if volume lt 20 then PUT 'Small tree ' _N_= volume=;
	else if volume ge 20 then PUT 'Large tree ' _N_= volume=;
	DATALINES;
oak, black        222 1O5 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT data = trees;
RUN;

* 7.7 - Summary;
/*
In short, the morals of the story — and the ones that I am therefore allowed to harp on throughout this semester — are:

write programs that are easy to read
write programs that are well commented
and use the PRINT procedure freely, freely, freely to test each part of your program before proceeding
read the log window every time you run a SAS program
read the log window every time you run a SAS program
and did I tell you yet to read the log window every time you run your SAS program?
*/



