data greenhouse;
input fert $ Height;
datalines;
Control      21
Control      19.5
Control      22.5
Control      21.5
Control      20.5
Control      21
F1      32
F1      30.5
F1      25
F1      27.5
F1      28
F1      28.6
F2      22.5
F2      26
F2      28
F2      27
F2      26.5
F2      25.2
F3      28
F3      27.5
F3      31
F3      29.5
F3      30
F3      29.2
;
run;

/* Comments, ignored by SAS, can be written anywhere, but have to be
      enclosed by /* and end with */

/* We already printed out the data, and ran the summary procedure, so I
      don't want to keep running again and generating needless output.
      So I will comment out the print procedures in our old work. 
	  I can re-activate these at any time just by removing the comment enclosures */

/* proc print data=greenhouse;
title 'Raw Data for Greenhouse Data'; run;   */

/* proc summary data=greenhouse;
class fert;
var height;
output out=output1 mean=mean stderr=se;
run;
proc print data=output1;
title 'Summary Output for Greenhouse Data'; run;
title; run; */
																																												

/* Check Settings: From Main toolbar, choose
Tools > Options > Preferences > Results
make sure HTML box is checked and listing box is not checked */

/* I want to enable the Output Delivery System Graphics package
because I will want to produce some diagnostic plots */

ods graphics on;

/* ANOVA: We will be using Proc Mixed for most of our ANOVA work. The mixed 
procedure has several options for how the solutions
for ANOVA are reached.  I am specifying the 'Method=type3'
to use ordinary least squares rather than a maximum likelihood method
for this example. This will produce the conventional (ANOVA table) output. */

proc mixed data=greenhouse method=type3 plots=all;
class fert;
model height=fert;
store abc123; /*Stores results for the next procedure (abc123 is name I give)*/
title 'ANOVA of Greenhouse Data';
run;

ods html style=statistical sge=on;
proc plm restore=abc123; 
lsmeans fert / adjust=tukey plot=meanplot cl lines; 
/* The lsmeans statement here prints out the model fit means, performs the Tukey
      mean comparisons, and plots the data. */
ods exclude diffplot; 
run; title; run;
