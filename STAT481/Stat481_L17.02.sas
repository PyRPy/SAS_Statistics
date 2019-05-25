* Example 17.2. Using an OUTPUT statement suppresses the 
automatic output of observations at the end of the DATA 
step. Therefore, if you plan to use any OUTPUT statements 
in a DATA step, you must use OUTPUT statements to program 
all of the output for that step. The following SAS program 
illustrates what happens if you fail to direct all of 
the observations to output:;

DATA subj210006 subj310032;
   set stat481.icdblog;
   if (subj = 210006) then output subj210006;
 RUN;

 PROC PRINT data = subj210006 NOOBS;
   title 'The subj210006 data set';
 RUN;
 
 PROC PRINT data = subj310032 NOOBS;
   title 'The subj310032 data set';
 RUN;

 * NOTE  the subj210006 data set contains data for subject 
 210006, while the subj310032 data set contains 0 observations. ;
 
 * Example 17.3. If you use an assignment statement to create 
 a new variable in a DATA step in the presence of OUTPUT 
 statements, you have to make sure that you place the 
 assignment statement before the OUTPUT statements. 
 Otherwise, SAS will have already written the observation 
 to the SAS data set, and the newly created variable will 
 be set to missing. The following SAS program illustrates an 
 example of how two variables, current and days_vis, get 
 set to missing in the output data sets because their values 
 get calculated after SAS has already written the observation 
 to the SAS data set:;
 
 DATA subj210006 subj310032 subj410010;
   set stat481.icdblog;
        if (subj = 210006) then output subj210006;
   else if (subj = 310032) then output subj310032;
   else if (subj = 410010) then output subj410010;
   current = today();
   days_vis = current - v_date;
   format current mmddyy8.;
 RUN;

 PROC PRINT data = subj310032 NOOBS;
   title 'The subj310032 data set';
 RUN;
 
 * The following SAS program illustrates the corrected code 
 for the previous DATA step, that is, for creating new 
 variables with assignment statements in the presence of 
 OUTPUT statements:;
DATA subj210006 subj310032 subj410010;
   set stat481.icdblog;
   current = today();
   days_vis = current - v_date;
   format current mmddyy8.;
        if (subj = 210006) then output subj210006;
   else if (subj = 310032) then output subj310032;
   else if (subj = 410010) then output subj410010;
 RUN;

 PROC PRINT data = subj310032 NOOBS;
   title 'The subj310032 data set';
 RUN;
 
* Example 17.4. After SAS processes an OUTPUT statement within 
 a DATA step, the observation remains in the program data 
 vector and you can continue programming with it. You can 
 even output the observation again to the same SAS data set 
 or to a different one! The following SAS program illustrates 
 how you can create different data sets with the some of the 
 same observations. That is, the data sets created in your 
 DATA statement do not have to be mutually exclusive:;

 DATA symptoms visitsix;
   set stat481.icdblog;
   if form = 'sympts' then output symptoms;
   if v_type = 6 then output visitsix;
 RUN;

 PROC PRINT data = symptoms NOOBS;
   title 'The symptoms data set';
 RUN;

 PROC PRINT data = visitsix NOOBS;
   title 'The visitsix data set';
 RUN;
 
 
