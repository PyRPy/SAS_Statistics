/* Chapter 7: Understanding DATA Step Processing */
* How SAS Processes Programs ;
* Compilation Phase;
data work.update;
  set cert.invent;
  Total=instock+backord;
  SalePrice=(CostPerUnit*0.65)+CostPerUnit;
  format CostPerUnit SalePrice dollar6.2;
run;

proc contents data=work.update;
run;

* Execution Phase;
* Debugging a DATA Step;
proc freq data=cert.pats;
      tables Gender Age; 
run;

proc means data=cert.pats;
  var Age;
run;
* corrections;
data work.pats_clean;
  set cert.pats;
  gender=upcase(Gender);
  if Gender='G' then Gender='M';
run;
proc print data=work.pats_clean;
run;

* corrections;
data work.clean_data;
  set cert.pats;
  gender=upcase(Gender);
  if Gender='G' then Gender='M';
  if id=1147 then age=65;
  else if id=5277 then age=75;
run;
proc print data=work.clean_data;
run;

* remove obs conditionally;
data work.clean_data;
  set cert.pats;
  gender=upcase(Gender);
  if Gender='G' then Gender='M';
  if Age>110 then delete;
run;
proc print data=work.clean_data;
run;

/* Testing Your Programs */
* Limiting Observations;
data work.limitobs;
  set cert.invent (obs=10);
  total=instock+backord;
run;
proc print data = limitobs;
run;

* Example: Viewing Execution in the SAS Log;
data work.update;
  set cert.invent;
  putlog 'PDV After SET Statement';
  putlog _all_;
  Total=instock+backord;
  SalePrice=(CostPerUnit*0.65)+CostPerUnit;
  format CostPerUnit SalePrice dollar 6.2;
run;
