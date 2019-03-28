* Generating Orthogonal Polynomials in SAS;
/* Generating Ortho_Polynomials from IML */
proc iml;
x={10 20 30 40 50}; 
xpoly=orpol(x,4); /* the '4' is the df for the quantitative factor */
density=x`; new=density || xpoly;
create out1 from new[colname={"density" "xp0" "xp1" "xp2" "xp3" "xp4"}];
append from new; close out1; 
quit;
proc print data=out1; run;

data grain;
input density yield;
datalines;
10      12.2	
10      11.4	
10      12.4	
20      16	
20      15.5	
20      16.5	
30      18.6	
30      20.2	
30      18.2	
40      17.6	
40      19.3	
40      17.1	
50      18	
50      16.4	
50      16.6
;
run;	
/* Here data is sorted and then merged with the original dataset */
proc sort data=grain; by density; run;
data ortho_poly; merge out1 grain; by density; run;
proc print data=ortho_poly; run;


/* The following code will then generate the results shown in the 
	Online Lesson Notes for the Kuehl example data */
proc mixed data=ortho_poly method=type3;
class;
model yield=xp1 xp2 xp3 xp4; 
title 'Using Orthog polynomials from IML';
run;

/* Analysis of variance for the orthogonal polynomial model relationship 
between plant density and grain yield.*/

/* This method just requires centering the quantitative variable levels by 
subtracting the mean of the levels (30), and then creating the quadratic polynomial terms */

data grain; 
set grain;
x=density-30; 
x2=x**2; 
run;

proc mixed data=grain method=type1;
class;
model yield = x x2;
run;


proc mixed data=grain method=type1;
class;
model yield = x x2  /  solution;
run;



/* to get the regression equation in original units, not
centered x values, use the following From p. 299 Kutner, et al.) */

data backtransform;
bprime0=18.4-(.12*30)+(-.01*(30**2));
bprime1=.12-(2*-.01*30);
bprime2=-.01;
title 'bprime0=b0-(b1*meanX)+(b2*(meanX)2)';
title2 'bprime1=b1-2*b2*meanX';
title3 'bprime2=b2';
run;

proc print data=backtransform; var bprime0 bprime1 bprime2; run;
