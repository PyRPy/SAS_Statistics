/*Chapter 11: Processing Data with DO Loops */
/* The Basics of DO Loops */
* Example: DO and END Statements;
data work.stresstest;
  set cert.tests;
  TotalTime=(timemin*60)+timesec;
  retain SumSec 5400;
  sumsec+totaltime;
  length TestLength $6 Message $20;
  if totaltime>800 then  
    do;
        TestLength='Long';
        message='Run blood panel';
    end;
    else if 750<=totaltime<=800 then TestLength='Normal';
    else if totaltime<750 then TestLength='Short';
run;
proc print data=work.stresstest;
run;

* Example: Processing Iterative DO Loops;
data work.earn (drop=month); 
  set cert.master; 
  Earned=0; 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
  earned+(amount+earned)*(rate/12); 
run;

proc print data = earn;
run;
* use do...end loop;
data work.earnings (drop=month); 
  set cert.master; 
  Earned=0; 
  do month=1 to 12; 
    earned+(amount+earned)*(rate/12); 
  end;
  Balance=Amount+Earned; 
run; 
proc print data=work.earnings;
run;

/* Constructing DO Loops */
data work.earnings; 
  Amount=1000; 
  Rate=0.75/12; 
  do month=1 to 12; 
    Earned+(amount+earned)*rate; 
  end; 
run;

proc print data=work.earnings;
run;

* Using Explicit OUTPUT Statements;
proc print data=work.earn;
run;
data work.earn; 
  Value=2000; 
  do Year=1 to 20; 
    Interest=value*.075; 
    value+interest; 
    output; 
  end; 
run;
proc print data=work.earn;
run;

* Decrementing DO Loops;
* Specifying a Series of Items;

/* Nesting DO Loops */
* indention for clarity;
data work.earn; 
  Capital=2000; 
  do month=1 to 12; 
    Interest=capital*(.075/12); 
    capital+interest; 
  end; 
run;

data work.earn; 
  do year=1 to 20; 
    Capital+2000; 
      do month=1 to 12; 
        Interest=capital*(.075/12); 
        capital+interest;  
      end;  
  end;  
run;

proc print data=work.earn;
run;

/* Iteratively Processing Observations from a Data Set */
proc print data=work.cdrates;
run;
data work.compare(drop=i); 
  set work.cdrates; 
  Investment=5000; 
  do i=1 to years; 
    investment+rate*investment; 
  end; 
run;
proc print data=work.compare;
run;

/* Conditionally Executing DO Loops */

* Using the DO UNTIL Statement;
data work.invest; 
  do until(Capital>=50000); 
    capital+2000; 
    capital+capital*.10; 
    Year+1; 
  end; 
run;

proc print data=work.invest;
run;

* Using the DO WHILE Statement;
data work.invest; 
  do while(Capital>=50000); 
    capital+2000; 
    capital+capital*.10; 
    Year+1; 
  end; 
run;
* will not run;

data work.invest; 
  do year=1 to 10 until (Capital>=50000);
    capital+4000; 
    capital+capital*.10; 
  end; 
run;
proc print data=work.invest;
run;
