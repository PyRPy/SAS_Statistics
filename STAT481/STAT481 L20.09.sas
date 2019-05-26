* 20.3 - Issues with Reading Free-Format Data;
* Reading Missing Values Using List Input;

* Example 20.9. The following program uses list input 
and the INFILE statement's MISSOVER option to read in 
the number of books five children read each week in a 
library's summer reading program, when some of the 
values are missing at the end of a record:;

DATA reading;
   infile DATALINES MISSOVER;
   input Name $ Week1-Week5;
   DATALINES;
Robin 3 2 5 1 6
Jack 4 4 4 3 4
Tim 3 0 0
Martin 1 0 1 1
Caroline 2 3 4 5 6
RUN;

PROC PRINT data = reading;
   title 'Summer Reading Program';
   var Name Week1-Week5;
RUN;

* It is important to keep in mind that the MISSOVER option 
works only for missing values that occur at the end of the 
record. If your data contains missing values at the beginning 
or middle of a record, then you need instead to take advantage 
of the INFILE statement's DSD option.

Example 20.10. The following program uses list input and the 
NFILE statement's DSD option to read in the results of a survey 
of five people, when some of the values are missing 
in the middle of a record:;

DATA survey;
   infile DATALINES DLM=',' DSD;
   input Name $ (Q1-Q5) ($);
   DATALINES;
Robert,,A,C,A,D
William,B,C,A,D,A
Linda,C,B,,A,C
Lisa,D,D,D,C,A
Katherine,A,B,C,D,A
RUN;

PROC PRINT data = survey;
   title 'Survey Results';
   var Name Q1-Q5;
RUN;

* Example 20.11. The following program illustrates that 
the DSD option can also be used i) when there is a missing 
value at the beginning of a record, and ii) when the data are 
delimited by blanks (in conjunction with the DLM= option):;

DATA survey;
   infile DATALINES DLM=' ' DSD;
   input Name $ (Q1-Q5) ($);
   DATALINES;
Robert  A C A D
William B C A D A
Linda C B  A C
 D D D C A
Katherine A B C D A
RUN;

PROC PRINT data = survey;
   title 'Survey Results';
   var Name Q1-Q5;
RUN;

* Modifying the Length of Character Values

As mentioned previously, when you use list input to read 
raw data, character values are assigned a default length 
of 8. When we ran the last two programs, that's why 
Katherine was truncated to Katherin. The LENGTH statement 
will help us resolve this problem.

Example 20.12. The following program is identical to the 
previous program, except a LENGTH statement has been 
added to tell SAS to define the length of the character 
variable Name to be 9 rather than the default 8:;

DATA survey;
   infile DATALINES DLM=' ' DSD;
   length Name $ 9;
   input Name $ (Q1-Q5) ($);
   DATALINES;
Robert  A C A D
William B C A D A
Linda C B  A C
 D D D C A
Katherine A B C D A
RUN;

PROC PRINT data = survey;
   title 'Survey Results';
   var Name Q1-Q5;
RUN;

* Example 20.13. The following program attempts to use 
list input to read the populations of the ten most 
populous cities in the United States into a temporary 
SAS data set called citypops, but the program fails:;

DATA citypops;
   infile DATALINES FIRSTOBS = 2;
   input city pop2000;
   DATALINES;
City  Yr2000Popn
New York  8,008,278
Los Angeles  3,694,820
Chicago  2,896,016
Houston  1,953,631
Philadelphia  1,517,550
Phoenix  1,321,045
San Antonio  1,144,646
San Diego  1,223,400
Dallas  1,188,580
San Jose  894,943
;
RUN;

PROC PRINT data = citypops;
   title 'The citypops data set';
RUN;

* The Ampersand (&) Modifier

Because the ampersand (&) modifier allows us to use list 
input to read character values containing single embedded 
blanks, it is the tool that we will want to use to read in 
the city names.

Example 20.14. The following program uses list input modified 
with an ampersand (&) to read in the city and the population 
values of the ten most populous cities in the United States in 
the year 2000:;

DATA citypops;
   infile DATALINES FIRSTOBS = 2;
   length city $ 12;
   input city & pop2000;
   DATALINES;
City  Yr2000Popn
New York  8008278
Los Angeles  3694820
Chicago  2896016
Houston  1953631
Philadelphia  1517550
Phoenix  1321045
San Antonio  1144646
San Diego  1223400
Dallas  1188580
San Jose  894943
;
RUN;

PROC PRINT data = citypops;
   title 'The citypops data set';
   format pop2000 comma10.;
RUN;

* The Colon (:) Modifier

The colon (:) modifier allows us to use list input to 
read nonstandard data values and character values that 
are longer than eight characters, but which contain no 
embedded blanks. 
The colon (:) indicates that values are read until a 
blank (or other delimiter) is encountered, and then an 
informat is applied. If an informat for reading character 
values is specified, the w value specifies the variable's 
length, overriding the default length of 8.

Example 20.16. The following program uses the colon (:) 
modifier to tell SAS to expect commas when reading in the 
values for the pop2000 variable:;

DATA citypops;
   infile DATALINES FIRSTOBS = 2;
   input city & $12. pop2000 : comma.;
   DATALINES;
City  Yr2000Popn
New York  8,008,278
Los Angeles  3,694,820
Chicago  2,896,016
Houston  1,953,631
Philadelphia  1,517,550
Phoenix  1,321,045
San Antonio  1,144,646
San Diego  1,223,400
Dallas  1,188,580
San Jose  894,943
;
RUN;

PROC PRINT data = citypops;
   title 'The citypops data set';
   format pop2000 comma10.;
RUN;

* 20.5 - Mixing Input Styles;
* Example 20.17. The following program illustrates using 
column input, list input, and formatted input simultaneously 
to read in data concerning five U.S. national parks:;
DATA nationalparks;
   input ParkName $ 1-22 State $ Year @40 Acreage comma9.;
   DATALINES;
Yellowstone           ID/MT/WY 1872    4,065,493
Everglades            FL 1934          1,398,800
Yosemite              CA 1864            760,917
Great Smoky Mountains NC/TN 1926         520,269
Wolf Trap Farm        VA 1966                130
;
RUN;

PROC PRINT data = nationalparks;
   format acreage comma9.;
RUN;
