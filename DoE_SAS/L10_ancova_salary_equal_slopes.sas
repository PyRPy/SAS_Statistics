data equal_slopes;
input gender $ salary years;
datalines;
m 78 3
m 43 1
m 103 5
m 48 2
m 80 4
f 80 5
f 50 3
f 30 2
f 20 1
f 60 4
;
* -------- Step 1: Are all regression slopes = 0 ? --------;
* for males:;
proc reg data=equal_slopes;
where gender='m';
model salary=years;
title 'Males';
run; quit;

* for females;
proc reg data=equal_slopes;
where gender='f';
model salary=years;
title 'Females';
run; quit;

* -------- Step 2: Are the slopes equal? --------;
* Note: In SAS, we specify the treatment in the class statement, indicating ;
* that these are categorical levels. By NOT including the covariate in the class ;
* statement, it will be treated as a continuous variable for regression in the model statement.;

proc mixed data=equal_slopes;
class gender;
model salary = gender years gender*years;
run;

* We will also include a ‘treatment × covariate’ interaction term and the significance ;
* of this term answers our question. If the slopes differ significantly among treatment ;
* levels, the interaction p-value will be < 0.05.;

* --- Step 3: Fit an Equal Slopes Model --- ;
* remove interaction term;
proc mixed data=equal_slopes;
class gender;
model salary = gender years;
lsmeans gender / pdiff adjust=tukey;
      /* Tukey unnecessary with only two treatment levels */
title 'Equal Slopes Model';
run;
* To get the slopes and intercepts for the covariate directly, we have to ;
* re-parameterize the model. This entails suppressing the intercept (noint), ;
* and then specifying that we want the solutions, (solution), to the model:;

proc mixed data=equal_slopes;
class gender;
model salary = gender years / noint solution;
ods select SolutionF;
title 'Equal Slopes Model';
run;


