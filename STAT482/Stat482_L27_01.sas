* Lesson 27: Correlation and Simple Regression;
* C. Significance of a Correlation Coefficient;
* Page 163. The point the authors make in the first 
paragraph is a very important one. If you have a large 
data set, it is quite possible that you'll have a small 
enough P-value to conclude that the population 
correlation is significantly different from 0, 
when in fact it is not all that much different from 0. 
You'll want to make sure you use common sense when 
interpreting the results.

The point the authors make in the second paragraph is 
equally important. Always remember the mantra: 
correlation does not imply causation.;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA correlation;
    input x y;
	DATALINES;
	300 260
	400 310
	460 440
	450 490
	480 480
	540 510
	545 575
	550 460
	580 570
	620 570
	;
RUN;

PROC CORR data = correlation;
   title 'Is the population correlation strong?';
   var x y;
RUN;

* H. Producing a Scatter Plot and the Regression Line
Page 170. The authors use the graphic version of the 
scatter plot procedure. You can create a character-based 
plot as well using the PLOT procedure. In that case, 
the code would be the same except PLOT would replace GPLOT:;

DATA CORR_EG;
   INPUT GENDER $ HEIGHT WEIGHT AGE;
DATALINES;
M 68 155 23
F 61 99 20
F 63 115 21
M 70 205 45
M 69 170 .
F 65 125 30
M 72 220 48
;
RUN;

SYMBOL VALUE = DOT COLOR = BLACK;

PROC GPLOT DATA=CORR_EG;
   title 'Plot of Weight vs. Height';
   PLOT WEIGHT*HEIGHT;
RUN;
QUIT;

