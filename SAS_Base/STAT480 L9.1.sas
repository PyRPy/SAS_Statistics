* Example 9.1. Because there are 638 observations and 16 variables in 
the permanent background data set icdb.back, the data on just ten 
subjects and nine variables are selected when creating the temporary 
working background data set back. The following SAS program creates 
the subset:;

OPTIONS PS = 58 LS = 80 NODATE NONUMBER;
LIBNAME icdb '/folders/myfolders/sasuser.v94/STAT480/Data';

DATA back;
   set icdb.back;    
   age = (v_date - b_date)/365.25;
   if subj in (110051, 110088, 210012, 220004, 230006, 
               310083, 410012, 420037, 510027, 520017);
   keep subj v_date b_date age sex state country race relig;
   format age 4.1;
RUN;

PROC PRINT;
  title 'Output Dataset: BACK';
RUN;
