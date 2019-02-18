/* reference : https://stats.idre.ucla.edu/other/examples/alsm/*/

options nodate nocenter;

data ch1tab01;
  input x y;
  label x = 'Lot Size'
        y = 'Work Hrs';
cards;
   80  399
   30  121
   50  221
   90  376
   70  361
   60  224
  120  546
   80  352
  100  353
   50  157
   40  160
   70  252
   90  389
   20  113
  110  435
  100  420
   30  212
   50  268
   90  377
  110  421
   30  273
   90  468
   40  244
   80  342
   70  323
;
run;

proc sql;
  create table temp as
  select *, x - mean(x) as xdif, y - mean(y) as ydif, (x - mean(x))*( y - mean(y)) as crp,
           (x - mean(x))*(x - mean(x)) as sqdevx, (y - mean(y))*(y - mean(y)) as sqdevy 
  from ch1tab01;
quit;
proc print data = temp;
  var x y xdif ydif crp sqdevx sqdevy;
run;

/*--Comparative Scatter Plot--*/
proc sgscatter data=temp;
   compare x=x y=y;
run;



proc reg data = ch1tab01;
  model y = x;
  plot y*x;
run;
quit;


proc reg data = ch1tab01 noprint;
  model y = x;
  output out=temp p=yhat r=residual;
run;
quit;
data temp1;
  set temp;
  rsq = residual**2;
run;
proc print data = temp1;
  var x y yhat residual rsq;
run;

