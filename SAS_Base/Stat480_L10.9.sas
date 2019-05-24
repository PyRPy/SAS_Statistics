* 10.3 - Column Headings and Justification;
* Example 10.9. The following program uses the DEFINE 
statement to set the headings for the Yards and Type 
variables, respectively, as Total Yardage and Type 
of Course:;

*LIBNAME stat480 '/DataAnalysis_H/Examples_SAS/STAT480/Data';
LIBNAME stat480 'C:\Data_SAS';

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year Type Par Yards;
	 define Yards / format = comma5.0 'Total Yardage' 
                    width = 7 spacing = 4;
	 define Type / 'Type of Course' spacing = 6;
RUN;


* Example 10.10. The following program uses the default forward 
slash as a split character for the defined column labels of the 
Yards and Type variables:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year Type Par Yards;
	 define Yards / format = comma5.0 'Total/Yardage' 
                    width = 7 spacing = 4;
	 define Type / 'Type of/Course' spacing = 6 width = 8;
RUN;

* Example 10.11. The following program uses the DEFINE 
statement's CENTER option to center the Yards and Type 
columns in the requested report:;


PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year Type Par Yards;
	 define Yards / format = comma5.0 'Total/Yardage' 
                    width = 7 spacing = 4 center;
	 define Type / 'Type of/Course' spacing = 6 
                    width = 8 center;
RUN;

* 10.4 - Using Order Variables;
* Example 10.12. Among other things, the DEFINE statements 
in the following REPORT procedure defines the Yards and 
Par variables as being ORDER variables:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Par Name Year Type Yards;
	 define Yards / order format = comma5.0 'Total/Yardage' 
                    width = 7 spacing = 4 center;
	 define Type / 'Type of/Course' spacing = 6 
                    width = 8 center;
	 define Par / order;
RUN;

* Example 10.13. The following program tells SAS, when 
creating the requested report, to display the rows in 
descending order of the Par variable and in ascending 
order of the Yards variable:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Par Name Year Type Yards;
	 define Yards / order format = comma5.0 'Total/Yardage' 
                    width = 7 spacing = 4 center;
	 define Type / 'Type of/Course' spacing = 6 
                    width = 8 center;
	 define Par / order descending;
RUN;

* 10.5 - Using Group Variables;

* Example 10.14. Among other things, the DEFINE statements 
in the following REPORT procedure defines the Type variable 
as a group variable in order to create the summary report 
as illustrated above:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Type Par Yards;
	 define Type / group 'Type of/Course' spacing = 6 
                    width = 8 center;
	 define Par / analysis 'Total/Par';
	 define Yards / analysis format = comma6.0 'Total/Yardage' 
                    width = 7 spacing = 4 center;
RUN;

* 10.6 - Specifying Statistics;
* Example 10.15. The following REPORT procedure creates 
a report in which the average par and average yardage is 
reported for each of the four types of golf courses:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Average Size of Some PA Golf Courses by Type';
     column Type Par Yards;
	 define Type / group 'Type of/Course' spacing = 6 
                    width = 8;
	 define Par /  mean format= 4.1 
                   'Average/Par' width = 7 center;
	 define Yards /  mean format = comma6.0 'Average/Yardage' 
                    width = 7 spacing = 4 center;
RUN;

* Example 10.16. The following example illustrates the type 
of one-line report you get when the columns of your report 
contain only (numeric) analysis variables:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Size of Some PA Golf Courses';
     column Par Yards;
	 define Par /  mean format= 4.1 
                   'Average/Par' width = 7 center;
	 define Yards / format = comma7.0 'Total/Yardage' 
                    width = 7 spacing = 4 center;
RUN;

* 10.7 - Using Across Variables;
* Example 10.17. The following program is nearly identical 
to the program in Example 10.14 which concerned the illustration 
of the use of a group variable. The only difference between 
the two programs is that the group keyword in the DEFINE 
statement for the Type variable has been replaced here with 
the across keyword:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Type Par Yards;
	 define Type / across 'Type of/Course' spacing = 6 
                    width = 8 center;
	 define Par / analysis 'Total/Par';
	 define Yards / analysis format = comma6.0 'Total/Yardage' 
                    width = 7 spacing = 4 center;
RUN;

* 10.8 - Using Computed Variables;
* Example 10.18. The following REPORT procedure uses the 
Slope and USGA scores to compute a Bogey rating for each 
golf course that appears in the stat480.penngolf data set:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Slope USGA Bogey;
	 define Bogey / computed 'Bogey/Rating' format = 7.3;
	 define USGA / format = 4.1 spacing = 5;
	 compute Bogey;
	   Bogey = 0.186*Slope.sum + USGA.sum;
	 endcomp;
RUN;

/* common stat functions
Statistic	Description
CSS	corrected sum of squares
USS	uncorrected sum of squares
CV	coefficient of variation
MAX	maximum value
MEAN	average value
MIN	minimum value
N	number of observations with nonmissing values
NMISS	number of observations with missing values
RANGE	range of values
STD	standard deviation
STDERR	standard error of the mean
SUM	sum of the values
SUMWGT	sum of the weight variable values
PCTN	percentage of cell or row frequency to total frequency
PCTSUM	percentage of cell or row sum to total sum
VAR	variance of the values
T	student's t-statistic for testing population mean is 0
PRT	probability of a greater absolute value of student's t
*/
