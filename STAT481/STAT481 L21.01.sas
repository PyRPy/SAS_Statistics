* 21.1 - Creating a Single Observation From Multiple Records;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 
* Example 21.1. The following program uses three INPUT statements 
to read in January weather statistics for three cities — State 
College, Miami, and Honolulu — when the data values for each 
city are recorded over three records in the input data file:;

DATA january;
   input City & $13. State $;
   input AvgHigh AvgLow Mean;
   input Precip;
   DATALINES;
   State College  PA
   32 16 25
   2.4
   Miami  FL
   75 58 67
   2.0
   Honolulu  HI
   80 65 74
   3.6
   ;
RUN;

PROC PRINT data = january;
   title 'January Weather for Three U.S. Cities';
RUN;

* NOTE The first INPUT statement tells SAS to read the 
City and State into the observation. (The ampersand (&) 
modifier is used because one of the cities — State College — 
contains an embedded blank, and the city and states are 
separated by two blank spaces.) Then, the second INPUT 
statement tells SAS to read into the observation the average 
high temperature (AvgHigh), the average low temperature 
(AvgLow) and the overall average temperature (Mean) for 
the city in January. Finally, the third INPUT statement 
tells SAS to read the average precipitation (Precip) in 
January for the city into the observation. ;


* Example 21.2. The following program uses the forward 
slash (/) line pointer control to read in January weather 
statistics for three cities — State College, Miami, and 
Honolulu — when the data values for each city are recorded 
over three records in the input data file:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 

DATA january;
   input   City & $13. State $
         / AvgHigh AvgLow Mean
		 / Precip;
   DATALINES;
   State College  PA
   32 16 25
   2.4
   Miami  FL
   75 58 67
   2.0
   Honolulu  HI
   80 65 74
   3.6
   ;
RUN;

PROC PRINT data = january;
   title 'January Weather for Three U.S. Cities';
RUN;

* NOTE You'll want to keep in mind that when you use the 
forward slash (/) line pointer control in a single INPUT 
statement as we did here, your INPUT statement should contain 
just one semi-colon at the end of it. ;

* Example 21.3. The following program attempts to use forward 
slash (/) pointer controls to read in the January weather 
statistics for our three cities, State College, Miami, and 
Honolulu, when the record containing the precipitation for 
Miami is omitted from the input data file:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 

DATA january;
   input   City & $13. State $
         / AvgHigh AvgLow Mean
		 / Precip;
   DATALINES;
   State College  PA
   32 16 25
   2.4
   Miami  FL
   75 58 67
   Honolulu  HI
   80 65 74
   3.6
   ;
RUN;

PROC PRINT data = january;
   title 'January Weather for Three U.S. Cities';
RUN;

* NOTE The moral of the story ... before you use a forward 
slash (/) pointer control in an INPUT statement, make sure 
that the raw data file contains the same number of records 
for each observation.;

* First, note that the input data file contains only two 
records for Miami — the city name record and the temperature 
record, but not the precipitation record. Then, launch and 
run the SAS program. Review the output to convince yourself 
that SAS had trouble reading in the temperature data correctly. 
As you can see by the message in the log window:;

* you can use the pound-n (#n) line pointer control to tell 
SAS to advance to a specific record before reading the next 
data value. Because the #n line pointer control moves 
the input pointer to a particular record, it can be used to 
read the records in a data file in any order.;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 

DATA january;
   input #2 AvgHigh AvgLow Mean
         #3 Precip
         #1  City & $13. State $;		 
   DATALINES;
   State College  PA
   32 16 25
   2.4
   Miami  FL
   75 58 67
   2.0
   Honolulu  HI
   80 65 74
   3.6
   ;
RUN;

PROC PRINT data = january;
   title 'January Weather for Three U.S. Cities';
RUN;

* Example 21.5. The following program uses both the / and #n 
line pointer controls to read in January weather statistics 
for three cities — State College, Miami, and Honolulu — when 
the data values for each city are recorded over three records 
in the input data file:;

* Although, as you'll see, it's not perfectly flexible, you 
can use the forward slash (/) and pound-n (#n) line pointer 
controls together in the same INPUT statement to read 
multiple records both sequentially and non-sequentially.;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 

DATA january;
   input #3 Precip 
         #1 City & $13. State $
          / AvgHigh AvgLow Mean;		 
   DATALINES;
   State College  PA
   32 16 25
   2.4
   Miami  FL
   75 58 67
   2.0
   Honolulu  HI
   80 65 74
   3.6
   ;
RUN;

PROC PRINT data = january;
   title 'January Weather for Three U.S. Cities';
RUN;

* 21.2 - Creating Multiple Observations From a Single Record;
* 21.3 - Reading Repeating Blocks of Data;
* Example 21.6. The following SAS program uses the double 
trailing at sign (@@) to read in the average high and low 
temperatures in State College, PA for each month, when each 
record in the input data file contains the data values for 
three observations:;
* In order to read in the data set as desired, we need to take 
advantage of the INPUT statement's double trailing at sign (@@). 
Errr ... what the heck is that? The double trailing at sign (@@) 
tells SAS rather than advancing to a new record, hold the current 
input record for the execution of the next INPUT statement, even
across iterations of the DATA step. Perfectly clear, eh? Let's 
take a look at an example to see if we can make sense of it!;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 

DATA StateCollege;
   input Month $ AvgHigh AvgLow @@;		 
   DATALINES;
Jan 32 16 Feb 35 18 Mar 46 26
Apr 58 37 May 68 47 Jun 78 56
Jul 82 60 Aug 80 58 Sep 72 51
Oct 61 40 Nov 48 32 Dec 37 22
   ;
RUN;

PROC PRINT data = StateCollege;
   title 'Average Temperatures for State College';
   id Month;
RUN;

* NOTE Now can we say that we all get the idea? Let's assume so 
and stop there! Just keep in mind these few important points 
about the trailing @@:

- The trailing @@ holds a data line in the input buffer across 
multiple iterations of the DATA step.
- The trailing @@ is most frequently used to read multiple SAS 
observations from a single input record, just as was done in our example.
- The trailing @@ should not be used in conjunction with column 
input, the @n absolute pointer control, nor with the MISSOVER option.;


* 21.4 - Reading the Same Number of Repeating Fields;
* Example 21.7. The following program uses single 
trailing at signs (@) in multiple INPUT statements 
along with multiple output statements to read a raw 
data file into a temporary SAS data set called grades:;

* The trailing @ will do the trick for us here, because 
we do not need SAS to hold the current record across multiple 
iterations of the DATA step. Let's make more sense of all of 
this by looking at an example!;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA grades;
    input ID @;
    input score @;
	output;
	input score @;
	output;
	input score @;
	output;
    DATALINES;
  111000234 79 82 100
  922232573 87 89  95
  252359873 65 72  73
  205804679 92 95  99
  ;
RUN;

PROC PRINT data = grades NOOBS;
   title 'Grades data set';
RUN; 

* Example 21.8. The following program is identical in 
behavior to the previous program, except here the 
alternating sets of three INPUT and OUTPUT statements 
have been collapsed into one iterative DO loop:;
* The trailing @ will do the trick for us here, because 
we do not need SAS to hold the current record across 
multiple iterations of the DATA step. Let's make more 
sense of all of this by looking at an example!;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA grades;
    input ID @;
	DO exam = 1 to 3;
	    input score @;
	    output;
	END;
	DATALINES;
  111000234 79 82 100
  922232573 87 89  95
  252359873 65 72  73
  205804679 92 95  99
  ;
RUN;

PROC PRINT data = grades NOOBS;
   title 'Grades data set';
RUN; 

* 21.5 - Reading a Varying Number of Repeating Fields;
* Example 21.9. The following program uses trailing at 
signs (@) in conjunction with the MISSOVER option and 
a conditional DO WHILE loop to read in a raw data file 
containing a varying number of weights in each record:;

* Because the input data file contains a varying number 
of repeated fields in each record, our methods of the 
last section are going to have to be modified. We can 
still take advantage of the trailing @ to tell SAS to 
hold the records in the input buffer. We'll also have 
to take advantage, however, of the INFILE statement's 
MISSOVER option, as well as have to replace the iterative 
DO loop with a DO WHILE loop. Let's take a look!;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA dietdata;
    infile DATALINES MISSOVER;
    input id weight @;
	weighin = 0;
	DO WHILE (weight ne .);
	    weighin+1;
		output;
	    input weight @;
	END;
	DATALINES;
  1001 179 172 169
  1002 250 249
  1003 190 196 195 164 158
  1004 232 224 219 212 208
  1005 211 208 204 202
  ;
RUN;

PROC PRINT data = dietdata NOOBS;
   title 'The dietdata data set';
   var id weighin weight;
RUN; 







