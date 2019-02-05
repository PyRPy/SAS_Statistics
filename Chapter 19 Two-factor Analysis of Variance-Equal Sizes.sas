*** Chapter 19: Two-factor Analysis of Variance-Equal Sample Sizes;
* Inputting the Castle Bakery data, table 19.7, p. 818.;

data bakery;
  input sales height width store;
datalines;
  47  1  1  1
  43  1  1  2
  46  1  2  1
  40  1  2  2
  62  2  1  1
  68  2  1  2
  67  2  2  1
  71  2  2  2
  41  3  1  1
  39  3  1  2
  42  3  2  1
  46  3  2  2
;
run;

/*Means for levels of height, width and height by width, table 19.7, p. 818.
Note: Using proc glm to generate the means by using the lsmeans statement is one of the most convenient ways of 
obtaining these means.  The alternative would be to use three proc means one for each of the categorical variables 
and their interaction.  Unfortunately, proc glm does provide a great deal of output and we have therefore deleted 
irrelevant (to this computation) results for the sake of clarity.*/

proc glm data=bakery;
  class height width;
  model sales = height width height*width;
  lsmeans height width height*width;
run;
quit;

/* Fig. 19.6, p. 820.
In order to get the lines on the same graph we need to create two variables for height that corresponds to 
each of the levels of width.  The overlay option in the plot statement lets us plot both lines in the same graph.*/

ods listing close;
proc means data= bakery mean ;
  class height width;
  var sales;
  ods output summary=sum;
run;
ods listing;
ods output close;
data sum;
  set sum;
  if width = 1 then regular=height;
  if width = 2 then wide =height;
run;
goptions reset = all;
 
symbol1 c=blue v=.8 i=join;
symbol2 c=red v=.8 i=join;
axis1 label=( 'Height');
axis2 label=(angle=90 'Sales');
legend1 label=none value=(height=1 font=swiss 'Regular' 'Wide' ) 
        position=( middle bottom inside) mode=share cborder=black;
proc gplot data=sum;
  plot sales_Mean*regular=1 sales_Mean*wide=2 /overlay haxis=axis1 vaxis=axis2 legend=legend1;
run;
quit;

*** Table 19.9 and Fig. 19.7, p. 820-824.
Note: Unlike in the prior results from table 19.7 here we have kept all the results from the proc glm because we 
now would like to examine the anova table results.  We also utilized the output statement in order to obtain the 
residual and predicted values in a separate dataset.  We will use these in the graphs in fig. 19.8.;

proc glm data=bakery;
  class height width;
  model sales = height width height*width;
  means height width height*width;
  output out=temp r=resid p=predict;
run;
quit;

* Fig. 19.8, p. 828.;
goptions reset=all;

symbol1 v=x c=blue h=.8;
proc gplot data=temp;
  plot resid*predict;
run;
quit;

symbol1 v=x c=blue h=.8;
proc capability data=temp noprint;
  qqplot resid;
run;

* F tests of the interaction and main effects, p. 830-831.;

proc glm data=bakery;
  class height width;
  model sales = height width height*width;
  run;
quit;


* Creating the dummy and interaction variables for the Regression model of the Bakery data, p. 833.;

data dummy;
  set bakery;
  x1=0;
  if height=1 then x1=1;
  if height=3 then x1 = -1;
  x2=0;
  if height=2 then x2=1;
  if height=3 then x2 = -1;
  x3=0;
  if width=1 then x3=1;
  if width=2 then x3 = -1;
  x13 = x1*x3;
  x23 = x2*x3;
run;

* Table 19.10, p. 836.;
* Note: It is the SS1 option in the model statement that supplies the type 1 sums of squares for each predictor.;

proc print data=dummy;
run;
proc reg data=dummy;
  model sales = x1 x2 x3 x13 x23 / ss1;
run;

* Pooling sums of squares in the Bakery Sales example, p. 837.;
* Note: The change in the SSE has been italicized for clarity.;

proc glm data=dummy;
  class height width;
  model sales = height width;
run;
quit;

quit;
