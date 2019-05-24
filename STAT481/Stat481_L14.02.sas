
*14.1 - The FIRSTOBS= and OBS= options;
 
* Example 14.2. The following program uses the SET 
statement's FIRSTOBS= and OBS= options to tell SAS 
to include fourteen observations — observations 
7, 8, 9, ..., and 20 from the permanent icdb.back data 
set in the temporary back data set:;
/* NOTES
The SET statement's FIRSTOBS= option tells SAS to begin 
reading the data from the input SAS data set at the 
line number specified by FIRSTOBS.
The SET statement's OBS= option tells SAS to stop reading 
the data from the input SAS data set at the line number 
specified by OBS.
*/
* LIBNAME stat481 'C:/Data_SAS';
  DATA back1;
    set icdb.back (FIRSTOBS=7 OBS=20);
  RUN;

  PROC PRINT data=back1;
    title 'Output Dataset: BACK1';
  RUN;

* 14.2 - The DROP= and KEEP= options;
* On the SET Statement;
* Example 14.3. The following program tells SAS to 
  keep just three variables subj, v_date, and 
  b_date when reading from the back1 data set 
  in order to create the back2 data set:;

DATA back2;
     set back1 (keep = subj v_date b_date);
     age = (v_date - b_date)/365;  * Calculate AGE in years;
	 format age 4.1;
   RUN;

PROC PRINT data=back2;
     title 'Output Dataset: BACK2';
RUN;
   
* Example 14.4. The following program tells SAS to drop 
nine variables r_id, race, ..., and income when reading 
from the back1 data set in order to create the back3 
data set:;

DATA back3;
     set back1 (drop = r_id race ethnic relig mar_st 
                       ed_level emp_st job_chng income);
   RUN;

   PROC PRINT data=back3;
     title 'Output Dataset: BACK3';
   RUN;

* On the DATA Statement;
* Example 14.5. Rather than using the KEEP= option on 
the SET statement, you can use the KEEP= option on 
the DATA statement. The following program tells 
SAS to keep four variables — subj, v_date, b_date, 
and age — when writing to the output data set 
called back2a:;

DATA back2a (keep = subj v_date b_date age);
     set back1;
     age = (v_date - b_date)/365;  * Calculate AGE in years;
     format age 4.1;
   RUN;

PROC PRINT data=back2a;
     title 'Output Dataset: BACK2A';
RUN;

* Example 14.6. Rather than using the DROP= option 
on the SET statement, you can use the DROP= option 
on the DATA statement. The following program tells 
SAS to drop nine variables r_id, race, ..., 
and income when writing to the output data 
set back3a:;

DATA back3a (drop = r_id race ethnic relig mar_st 
                       ed_level emp_st job_chng income);
       set back1;
   RUN;

   PROC PRINT data=back3a;
      title 'Output Dataset: BACK3A';
   RUN;

* Example 14.7. The following SAS program illustrates 
our working strategy of when to use the KEEP= option 
in the SET statement and when to use the KEEP= option 
in the DATA statement:;

DATA back6 (keep = subj age);
     set back1 (keep= subj v_date b_date);
     age = (v_date - b_date)/365;
     format age 4.1;
  RUN;

PROC PRINT data=back6;
     title 'Output Dataset: BACK6';
RUN;
  
* Example 14.8. Rather than using the KEEP= option 
of the DATA statement, you can also tell SAS which 
variables in a data set to keep using a KEEP 
statement within your DATA step. The following SAS
program illustrates use of the KEEP statement:;

DATA back4;
     set back1;
     age = (v_date - b_date)/365;
     format age 4.1;
     keep subj v_date b_date;
   RUN;

PROC PRINT data=back4;
    title 'Output Dataset: BACK4';
RUN;

* Example 14.9. Of course, rather than using the 
DROP= option of the DATA statement, you can also 
tell SAS which variables in a data set to drop 
using a DROP statement within your DATA step. The 
following SAS program illustrates use of the 
DROP statement:;

DATA back5;
     set back1;
     age = (v_date - b_date)/365;
     format age 4.1;
     drop r_id race ethnic relig mar_st ed_level emp_st job_chng
          income sex state country;
   RUN;

PROC PRINT data=back5;
    title 'Output Dataset: BACK5';
RUN;
   
* 14.3 - The WHERE= option;
* Example 14.10. The following program illustrates 
the use of the WHERE= option to select observations 
from a SAS data set that meet a certain condition. 
Because the WHERE= option is attached to the DATA
statement, the selection process takes place as SAS 
writes the data from the program data vector to the 
output data set:;

* LIBNAME icdb 'C:\Simon\Stat481WC\sp09\02datastep\sasndata';

DATA temple (where = (int(subj/10000)=23)) 
       okla (where = (int(subj/10000)=31));
     set icdb.back;
     drop r_id race ethnic relig mar_st ed_level 
          emp_st job_chng income;
RUN;

PROC PRINT data=temple;
    title 'Output Dataset: TEMPLE';
RUN;

PROC PRINT data=okla;
    title 'Output Dataset: OKLA';
RUN;

* Example 14.11. The following program illustrates 
efficient use of the WHERE= option in the SET statement. 
Because the WHERE= option appears in the SET statement, 
the selection process takes places as SAS reads in the 
observations from the icdb.back data set:;

* LIBNAME icdb 'c:\lsimon\icdb\data'; 

DATA temple2;
      set icdb.back (where = (int(subj/10000)=23));
      drop r_id race ethnic relig mar_st ed_level emp_st job_chng income;
RUN;
   
PROC PRINT data = temple2;
      title 'Output Dataset: TEMPLE2';
RUN;


