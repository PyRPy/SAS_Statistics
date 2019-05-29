* I. Computing Chi-Square From Frequency Counts;
* Page 92. I find I use the WEIGHT statement often. Whenever you don't 
have the original raw data available, but instead have the data already 
summarized in tables (as you might see on the evening news!), you have 
to use a WEIGHT statement to tell SAS to calculate the chi-square statistic 
for you. Here's the code I used to create the corrected table above in 
Section G:;

DATA elect;
   input Gender $ Candid $ Count;
   DATALINES;
   F Dewey  70
   M Dewey  40
   F Truman 30
   M Truman 40
   ;
RUN;

PROC FREQ data = elect;
   table Candid*Gender / chisq;
   weight count;
RUN;

* N. Odds Ratios
Page 101. The authors calculate the odds ratio to be 3.25. We interpret 
such an odds ratio in this way... we say that the odds of a case being 
exposed to benzene is 3.25 times the odds of a control being exposed to 
benzene.

Page 102. If the authors didn't use the trick of using 1-Yes in place of Yes, 
and 2-No in place of No, this is what their program would look like:;

DATA odds;
   INPUT Outcome $ Exposure $ Count;
   DATALINES;
   Case    Yes  50
   Case    No  100
   Control Yes  20
   Control No  130
   ;
RUN;

PROC FREQ data = odds;
   TABLE Exposure*Outcome / chisq cmh;
   WEIGHT Count;
RUN;
* check with lecture notes 25;
