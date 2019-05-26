* 18.1 - Constructing Do Loops;
* Example 18.1. The following program uses a DO loop to tell 
SAS to determine what four times three (4 × 3) equals:;

OPTIONS PS = 58 LS = 78 NODATE NONUMBER;

DATA multiply;
   answer = 0;
   do i = 1 to 4;
      answer + 3;
   end;
RUN;

PROC PRINT NOOBS;
   title 'Four Times Three Equals...';
RUN;

* Explicit OUTPUT Statements
Example 18.2. The following program uses an iterative DO 
loop to tell SAS to determine the multiples of 5 up to 100:;

DATA multiply (drop = i);
   multiple = 0;
   do i = 1 to 20;
      multiple + 5;
	  output;
   end;
RUN;

PROC PRINT NOOBS;
   title 'Multiples of 5 up to 100';
RUN;
* Example 18.3. The following SAS program uses an iterative 
DO loop to count backwards by 1:;
DATA backwardsbyone;
   do i = 20 to 1 by -1;
       output;
   end;
RUN;

PROC PRINT data = backwardsbyone NOOBS;
   title 'Counting Backwards by 1';
RUN;

* Example 18.4. Suppose you are interested in conducting 
an experiment with two factors A and B. Suppose factor A 
is, say, the amount of water with levels 1, 2, 3, and 4, and 
factor B is, say, the amount of sunlight, say with levels 
1, 2, 3, 4, and 5. Then, the following SAS code uses nested 
iterative DO loops to generate the 4 by 5 factorial design:;
DATA design;
   DO i = 1 to 4;
      DO j = 1 to 5;
        output;
	  END;
   END;
RUN;

PROC PRINT data = design;
   TITLE '4 by 5 Factorial Design';
RUN;

* Example 18.5. Back to our experiment with two factors A 
and B. Suppose this time that factor A is, say, the amount 
of water with levels 10, 20, 30, and 40 liters,and factor B 
is, say, the amount of sunlight, say with levels 3, 6, 9, 12, 
and 15 hours. The following SAS code uses two DO loops with 
BY options to generate a more meaningful 4 by 5 factorial 
design that corresponds to the exact levels of the factors:;
DATA design;
   DO i = 10 to 40 by 10;
      DO j = 3 to 15 BY 3;
        output;
	  END;
   END;
RUN;

PROC PRINT data = design;
   TITLE '4 by 5 Factorial Design';
RUN;

* 18.3 - Iteratively Processing Data;
* Example 18.6. Every Monday morning, a credit union in 
Pennsylvania announces the interest rates for certificates 
of deposit (CDs) that it will honor for CDs opened during the 
business week. Suppose you want to determine how much each 
CD will earn at maturity with an initial investment of $5,000. 
The following program reads in the interest rates advertised 
one week in early 2009, and then uses a DO loop to calculate 
the value of each CD when it matures:;

DATA cdinvest (drop = i);
    input Type $ 1-7 AnnualRate Months;
	Investment = 5000;
	do i = 1 to Months;
	     Investment + (AnnualRate/12)*Investment;
	end;
	format Investment dollar8.2;
	DATALINES;
03Month  0.01980  3
06Month  0.02230  6
09Month  0.02230  9
12Month  0.02470 12
18Month  0.02470 18
24Month  0.02570 24
36Month  0.02720 36
48Month  0.02960 48
60Month  0.03445 60
;
RUN;

PROC PRINT data = cdinvest NOOBS;
   title 'Comparison of Different CD Rates';
RUN;

* 18.4 - Conditionally Executing Do Loops;
* Example 18.7. Suppose you want to know how many years 
it would take to accumulate 50,000 ifyou deposit 1200 each 
year into an account that earns 5% interest. The following 
program uses a DO UNTIL loop to perform the calculation 
for us:;

DATA investment;
     DO UNTIL (value >= 50000);
	      value + 1200;
		  value + value * 0.05;
		  year + 1;
		  OUTPUT;
     END;
RUN;

PROC PRINT data = investment NOOBS;
   title 'Years until at least $50,000';
RUN;

* Example 18.8. The following program attempts to use 
a DO WHILE loop to accomplish the same goal as the 
program above, namely to determine how many years it 
would take to accumulate 50,000ifyoudeposit1200 each 
year into an account that earns 5% interest:;
DATA investtwo;
     DO WHILE (value <= 50000);
	      value + 1200;
		  value + value * 0.05;
		  year + 1;
		  OUTPUT;
     END;
RUN;

PROC PRINT data = investtwo NOOBS;
   title 'Years until at least $50,000';
RUN;

* Launch and run the SAS program, and review the output 
from the PRINT procedure to convince yourself that ... OOPS! 
There is no output! The program fails, because in a DO WHILE loop, 
the expression, in this case (value >= 50000), is evaluated 
at the top of the loop. Since value is set to missing before 
the first iteration of the DATA step, SAS can never enter the 
DO WHILE loop. Therefore, the code proves to be ineffective. 
Review the log to convince yourself that the investtwo data 
set contains no observations, because the DO WHILE loop 
was unable to execute.;

* Example 18.9. Now, the following program correctly uses 
a DO WHILE loop to determine how many years it would take 
to accumulate 50,000ifyoudeposit1200 each year into an account 
that earns 5% interest:;

DATA investthree;
     value = 0;
     DO WHILE (value < 50000);
	      value + 1200;
		  value + value * 0.05;
		  year + 1;
		  OUTPUT;
     END;
RUN;

PROC PRINT data = investthree NOOBS;
   title 'Years until at least $50,000';
RUN;

* Using Conditional Clauses in an Iterative DO Loop;
* Example 18.10. Suppose again that you want to know how 
many years it would take to accumulate 50,000 if you 
deposit 1200 each year into an account that earns 5% interest. 
But this time, suppose you also want to limit the number 
of years that you invest to 15 years. The following program 
uses a conditional iterative DO loop to accumulate our 
investment until we reach 15 years or until the value of 
our investment exceeds 50000, whichever comes first:;

DATA investfour (drop = i);
     DO i = 1 to 15 UNTIL (value >= 50000);
	      value + 1200;
		  value + value * 0.05;
		  year + 1;
		  OUTPUT;
     END;
RUN;

PROC PRINT data = investfour NOOBS;
   title 'Value of Investment';
RUN;

* Example 18.11. Suppose this time that you want to 
know how many years it would take to accumulate 50,000 
if you deposit 3600 each year into an account that earns 
5% interest. Suppose again that you want to limit 
the number of years that you invest to 15 years. The 
following program uses a conditional iterative DO loop 
to accumulate our investment until we reach 15 years or 
until the value of our investment exceeds 50000, whichever 
comes first:;

DATA investfive (drop = i);
     DO i = 1 to 15 UNTIL (value >= 50000);
	      value + 3600;
		  value + value * 0.05;
		  year + 1;
		  OUTPUT;
     END;
RUN;

PROC PRINT data = investfive NOOBS;
   title 'Value of Investment';
RUN;

* Example 18.12. The following program uses an iterative 
DO loop and the SET statement's POINT= option to select 
every 100th observation from the permanent data set called 
stat481.log11 that contains 8,624 observations:;

OPTIONS LS = 72 PS = 34 NODATE NONUMBER;
LIBNAME stat481 'C:\Data_SAS';

DATA sample;
   DO i = 100 to 8600 by 100;
         set stat481.log11 point = i;
         output;
   END;
   stop;
RUN;

PROC PRINT data = sample NOOBS;
    title 'Subset of Logged Observations for Hospital 11';
RUN;
* Note! It is important to emphasize that the method we 
illustrated here for selecting a sample from a large data 
set has nothing random about it. That is, we selected a 
patterned sample, not a random sample, from a large data set. 
That's why this section is called Creating Samples, not 
Creating Random Samples. We'll learn how to select a random 
sample from a large data set in Stat 482.;
 
