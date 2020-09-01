/* Chapter 10: Combining SAS Data Sets */
/* How to Prepare Your Data Sets */
/* Methods of Combining SAS Data Sets: The Basics */
* One-to-One Reading: Details;
data work.one2one; 
  set cert.patients; 
  if age<60; 
  set cert.measure; 
run;

proc print data=one2one;
run;

/* Concatenating: Details */
data work.concat;
  set cert.therapy2012 cert.therapy2013;
run;
proc print data=work.concat;
run;

/* Match-Merging: Details */
proc sort data=cert.demog; 
  by id; 
run; 
proc print data=cert.demog; 
run;

proc sort data=cert.visit; 
  by id; 
run; 
proc print data=cert.visit; 
run;
* Example: Using Match-Merging to Combine Data Sets;
data work.merged; 
  merge cert.demog cert.visit; 
  by id; 
run; 
proc print data=work.merged; 
run;

* Example: Merge in Descending Order;
proc sort data=cert.demog; 
  by descending id; 
run; 
proc sort data=cert.visit; 
  by descending id; 
run; 
data work.merged; 
  merge cert.demog cert.visit; 
  by descending id; 
run; 
proc print data=work.merged; 
run;

/* Match-Merge Processing */
proc print data=work.claims noobs;
  format date date9.;
run;
* no data somehow;

/* Renaming Variables */
data work.merged;        
  merge cert.patdat (rename=(date=BirthDate)) 
    cert.visit (rename=(date=VisitDate)); 
    by id; 
run; 
* ERROR: BY variables are not properly sorted on data set CERT.VISIT.;
proc print data=work.merged; 
run;

/* Excluding Unmatched Observations */
data work.merged; 
  merge cert.patdat(in=inpat)  
    cert.visit(in=invisit
    rename=(date=BirthDate)); 
   by id; 
run;
/*
 To select only observations that appear in both Cert.Patdat and 
Cert.Visit, specify a subsetting IF statement in the DATA step. 
*/
data work.merged; 
  merge cert.patdat(in=inpat  
    rename=(date=BirthDate)) 
    cert.visit(in=invisit 
    rename=(date=VisitDate));  
   by id; 
   if inpat=1 and invisit=1; 
run; 
proc print data=work.merged; 
run;
* somehow ID sorted problem;
