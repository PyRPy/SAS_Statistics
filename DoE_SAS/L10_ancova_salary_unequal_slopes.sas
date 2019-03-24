data unequal_slopes;
input gender $ salary years;
datalines;
m 42 1
m 112 4
m 92 3
m 62 2
m 142 5
f 80 5
f 50 3
f 30 2
f 20 1
f 60 4
;
/* orig */
* -------- Step 1: Are all regression slopes = 0 ? --------;
proc mixed data=unequal_slopes;
class gender;
model salary=gender years gender*years;
title 'Covariance Test for Equal Slopes';    
  /* Note that we found a significant years*gender interaction */ 
  /* so we add the lsmeans for comparisons */ 
  /* With 2 treatments levels we omitted the Tukey adjustment */
lsmeans gender/pdiff at years=1;
lsmeans gender/pdiff at years=3;
lsmeans gender/pdiff at years=5;
run;

* Generating Covariate Regression Slopes and Intercepts;
proc mixed data=unequal_slopes;
class gender;
model salary=gender gender*years / noint solution;
ods select SolutionF;
title 'Reparameterized Model';    
run;

* Here the intercepts are the Estimates for effects labeled 'gender' and ;
* the slopes are the Estimates for the effect labeled 'years*gender'.;

