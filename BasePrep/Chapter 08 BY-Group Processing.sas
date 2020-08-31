/* Chapter 8: BY-Group Processing */
/* Definitions */
/* Preprocessing Data */
* Example: Sorting Observations for BY-Group Processing;
proc sort data=cert.usa out=work.usa;
  by manager;
run;
proc print data=work.usa;
run;

/* FIRST. and LAST. DATA Step Variables */
* Example: Grouping Observations Using One BY Variable;
proc sort data=cert.usa out=work.temp;                /*#1*/
  by dept;
run;
data work.budget(keep=dept payroll);                  /*#2*/
  set work.temp;
  by dept;                                            /*#3*/
  if wagecat='S' then Yearly=wagerate*12;             /*#4*/
    else if wagecat='H' then Yearly=wagerate*2000;
  if first.dept then Payroll=0;                       /*#5*/
  payroll+yearly;                                     /*#6*/
  if last.dept;                                       /*#7*/
run;

proc print data=work.budget noobs; 
  sum payroll; 
  format payroll dollar12.2; 
run;

* Example: Grouping Observations Using Multiple BY Variables;
proc sort data=cert.usa out=work.temp2;               /*#1*/
  by manager jobtype;
run;
data work.budget2 (keep=manager jobtype payroll);     /*#2*/
  set work.temp2;
  by manager jobtype;                                 /*#3*/
  if wagecat='S' then Yearly=wagerate*12;             /*#4*/
    else if wagecat='H' then Yearly=wagerate*2000;
  if first.jobtype then Payroll=0;                    /*#5*/
  payroll+yearly;                                     /*#6*/
  if last.jobtype;                                    /*#7*/
run;

proc print data=work.budget2 noobs;
  by manager;
  var jobtype;
  sum payroll;
  where manager in ('Coxe', 'Delgado');
  format payroll dollar12.2;
run;
