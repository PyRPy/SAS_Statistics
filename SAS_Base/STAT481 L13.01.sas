* 13.1 - Reading a Single SAS Data Set;
* Example 13.1. The following program uses the DATA 
step's SET statement to create a temporary SAS data 
set called work.penngolf, which is identical to the 
permanent SAS data set called stat481.penngolf:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;
LIBNAME stat481 'C:/Data_SAS';

DATA penngolf;
   set stat481.penngolf;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
RUN;

* 13.2 - Manipulating Data in a SAS Data Set;

* Example 13.2. The following program uses an IF-THEN-DELETE 
statement to exclude golf courses whose par is 70 from the 
penngolf data set:;

DATA penngolf;
   set stat481.penngolf;
   if par = 70 then DELETE;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
RUN;

* Example 13.3. The following program uses a subsetting 
IF statement to include only those golf courses whose 
par is greater than 70 in the penngolf data set:;

DATA penngolf;
   set stat481.penngolf;
   if par GT 70;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
RUN;

* Example 13.4. The following program uses a DROP statement 
to tell SAS to drop the Architect variable from the temporary 
output data set penngolf:;

DATA penngolf;
   set stat481.penngolf;
   drop Architect;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
RUN;

* Example 13.5. The following program uses the Slope and 
USGA variables in conjunction with an assignment statement 
to create a new variable called Bogey:;

DATA penngolf;
   set stat481.penngolf;
   Bogey = 0.186*Slope + USGA;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
   var Name Yards Par Slope USGA Bogey;
RUN;

* Example 13.6. The following program uses 1) a LABEL 
statement to associate descriptive labels to some of 
the variables in the penngolf data set and 2) a FORMAT 
statement to tell SAS how to display two of the 
variables (Bogey and Yards):;

DATA penngolf;
   set stat481.penngolf;
   Bogey = 0.186*Slope + USGA;
   label Bogey = 'Bogey Rating'
         USGA = 'USGA Rating'
         Slope = 'Course Slope'
         Par = 'Course Par'
         Yards = 'Total Yardage';
   format Bogey 4.1 Yards comma5.;
RUN;

PROC PRINT data = penngolf NOOBS LABEL;
   title 'The penngolf data set';
   var Name Yards Par Slope USGA Bogey;
RUN;

* Example 13.7. The following program uses a sum 
statement and an accumulator variable called TotalYards 
to tell SAS to tally up the number of Yards that 
the golf courses in the penngolf data set have:;

* In short, the sum statement adds the result of 
the expression that is on the right side of the plus 
sign (+) to the numeric accumulator variable that is 
on the left side of the plus sign. ;

DATA penngolf;
   set stat481.penngolf;
   TotalYards + Yards;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
   var Name Yards TotalYards;
RUN;

* Example 13.8. The following program uses a SELECT 
group to create a numeric variable called AssnFee 
that depends on the values of the character variable 
Type:;

DATA penngolf;
   set stat481.penngolf;
   select (Type);
       when ("Resort")  AssnFee = 5000;
	   when ("Private") AssnFee = 4000;
	   when ("SemiPri") AssnFee = 2000;
	   when ("Public")  AssnFee = 1000;
	   otherwise AssnFee = .;
   end;
   format Yards AssnFee comma5.;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
   var Name Yards Type AssnFee;
RUN;

* Example 13.9. The following program uses a SELECT 
group to create a new variable called Course whose 
value depends on the value of Yards:;

DATA penngolf;
   set stat481.penngolf;
   LENGTH Course $ 7;
   select;
       when (Yards GE 6700)          Course = 'Long';
	   when (6400 LE Yards LT 6700)  Course = 'Medium';
	   when (Yards LT 6400)          Course = 'Short';   
	   otherwise                     Course = 'Unknown';
   end;
   format Yards comma5.;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
   var Name Yards Course;
RUN;

* Example 13.10. The following SAS program is identical 
to the previous program, except the order of the 
conditions in the SELECT group has been reversed and 
the LENGTH statement has been removed:;

DATA penngolf;
   set stat481.penngolf;
   select;
       when (Yards = .)       Course = 'Unknown';       
	   when (Yards LT 6400 )  Course = 'Short';
	   when (Yards LT 6700)   Course = 'Medium';   
	   otherwise              Course = 'Long';
   end;
   format Yards comma5.;
RUN;

PROC PRINT data = penngolf NOOBS;
   title 'The penngolf data set';
   var Name Yards Course;
RUN;

