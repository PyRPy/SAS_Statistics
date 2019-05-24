* 11.1 - The MEANS and SUMMARY Procedures;

* Example 11.2. The MEANS procedure can include many 
statements and options for specifying the desired 
statistics. For the sake of simplicity, we'll start 
out with the most basic form of the MEANS procedure. 
The following program simply tells SAS to display 
basic summary statistics for each numeric variable 
in the icdb.hem2 data set:;

PROC MEANS data = icdb.hem2;
RUN;

* Example 11.3. The following program uses the MEANS 
procedure's VAR statement to restrict SAS to summarizing 
just the seven blood data variables in the icdb.hem2 data set:;

PROC MEANS data = icdb.hem2;
   var wbc rbc hemog hcrit mcv mch mchc;
RUN;

* Example 11.4. The following program uses the MEANS 
procedure's MAXDEC = option to set the maximum number 
of decimal places displayed to 2, and the FW= option 
to set the maximum field width printed to 10:;

PROC MEANS data = icdb.hem2 MAXDEC = 2 FW = 10;
   var wbc rbc hemog hcrit mcv mch mchc;
RUN;

* Example 11.5. The following program is identical to 
the program in the previous example except for two things: 
(1) The MEANS keyword has been replaced with the SUMMARY keyword, 
and (2) the PRINT option has been added to the PROC statement:;

PROC SUMMARY data = icdb.hem2 MAXDEC = 2 FW = 10 PRINT;
   var wbc rbc hemog hcrit mcv mch mchc;
RUN;

* Example 11.6. The following program tells SAS to 
calculate and display the sum, range and median of 
the red blood cell counts appearing in the icdb.hem2 
data set:;

PROC MEANS data=icdb.hem2 fw=10 maxdec=2 sum range median;
    var rbc;
RUN;
/*
Descriptive Statistics

Keyword	Description
CLM	Two-sided confidence limit for the mean
CSS	Corrected sum of squares
CV	Coefficient of variation
KURT	Kurtosis
LCLM	One-sided confidence limit below the mean
MAX	Maximum value
MEAN	Average value
MIN	Minimum value
N	No. of observations with non-missing values
NMISS	No. of observations with missing values
RANGE	Range
SKEW	Skewness
STD	Standard deviation
STDERR	Standard error of the mean
SUM	Sum
SUMWGT	Sum of the Weight variable values
UCLM	One-sided confidence limit above the mean
USS	Uncorrected sum of squares
VAR	Variance
Quantile Statistics

Keyword	Description
MEDIAN or P50	Median or 50th percentile
P1	1st percentile
P5	5th percentile
P10	10th percentile
Q1 or P25	Lower quartile or 25th percentile
Q3 or P75	Upper quartile or 75th percentile
P90	90th percentile
P95	95th percentile
P99	99th percentile
QRANGE	Difference between upper and lower quartiles: Q3-Q1
Hypothesis Testing

Keyword	Description
PROBT	Probability of a greater absolute value for the t value
T	Student's t for testing that the population mean is 0
*/

* 11.3 - Group Processing;

* Example 11.7. The following program uses the VAR and 
CLASS statements to tell SAS to calculate the default 
summary statistics of the rbc, wbc, and hcrit variables 
separately for each of the nine hosp values:;

PROC MEANS data=icdb.hem2 fw=10 maxdec=2;
    var rbc wbc hcrit;
	class hosp;
RUN;

* Example 11.8. The following program reads some data on 
national parks into a temporary SAS data set called parks, 
and then uses the MEANS procedure's VAR and CLASS statements 
to tell SAS to sum the number of musems and camping 
facilities for each combination of the Type and Region 
variables:;

DATA parks;
     input ParkName $ 1-21 Type $ Region $ Museums Camping;
     DATALINES;
Dinosaur              NM West 2  6
Ellis Island          NM East 1  0
Everglades            NP East 5  2
Grand Canyon          NP West 5  3
Great Smoky Mountains NP East 3 10
Hawaii Volcanoes      NP West 2  2
Lava Beds             NM West 1  1
Statue of Liberty     NM East 1  0
Theodore Roosevelt    NP West 2  2
Yellowstone           NP West 9 11
Yosemite              NP West 2 13
	 ;
RUN;

PROC MEANS data = parks fw = 10 maxdec = 0 sum;
   var museums camping;
   class type region;
RUN;

* Example 11.9. Like the CLASS statement, the BY 
statement specifies variables to use for categorizing 
observations. The following program uses the MEANS 
procedure's BY statement to categorize the observations 
in the parks data set into four subgroups, as determined 
by the Type and Region variables, before calculating the 
sum, minimum and maximum of the museums and camping 
values for each of the subgroups:;

PROC SORT data = parks out = srtdparks;
   by type region;
RUN;

PROC MEANS data = srtdparks fw = 10 maxdec = 0 sum min max;
   var museums camping;
   by type region;
RUN;

* NOTES: If you prefer to see your summary statistics in one 
large table, then you should use the CLASS statement. 
If you instead prefer to see your summary statistics in 
a bunch of smaller tables, then you should use the BY 
statement.;


