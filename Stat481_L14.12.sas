* 14.4 - The RENAME= option;
* Example 14.12. The following program illustrates 
the use of the RENAME= option in the SET statement. 
Specifically, the variable sex is changed to gender, 
and b_date is changed to birth, when the program 
data vector is created:;

DATA back7 (keep = subj gender v_date birth age);
    set back3 (rename=(sex=gender b_date=birth));
    age = (v_date - birth)/365;   *MUST use NEW name for date of birth;
RUN;

PROC PRINT data=back7;
    title 'Output Dataset: BACK7';
RUN;


* Example 14.13. The following program illustrates 
use of the RENAME= option, when it appears in the 
DATA statement. Specifically, the variable sex is 
changed to gender, and b_date is changed to birth 
when SAS writes the data to the output data set:;

DATA back8 (rename=(sex=gender b_date=birth)
              keep = subj sex v_date b_date age);
    set back3;
    age = (v_date - b_date)/365;      *MUST use OLD name for date of birth;
RUN;

PROC PRINT data=back8;
    title 'Output Dataset: BACK8';
RUN;
* NOTE Also note that the KEEP= option in the DATA 
statement must refer to the original variable names 
as they appear in the back3 data set.;
  
* 14.5 - The IN= option;
* Example 14.14. The following program illustrates 
using the IN= option when concatenating that is, 
appending one data set to another data set. Although 
we'll take a closer look at concatenating two or 
more data sets in the next lesson, this example 
will give you a taste of what's to come:;


DATA temple (where = (int(subj/10000)=23)) 
       okla (where = (int(subj/10000)=31));
     set icdb.back;
     drop r_id race ethnic relig mar_st ed_level 
          emp_st job_chng income;
RUN;  
DATA back9;
    set temple okla (in=okie);
    if okie = 1 then hospital = 31;
      else if okie = 0 then hospital = 23;
RUN;

PROC PRINT data=back9;
    title 'Output Dataset: BACK9';
RUN;
  

* Example 14.15. The following program illustrates 
a cute programming trick when using the IN= option. 
Specifically, it illustrates how SAS assumes that 
you mean "if varname = 1" in an IF statement if you 
just say "if varname" where varname is the variable 
name specified in an IN= option. Therefore, you can 
use this fact to create helpful temporary variable 
names, such as indatasetname. Let's take a look:;

DATA back10;
    set temple okla (in=inokie);
    if inokie then hospital = 31;
      else hospital = 23;
  RUN;

  PROC PRINT data=back10;
    title 'Output Dataset: BACK10';
  RUN;
  
