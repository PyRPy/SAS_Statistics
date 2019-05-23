* 9.6 - The PICTURE Statement;

* Example 9.12.The FORMAT procedure in the following SAS program 
defines a picture format for the ICDB variable subj:;

PROC FORMAT;
   picture subjpix LOW-HIGH = '00-0000';
RUN;

PROC PRINT data=back;
   title 'BACK dataset with SUBJ pictured as 00-0000';
   format subj subjpix.;
   var subj v_date sex;
RUN; 

* Example 9.13. The following SAS program illustrates two more picture 
formats:;

DATA temp5;
    input subj ssn expens;
    datalines;
 110051 001111111  1099.99
 110088 022234567 10876.34
 210012 123345567  9567.21
 220004 120451207  5640.12
 230006 125398710   344.46
 310083 237982019  3235.09
 410012 323432429  1343.03
 420037 340234839 11348.29
 510027 928373402  7362.79
 520017 433492349  3295.09
 ;
 RUN;

PROC FORMAT;
   picture ssnpix LOW-HIGH = '999-99-9999';

   picture dolpix LOW-HIGH = '000,000.00' (prefix='$' fill='*');
RUN;

PROC PRINT data=temp5;
    title 'Output Dataset: TEMP5.  Examples of Picture Formats.';
    format ssn ssnpix. expens dolpix.;
    var subj ssn expens;
RUN;

* Example 9.14. The following code uses the FORMAT procedure's FMTLIB 
option to request that SAS display information about three formats 
appearing in the work.format catalog:;

PROC FORMAT FMTLIB;
   title 'Selected Formats from WORK.FORMAT Catalog';
   select racefmt ssnpix dolpix;
RUN;
