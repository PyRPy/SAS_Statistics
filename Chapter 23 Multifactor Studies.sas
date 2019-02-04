* Chapter 23: Multifactor Studies ;
data stress;
  input exercise gender fat smoking rep;
  label gender='1=male, 2=female'
        fat='1=low fat, 2=high fat'
	smoking='1=Light, 2=heavy';
datalines;
  24.1  1  1  1  1
  29.2  1  1  1  2
  24.6  1  1  1  3
  20.0  2  1  1  1
  21.9  2  1  1  2
  17.6  2  1  1  3
  14.6  1  2  1  1
  15.3  1  2  1  2
  12.3  1  2  1  3
  16.1  2  2  1  1
   9.3  2  2  1  2
  10.8  2  2  1  3
  17.6  1  1  2  1
  18.8  1  1  2  2
  23.2  1  1  2  3
  14.8  2  1  2  1
  10.3  2  1  2  2
  11.3  2  1  2  3
  14.9  1  2  2  1
  20.4  1  2  2  2
  12.8  1  2  2  3
  10.1  2  2  2  1
  14.4  2  2  2  2
   6.1  2  2  2  3
;
run;

proc print data=stress;
run;

*** Table 23.4b, p. 943. The cell means and the factor means. 
Note: It would be possible to obtain all the means by using multiple proc means but the lsmeans statement in proc glm is actually more flexible and allows 
you to obtain all the means in a single statement. The bars is a special notation which indicates that all the interactions should be included even the three-way interaction.;


ods output  GLM.LSMEANS.gender_fat_smoking.LSMeans=temp;
ods listing close;
proc glm data= stress;
  class gender fat smoking;
  model exercise = gender|fat|smoking ;
  lsmeans gender|fat|smoking;
run;
quit;

proc print data=temp;
run;

ods listing;
data temp1;
  set temp;
  if gender=1 then
    if smoking=2  then heavy_m= exerciseLSMean;
	else if smoking=1  then light_m=exerciseLSMean;
  if gender=2 then
    if smoking=2  then heavy_f= exerciseLSMean;
	else if smoking=1 then light_f=exerciseLSMean; 
  if smoking=1 then
    if fat=2 then light_high = exerciseLSMean;
	else if fat=1 then light_low = exerciseLSMean;
  if smoking=2 then
    if fat=1 then heavy_high = exerciseLSMean;
	else if fat=2 then heavy_low = exerciseLSMean;
run;
*** cannot plot somehow;
goptions reset=all;
symbol1 v=dot c=blue h=.8 i=join;
symbol2 v=dot c=red h=.8 i=join;
axis1 order=(0 to 40 by 10) label=(angle=90 'Minutes of Exercise');
legend1 label=none value=(height=1 font=swiss 'Heavy Smoking' 'Light Smoking' ) 
  position=(bottom right inside) mode=share cborder=black;
legend2 label=none value=(height=1 font=swiss 'Low Fat' 'High Fat' ) 
  position=(bottom right inside) mode=share cborder=black;
proc gplot data = temp1;
  plot (heavy_m light_m)*fat/ overlay vaxis=axis1 legend=legend1 ;
run;
* filename outfile 'c:sas2htmhttps://stats.idre.ucla.edu/wp-content/uploads/2016/02/alsm23_2.gif';
goptions gsfmode=replace gsfname=outfile device=gif373; 
  plot (heavy_f light_f)*fat /overlay vaxis=axis1 legend=legend1 ;
run;
  plot (light_low light_high)*gender/ overlay vaxis=axis1 legend=legend2 ;
run;
  plot (heavy_high heavy_low)*gender / overlay vaxis=axis1 legend=legend2 ;
run;
quit;
goptions reset=all;

proc glm data=stress;
  class gender fat smoking;
  model exercise = gender|fat|smoking;
  output out=temp r=residual;
run;
quit;
symbol v=dot c=blue h=.8;
proc capability data=temp noprint;
  qqplot residual;
run;

*** Estimation of Contrasts of Treatment means, p. 947. 
First we obtain the relevant datasets from the output of the proc glm using ods. Then we create a macro variable for the degrees 
of freedom that we need in order to obtain the Bonferroni multiple for a 95% family confidence coefficient. Finally, we get the confidence 
intervals for each of the three contrasts, p. 948.;

ods output Estimates=temp;
ods output OverallANOVA=anova;
proc glm data=stress;
  class gender fat smoking;
  model exercise = gender|fat|smoking;
  estimate 'L1' smoking 1 -1 fat*smoking 1 -1 0 0;
  estimate 'L2' smoking 1 -1 fat*smoking 0 0 1 -1;
  estimate 'L3' gender 1 -1;
run;
quit;

data _null_;
  set anova;
  if source='Error' then call symput('Df', DF);
run;
%put here is the df we should use &df;
data temp;
 set temp;
 drop dependent tvalue probt;
  B = tinv( 1- (.05/6), &df);
  lower = estimate - B*stderr;
  upper = estimate + B*stderr;
run;
proc print data=temp;
run;

*** The effects of Body Fat and Smoking History, fig. 23.9b, p. 949.;
ods output  GLM.LSMEANS.fat_smoking.LSMeans=temp;
ods listing close;
proc glm data= stress;
  class  fat smoking;
  model exercise = fat smoking fat*smoking ;
  lsmeans fat smoking fat*smoking;
run;
quit;

ods listing;
data temp1;
  set temp;
  if fat=1 then low = exerciseLSMean;
	else if fat=2 then high = exerciseLSMean;
run;

goptions reset=all;
symbol1 v=dot c=blue h=.8 i=join;
symbol2 v=dot c=red h=.8 i=join;
axis1 order=(0 to 40 by 10) label=(angle=90 'Minutes of Exercise');
legend1 label=none value=(height=1 font=swiss 'Low Fat' 'High Fat' ) 
  position=(bottom right inside) mode=share cborder=black;
*** need to be fixed;
proc sgplot data = temp1;
  plot (high low)*smoking/ overlay vaxis=axis1 legend=legend1 ;
run;
quit;
goptions reset=all;

*** Creating the Stress data with missing values and generating the indicator variables, table 23.5, p. 950.;
data missing;
  set stress;
  if gender=1 and fat=1 and smoking=1 and rep=3 then delete;
  if gender=2 and fat=2 and smoking=1 and rep=2 then delete;
  y = exercise;
  x1 = 1;
  if gender=2 then x1 = -1;
  x2 = 1;
  if fat=2 then x2 = -1;
  x3 = 1;
  if smoking=2 then x3 = -1;
  x12 = x1*x2;
  x13 = x1*x3;
  x23 = x2*x3;
  x123 = x1*x2*x3;
run;
proc print data=missing;
run;

*** Testing factor A (Gender) by dropping x1 from the full model and regressing y on the variables in column 3-8, p. 950.;
proc reg data=missing;
  model y = x1-x3 x12 x13 x23 x123;
  model y = x2 x3 x12 x13 x23 x123;
run;
quit;
