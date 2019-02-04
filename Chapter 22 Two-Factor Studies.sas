*** Chapter 22: Two-Factor Studies;

*** Inputting the Growth Hormone data and computing the factor level means, table 22.1, p. 892.;
data growth;
  input growth gender depress rep;
datalines;
  1.4  1  1  1
  2.4  1  1  2
  2.2  1  1  3
  2.1  1  2  1
  1.7  1  2  2
  0.7  1  3  1
  1.1  1  3  2
  2.4  2  1  1
  2.5  2  2  1
  1.8  2  2  2
  2.0  2  2  3
  0.5  2  3  1
  0.9  2  3  2
  1.3  2  3  3
;
run;
proc means data=growth mean;
  class gender depress ;
  var growth;
run;

*** Fig. 22.1, p. 892. 
Note: We create two variables for depression means, one for each level of gender. The overlay option in proc 
gplot lets us plot the two lines in the same graph.;
proc means data=growth mean noprint;
  class gender depress;
  var growth;
  output out=temp mean=mout;
run; 

data temp;
  set temp;
  if gender=1 then male=mout;
  if gender=2 then female=mout;
run;

goptions reset=all;
 
symbol1 c=blue v=dot h=.8 i=join;
symbol2 c=red v=dot h=.8 i=join;
axis1 order=(.5 to 2.5 by .5) label=(angle=90 'Change in Growth Rate');
legend1 label=none value=(height=1 font=swiss 'Male Children' 'Female Children' ) 
        position=(left bottom inside) mode=share cborder=black;
proc gplot data=temp;
  plot (male female)*depress/ overlay legend=legend1 vaxis=axis;
run;
quit;

*** Creating the dummy variables to be used in the regression model that will be equivalent to the ANOVA model (22.3), p. 893.;
data dummy;
  set growth;
  if gender=1 then x1=1;
  else x1=-1;
  if depress=1 then x2=1;
  else if depress=3 then x2=-1;
  else x2=0;
  if depress=2 then x3=1;
  else if depress=3 then x3=-1;
  else x3=0;
  x1x2 = x1*x2;
  x1x3 = x1*x3;
run;

*** Table 22.2, p. 894.;
proc print data=dummy;
  var gender depress rep growth x1 x2 x3 x1x2 x1x3;
run;

*** Table 22.3, p. 895.;
proc reg data=dummy;
  model growth = x1 x2 x3 x1x2 x1x3;
  model growth = x1 x2 x3;
  model growth = x2 x3 x1x2 x1x3;
  model growth = x1 x1x2 x1x3; 
run;
quit;

*** Testing the interactions, factor A main effects and factor B main effects, p. 894-896.;
proc reg data=dummy;
  model growth = x1 x2 x3 x1x2 x1x3;
  interactions: test x1x2, x1x3;
  maina: test x1;
  mainb: test x2, x3;
run;
quit;

*** Table 22.4, p. 897.;
proc glm data=growth;
  class gender depress;
  model growth = gender depress gender*depress/ss3;
run;
quit;

*** Pair-wise comparisons of depress factor level means, p. 901.
Note: Since the model is the same as above all the redundant output has been omitted.;
proc glm data=growth;
  class depress gender;
  model growth = depress gender depress*gender;
  lsmeans depress/ pdiff adjust=tukey cl alpha=.1;
run;
quit;

*** Single degree of Freedom test using the growth hormone example, p. 902. 
 
Note: The single degree t-tests are obtained by using the lsmeans statement with the tdiff option. 
Moreover, since the model is the same as in the two previous proc glm the redundant output has been omitted.;
proc glm data=growth;
  class  depress gender;
  model growth = depress gender depress*gender;
  lsmeans depress/ tdiff stderr;
run;
quit;


/* NOTE: To ensure overall protection level, only probabilities associated with pre-planned
      comparisons should be used.

We cannot reproduce the math score example since the data was not available, p. 906.

Tests of the null hypothesis in (22.24a) first using proc glm and then using two regression models, p. 907-908.

Note: In the code for proc glm the order of the categorical
variables in the class statement is very important and it has to match the order to the
interaction.  If the interaction is gender*depress then the class statement has
to be class gender depress. It is rather tricky figuring out the order of the coefficients
that should be entered into the contrast statement.  When the interaction is gender*depress
the coefficients in the contrast statement are those of the cell means in the following order:
mu11 mu12 mu13 mu21 mu22 mu23 where the first index is for the gender factor and the second index
is for the depress factor.  In the second version of the code where the order of the interaction
was switched the coefficients in the contrast statement are those of the cell means in the following
order:  mu11 mu21 mu12 mu22 mu13 mu23 (where the first index is for the gender factor and the second index
is for the depress factor).*/

proc glm data=growth;
  class gender depress;
  model growth =  gender*depress;
  contrast 'contrast'
    gender*depress .666 -.666 0 .333 -.333 0,
    gender*depress .666 0 -.666 .333 0 -.333;       
run;
quit;
proc glm data=growth;
  class  depress gender ;
  model growth =  depress*gender;
  contrast 'contrast'
    depress*gender .666 .333 -.666 -.333 0 0,
    depress*gender .666  .333 0 0  -.666 -.333;       
run;
quit;

*** Creating the dummy variables to get the regression model that will supply us with the value of 
SSE(F), p. 908.;
data dummyx;
  set growth;
  x1 = 0;
  if gender=1 and depress=1 then x1=1;
  x2 = 0;
  if gender=1 and depress=2 then x2=1;
  x3 = 0;
  if gender=1 and depress=3 then x3=1;
  x4 = 0;
  if gender=2 and depress=1 then x4=1;
  x5 = 0;
  if gender=2 and depress=2 then x5=1;
  x6 = 0;
  if gender=2 and depress=3 then x6=1;
run;

proc print data=dummyx;
run;

*** Running the regression model and using ODS to create two macro variables, one for SSE(F) and
one for DF_F. In order to check that we have the correct macro variable we use a put statement
to look at the macro variables in the log file.;
ods listing close;
ods output anova=full;
proc reg data = dummyx;
  model growth = x1-x6 / noint;
run;
quit;
ods listing;
data _null_;
  set full;
  if source='Error' then call symput('fullss', ss);
  if source='Error' then call symput('fulldf', df);
run;
%put here are the values &fullss and &fulldf; /* check values in the log file */ 


/* Creating the dummy variables for the reduced regression model, p. 909 and running the second 
regression model and using ODS to create two macro variables, one for SSE(R) and one for DF_R. In order to 
check that we have the correct macro variable we use a put statement
to look at the macro variables in the log file.*/

data dummyz;
  set dummyx;
  z1 = x1 - 2*x4;
  z2 = x2 +2*x4 +2*x6;
  z3 = x3 -2*x6;
  z4 = x4 +x5+x6;
run;
ods listing close;
ods output anova=reduced;
proc reg data=dummyz;
  model growth = z1-z4/ noint;
run;
quit;
ods listing;
data _null_;
  set reduced;
  if source='Error' then call symput('reducedss', ss);
  if source='Error' then call symput('reduceddf', df);
run;
%put here are the values &reducedss and &reduceddf; /* check values in log file */

*** Finally, we use all the values that were extracted from the two regression models in an F-test, p. 909.;
data temp;
  SSE_R= &reducedss;
  SSE_F= &fullss;
  DF_R = &reduceddf;
  DF_F = &fulldf;
  Fstar = ( (&reducess - &fullss)/( &reduceddf - &fulldf) ) /( &fullss/ &fulldf);
  p_value = 1 - cdf( 'F', fstar, &reduceddf - &fulldf, &fulldf);
run;
proc print data=temp;
run;

/* Repeating the same test using SSA, p. 914. 
 
Note: First we use proc glm to obtain SSA and the DF_A and store them as macro variables.  
Then we will use the data set dummy and re-run the full regression model including interactions in 
order to obtain the SSE(F) and df_F as presented in table 22.3a, p. 895 and store them as macro variables.  Finally, 
we use all the values that we extracted in an F-test.*/

ods listing close;
ods output  ModelANOVA=ssa;
proc glm data=growth;
  class gender depress;
  model growth = gender depress/ ss1;
run;
quit;
ods listing;
data _null_;
  set ssa;
  if source='gender' then call symput('ssa', ss);
  if source='gender' then call symput('dfa', df);
run;
%put here are the values &ssa and &dfa; /*check the values in the log file */
ods listing close;
ods output anova=anova;
proc reg data=dummy;
 model growth = x1 x2 x3 x1x2 x1x3;
run;
quit;
ods listing;
data _null_;
  set anova;
  if source='Error' then call symput('fullss', ss);
  if source='Error' then call symput('fulldf', df);
run;
%put here are the values &fullss and &fulldf; /* check the values in the log file */
data temp;
  SSA = &ssa;
  DF_A = &dfa;
  SSE_F = &fullss;
  DF_F = &fulldf;
  Fstar = (&ssa/&dfa)/( &fullss/ &fulldf);
  p_value = 1 - cdf( 'F', Fstar, &dfa, &fulldf);
run;
proc print data=temp;
run;
