* 9.2 - The INVALUE Statement;

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


* Example 9.2. We'll also need to work with an raw data file version 
of the subset data set. The following SAS code creates the ascii raw 
data file, in column format, from the temporary back data set:;

DATA _NULL_;
  set back;
  file '/folders/myfolders/sasuser.v94/STAT480/Data/back.dat';
  put subj 1-6 @8 b_date mmddyy8. sex 17 race 19 
      relig 21 state 23-24 country 26-27 
      @29 age 4.1 @34 v_date mmddyy8.;
RUN;


* Example 9.3. The following SAS code illustrates the use of the FORMAT 
procedure to define how SAS should translate the two character variables 
sex and race during input:;

PROC FORMAT;
  invalue $insex '1' = 'M'
                 '2' = 'F';

  invalue $inrace '1' = 'Indian'
                  '2' = 'Asian'
                  '3' = 'Black'
                  '4' = 'White';
RUN;

PROC PRINT;
  title 'Output Dataset: with Informat';
RUN;

* Example 9.4. The following data step uses the informats that we 
defined in the previous example to read in a subset of the data 
from the input raw data file back.dat:;

DATA temp1;
  infile '/folders/myfolders/sasuser.v94/STAT480/Data/back.dat';
  length sex $ 1 race $ 6;
  input subj 1-6 @17 sex $insex1. @19 race $inrace1.;
RUN;

PROC CONTENTS data=temp1;
  title 'Output Dataset: TEMP1';
RUN;

PROC PRINT data=temp1;
  var subj sex race;
RUN;

* On input, we have the option of specifying the length of the variables 
being read in. The length of the variables are specified in the informat 
name between the name and the period. For example, the length of the 
variable race being read in is defined as 1 in the informat $inrace1.;


