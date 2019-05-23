* 9.3 - The VALUE Statement;

* Example 9.5. The following FORMAT procedure defines how SAS should 
display numeric variables associated with the two formats sexfmt and 
racefmt during output:;

LIBNAME icdb '/folders/myfolders/sasuser.v94/STAT480/Data';

DATA back;
   set icdb.back;    
   age = (v_date - b_date)/365.25;
   if subj in (110051, 110088, 210012, 220004, 230006, 
               310083, 410012, 420037, 510027, 520017);
   keep subj v_date b_date age sex state country race relig;
   format age 4.1;
RUN;

PROC FORMAT;
  value sexfmt 1 = 'Male'
               2 = 'Female';

  value racefmt 1 = 'Indian'
                2 = 'Asian'
                3 = 'Black'
                4 = 'White';
RUN;


* Example 9.6. The following SAS code uses the formats to print in a 
meaningful way the sex and race variables contained in the back data 
set:;

DATA temp2;
   set back;
   f_race=race; 
   f_sex=sex;
   format f_race racefmt. f_sex sexfmt.;
RUN;

PROC PRINT data=temp2;
  title 'Output Dataset: TEMP2';
  var subj sex f_sex race f_race;
RUN;

PROC CONTENTS data=temp2;
RUN;

* Example 9.7. The FORMAT procedure is useful in defining meaningful 
categories once you've converted one or more (perhaps continuous) 
variables into one categorical variable. The following SAS code 
illustrates the technique:;

PROC FORMAT;
    value age2fmt 1 = 'LT 20'
                  2 = '20-44'
                  3 = '45-54'
                  4 = 'GE 54'
                  OTHER = 'Missing';
 RUN;

 DATA temp3;
   set back;
        if age = . then age2 = .;     
   else if age lt 20 then age2 = 1;
   else if age ge 20 and age lt 45 then age2 = 2;
   else if age ge 45 and age lt 54 then age2 = 3;
   else if age ge 54 then age2 = 4;
   format age2 age2fmt.;
 RUN;

 PROC FREQ data=temp3;
   title 'Age Frequency in TEMP3';
   table age2;
 RUN;

* Example 9.8. Now, as long as we are interested in grouping values 
of only one variable, rather than doing it as we did in the previous 
program, we can actually accomplish it a bit more efficiently 
directly within the FORMAT procedure. For example, the following SAS 
code uses the FORMAT procedure to define the format agefmt based on 
the possible values of the variable age:;

PROC FORMAT;
   value agefmt LOW-<20  = 'LT 20'
                20-<45  = '20-44'
                45-<54  = '45-54'
                54-HIGH = 'GE 54'
                OTHER   = 'Missing';
 RUN;

 
 PROC FREQ data=back;
   title 'Age Frequency in BACK';
   format age agefmt.;
   table age;
 RUN;

