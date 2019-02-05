*** Chapter 18: ANOVA Diagnostics and Remedial Measures;
* Inputting the Rust Inhibitor data, table 17.2a, p. 712.;
data Rust;
  input performance brand experiment;
datalines;
  43.9  1   1
  39.0  1   2
  46.7  1   3
  43.8  1   4
  44.2  1   5
  47.7  1   6
  43.6  1   7
  38.9  1   8
  43.6  1   9
  40.0  1  10
  89.8  2   1
  87.1  2   2
  92.7  2   3
  90.6  2   4
  87.7  2   5
  92.4  2   6
  86.1  2   7
  88.1  2   8
  90.8  2   9
  89.1  2  10
  68.4  3   1
  69.3  3   2
  68.5  3   3
  66.4  3   4
  70.0  3   5
  68.1  3   6
  70.6  3   7
  65.2  3   8
  63.8  3   9
  69.2  3  10
  36.2  4   1
  45.2  4   2
  40.7  4   3
  40.5  4   4
  39.3  4   5
  40.3  4   6
  43.2  4   7
  38.7  4   8
  40.9  4   9
  39.7  4  10
;
run;

* Table 18.1, p. 758.;
proc glm data=rust noprint;
  class brand;
  model performance = brand;
  output out=temp r=resid p=predict;
run;
proc freq data=temp;
  weight resid;
  table experiment*brand/ norow nocol nopercent ;
run;

* Univariate analysis of the residual, fig. 18.1, p. 759.;
goptions reset=all;
symbol v=dot c=blue h=.8;
proc gplot data=temp;
  plot resid*predict;
run;
quit;
proc univariate data=temp noprint;
  var resid;
  probplot resid;
run;

* Inputting ABT Electronics data, table 18.2, p. 765.;
data Electronics;
  input strength type joint;
datalines;
  14.87  1  1
  16.81  1  2
  15.83  1  3
  15.47  1  4
  13.60  1  5
  14.76  1  6
  17.40  1  7
  14.62  1  8
  18.43  2  1
  18.76  2  2
  20.12  2  3
  19.11  2  4
  19.81  2  5
  18.43  2  6
  17.16  2  7
  16.40  2  8
  16.95  3  1
  12.28  3  2
  12.00  3  3
  13.18  3  4
  14.99  3  5
  15.76  3  6
  19.35  3  7
  15.52  3  8
   8.59  4  1
  10.90  4  2
   8.60  4  3
  10.13  4  4
  10.28  4  5
   9.98  4  6
   9.41  4  7
  10.04  4  8
  11.55  5  1
  13.36  5  2
  13.64  5  3
  12.16  5  4
  11.62  5  5
  12.39  5  6
  12.05  5  7
  11.95  5  8
;
run;

* Table 18.2, the mean, median and variance of pull strength by flux type, p. 765.;
proc means data=electronics mean median var;
  class type;
  var strength;
run;

*Fig. 18.6, p. 766.;

goptions reset=all;
symbol v=dot c=blue h=.8;
axis1 order=(0 to 30 by 10);
proc gplot data=electronics;
  plot type*strength / haxis=axis1;
run;
quit;

/*The Hartley test for equal variances. 
Note: SAS does not have the an inverse Hartley distribution function, so the critical value has to be 
obtained from another source.*/
ods listing close;
proc means data=electronics var;
  class type;
  var strength;
  ods output summary=temp;
run;
ods listing;
ods output close;
proc sql;
  select max(Strength_Var) as max, min(Strength_Var) as min,  9.70 as critvalue,
         max(Strength_Var)/min(Strength_Var) as H 
  from temp;
quit;

* Modified Levene Test, p. 767.;

proc reg data=electronics noprint;
  model strength = type;
  output out=temp r=r;
run;
proc means data = temp noprint;
  by type;
  var r;
  output out=mout median=mr;
run;
proc print data = mout;
 var type mr;
run;
data mtemp;
  merge temp mout;
  by type;
  d = abs(r - mr);
run; 
proc anova data=mtemp;
  class type;
  model d = type;
run;
quit;

* Table 18.3, p. 768.;

proc freq data= mtemp;
  weight d;
  tables joint*type / nocol norow nopercent;
run;

* Creating the weights and the dummy variables for type to be used in the weighted least squares 
regression. Table 18.4, p. 769-771.;

data temp;
  set electronics;
  x1 = 0;
  if type=1 then x1 = 1;
  x2 = 0;
  if type=2 then x2 = 1;
  x3 = 0;
  if type=3 then x3 = 1;
  x4 = 0;
  if type=4 then x4 = 1;
  x5=0;
  if type=5 then x5 = 1;
  x=1;
run;

proc print data=temp;
run;
proc sql;
  create table temp1 as
  select *, 1/( var( strength) ) as w
  from temp
  group by type;
quit; 
proc print data=temp1 (obs=20);
run;

* Fig. 18.7, p.771.;

proc reg data=temp1;
  weight w;
  model strength = x1-x5 /noint;
  model strength = x / noint;
run;
quit; 

* Inputting the Servo data and obtaining the mean and variance of time by location, table 18.5, p. 774.;

data servo;
input time location interval ;
datalines;
    4.41  1  1  
  100.65  1  2  
   14.45  1  3  
   47.13  1  4 
   85.21  1  5  
    8.24  2  1 
   81.16  2  2  
    7.35  2  3 
   12.29  2  4 
    1.61  2  5 
  106.19  3  1  
   33.83  3  2 
   78.88  3  3 
  342.81  3  4 
   44.33  3  5 
;
run;
proc means data=servo mean var;
  class location;
  var time;
run;
proc means data=servo mean;
  var time;
run;

* Diagnostic statistics for determining the appropriate transformation of time, bottom of p. 773.;
proc sql;
  select var(time)/mean(time) as sqroot, std(time)/mean(time) as log, 
         std(time)/( mean(time)*mean(time) ) as inv
  from servo
  group by location;
quit;


/* Boxcox transformation. There is a macro written by Michael Friendly at York University which will 
produce a table of lambda and the square root of MSE as well as a number of other graphs and tables. 
For more information please refer to http://www.math.yorku.ca/SCS/sasmac/boxcox.html .
%boxcox(data=servo, resp=time, model =location) ;*/

* In SAS 9, we can also use proc transreg to produce Table 18.6. ;
options nocenter;
proc transreg data = servo ss2 details;
model boxcox(time /LAMBDA= -1 to 1 by .1)=identity(location);
run;

* Variance of time by location, bottom of p. 774 and fig. 18.8a and 18.8b, p. 775.;
data log;
  set servo;
  logtime = log(time);
run;
proc means data=log var;
  class location;
  var logtime;
run;
quit;
proc glm data=servo noprint;
  class location;
  model time=location;
  output out=temp r=residual;
run;
quit;
goptions reset=all;
symbol1 v=dot c=blue; 
proc capability data=temp noprint;
  qqplot residual;
run;
proc glm data=log noprint;
  class location;
  model logtime=location;
  output out=temp r=residual;
run;
quit;
symbol1 v=dot c=blue; 
proc capability data=temp noprint;
  qqplot residual;
run;

*** Nonparametric F-test and the Kruskal Wallis test of the Servo data, p. 778-779.;

proc npar1way data=servo wilcoxon  anova ;
  class location;
  var time;
  ods output  KruskalWallisTest=temp anova=temp1;
run;
data _null_;
  set temp;
  if label1='Chi-Square' then call symput('chisq', cvalue1);
run;
data _null_;
  set temp1;
  if source='Among' then call symput('between', df);
  if source='Within' then call symput('within', df);
run;
data new;
  fstat = ( &within*&chisq ) / ( &between*(&within+&between - &chisq) );
  fcrit = finv(.9, &between, &within);
  p_value = 1- cdf('F', fstat, &between, &within );
run;
proc print data=new;
run;
run;
