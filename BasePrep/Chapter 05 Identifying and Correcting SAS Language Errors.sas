/* Chapter 5: Identifying and Correcting SAS Language Errors */
* Example: Syntax Error Messages;
data work.admitfee;             /*#1*/
  set cert.admit;
run;
proc prin data=work.admitfee;   /*#2*/
  var id name actlevel fee;     /*#3*/
run;

* Correcting Common Errors;
* Example: The DATA Step Produces Wrong Results but There Are No Error Messages ;
data work.grades; 
  set cert.class;
  Homework=Homework*2;
  AverageScore=MEAN(Score1 + Score2 + Score3 + Homework);
  PUTLOG Name= Score1= Score2= Score3= Homework= AverageScore=;
    if AverageScore<70;
run;
* corrections;
data work.grades; 
  set cert.class;
  Homework=Homework*2;
  AverageScore=MEAN(Score1, Score2, Score3, Homework);
    if AverageScore<70;
run;
proc print data=work.grades;
run; 

* Example: Using the PUT Statement;
data work.test;
  set cert.loan01;
  if code='1' then type='variable';                                /*#1*/
    else if code='2' then type='fixed';
    else type='unknown';
  if type='unknown' then put 'MY NOTE: invalid value: ' code=;     /*#2*/
run;

* Example: Character Strings;
data work.loan01;
  set cert.loan;
  if code='1' then type='variable';
    else if code='2' then type='fixed';
    else type='unknown';
  put 'MY NOTE: The condition was met.';
run;

* Example: Data Set Variables;
data work.loan01;
  set cert.loan;
  if code='1' then type='variable';
    else if code='2' then type='fixed';
    else type='unknown';
  put 'MY NOTE: Invalid Value: ' code=  type= ;
run;

* Example: Conditional Processing;
data work.newcalc;
  set cert.loan;
  if rate>0 then Interest=amount*(rate/12);
    else put 'DATA ERROR: ' rate= _n_ = ;
run;

* Missing RUN Statement ;
data work.admitfee;               /*#1*/
  set cert.admit;
proc print data=work.admitfee;    /*#2*/
  var id name actlevel fee;
run;                                  /*#3*/

* Missing Semicolon;
data work.admitfee;
  set cert.admit;
run;
proc print data=work.admitfee 
  var id name actlevel fee;
run;

* Unbalanced Quotation Marks;
data work.admitfee;
  set cert.admit;
  where actlevel='HIGH';
run;
proc print data=work.admitfee;
  var id name actlevel fee;
run;

* Semantic Error: Invalid Option;
data work.admitfee;
  set cert.admit;
  where weight>180 and (actlevel='MOD' or actlevel='LOW');
run;
proc print data=cert.admit keylabel;
  label actlevel='Activity Level';
run;
