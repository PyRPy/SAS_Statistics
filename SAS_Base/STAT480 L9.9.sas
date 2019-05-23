* 9.4 - Permanent Formats;

* Example 9.9. The following SAS program illustrates a FORMAT procedure 
that creates a permanent formats catalog in the directory referenced 
by library, that is, in C:\simon\icdb\data:;

LIBNAME library '/folders/myfolders/sasuser.v94/STAT480/Data';

PROC FORMAT library=library;
   value sex2fmt 1 = 'Male'
                 2 = 'Female';

   value race2fmt 3 = 'Black'
                  4 = 'White'
                  OTHER = 'Other';
 RUN;

 DATA temp4; 
   infile '/folders/myfolders/sasuser.v94/STAT480/Data/back.dat';
   input subj 1-6 sex 17 race 19;
   format sex sex2fmt. race race2fmt.;
 RUN;

 PROC CONTENTS data=temp4;
   title 'Output Dataset: TEMP4';
 RUN;

 PROC PRINT data=temp4;
 RUN;

* Example 9.10. Rather than creating a permanent formats catalog, you 
can create a SAS program file which contains only a FORMAT procedure 
with the desired value and invalue statements. Then you need merely 
include this secondary program file in your main SAS program using 
the %INCLUDE statement, as illustrated here:;

%INCLUDE '/folders/myfolders/sasuser.v94/STAT480/backfmt.sas';

 PROC FREQ data=back;
   title 'Frequency Count of STATE (statefmt)';
   format state statefmt.;
   table state/missing;
 RUN;