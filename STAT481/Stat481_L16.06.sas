* 16.2 - How SAS Match-Merges;
* Example 16.6. The following program is identical to the 
first program that appears in Example 16.4:;

DATA moredemog;
  input subj gender $ age v_date mmddyy8.;
  format v_date mmddyy8.;
  DATALINES;
  1000 M 42 03/10/96
  1001 M 20 02/19/96
  1002 F 53 02/01/96
  1003 F 40 12/31/95
  1004 M 29 01/10/97
;
RUN;
  
DATA morestatus;
  input subj disease $ test $ v_date mmddyy8.;
  format v_date mmddyy8.;
  DATALINES;
  1000 Y Y 03/17/96
  1001 N Y 03/01/96
  1002 N N 02/18/96
  1003 Y Y 01/15/96
  1004 N N 02/01/97
;
RUN;

DATA morepatients;
   merge moredemog morestatus;
   by subj;
RUN;

PROC PRINT data=morepatients NOOBS;
  title 'The morepatients data set';
RUN;

* Example 16.7. The following program is identical 
to the first program that appears in Example 16.5:;

DATA salesone;
   input year prd sales;
   DATALINES;
   2004 1 100
   2004 2 200
   2005 3 300
   2006 4 400
   2007 5 500
   2008 6 600
  ;
 RUN;

 DATA salestwo;
   input year loc sales;
   DATALINES;
   2004 7  700
   2004 8  800
   2004 9  900
   2006 10 950
   2007 11 960
   2008 12 970
  ;
 RUN;

 DATA allsales;
    merge salesone salestwo;
    by year;
 RUN;

 PROC PRINT data=allsales NOOBS;
   title 'The allsales data set';
 RUN;
 
* 16.3 - Renaming Variables;
* Example 16.8. The following program uses the 
 RENAME= option to rename the v_date variables 
 in the demogtwo and statustwo data sets, so that 
 when they are merged into a new data set called 
 patientstwo, both visit dates are preserved:;

DATA demogtwo;
  input subj gender $ age v_date mmddyy8.;
  format v_date mmddyy8.;
  DATALINES;
  1000 M 42 03/10/96
  1001 M 20 02/19/96
  1002 F 53 02/01/96
  1003 F 40 12/31/95
  1004 M 29 01/10/97
;
RUN;
  
DATA statustwo;
  input subj disease $ test $ v_date mmddyy8.;
  format v_date mmddyy8.;
  DATALINES;
  1000 Y Y 03/17/96
  1001 N Y 03/01/96
  1002 N N 02/18/96
  1003 Y Y 01/15/96
  1004 N N 02/01/97
;
RUN;
DATA patientstwo;
   merge demogtwo (rename = (v_date = demogdate))
         statustwo (rename = (v_date = statusdate));
   by subj;
RUN;

PROC PRINT data=patientstwo NOOBS;
  title 'The patientstwo data set';
RUN;

* 16.4 - Excluding Unmatched Observations;
* Example 16.9. The following program simply reads 
in the patients and allvoids data sets:;

DATA patients;
   input id v_date : mmddyy8.;
   format v_date mmddyy8.;
   DATALINES;
   110011 01/01/06
   110012 01/02/06
   110013 01/04/06
   ;
RUN;

DATA allvoids;
   input id v_date : mmddyy8. void_no volume;
   format v_date mmddyy8.;
   DATALINES;
   110011  01/01/06 1 250
   110011  01/01/06 2 300
   110011  01/01/06 3 302
   110011  01/01/06 4 231
   110012  01/02/06 1 305
   110012  01/02/06 2 225
   110012  01/02/06 3 400
   110013  01/04/06 1 300
   110013  01/04/06 2 333
   110013  01/04/06 3 401
   110013  01/04/06 4 404
   110014  01/06/06 1 398
   110014  01/06/06 2 413
;
RUN;

* Now, if we wanted to analyze the voiding data, we'd have 
to make sure that we didn't include any data from patients 
not included in the patients data set. That is, we'd want 
to to exclude the voiding data corresponding to subject 
110014. If we merge the patients and allvoids data sets 
by the id and v_date variables, we get an analysis data 
set that has one observation for each patient's reported void:;

DATA analysis;
  merge patients allvoids;
  by id v_date;
RUN;

PROC PRINT data=analysis NOOBS; 
  title 'The analysis data set'; 
RUN;

* In reviewing the output, you should also note that we 
have not yet achieved what we set out to do, namely to 
create an analysis data set that contains only the voiding data 
for the patients appearing in the patients data set. That is, 
the analysis data set still includes the voiding data on subject 
110014. The following code uses the IN= option and a subsetting 
IF statement to help us accomplish our task:;

DATA analysis;
  merge patients (in = inpatients)
        allvoids (in = inallvoids);
  by id v_date;
  if inpatients and inallvoids;
RUN;

PROC PRINT data=analysis NOOBS; 
  title 'The analysis data set'; 
RUN;

* The IN = inpatients option tells SAS to assign a value 
of 1 to the inpatients variable when an observation from 
the patients data set contributes to the current observation. 
Likewise, the IN = inallvoids option tells SAS to assign a 
value of 1 to the inallvoids variable when an observation 
from the allvoids data set contributes to the current 
observation. The subsetting IF statement tells SAS to write 
only those observations to the analysis data set whose 
value for both inpatients and inallvoids is 1, that is, 
only those observations that were created from observations 
in both the patients and allvoids data sets.;

* 16.5 - Selecting Variables;
* Example 16.10. The following program prints a subset of 
the observations in the ICDB Study's background (back), pain 
and urgency (purg), and family history (fhx) data sets:;

LIBNAME icdb 'C:/Data_SAS';

PROC PRINT data = icdb.back (OBS=5) NOOBS;
   title 'The back data set';
RUN;

PROC PRINT data = icdb.purg (OBS=5) NOOBS;
     title 'The purg data set';
	 where v_type = 0;
RUN;

PROC PRINT data = icdb.fhx (OBS=5) NOOBS;
     title 'The fhx data set';
RUN;

* no data set available above
