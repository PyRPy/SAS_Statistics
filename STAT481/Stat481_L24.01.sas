* Lesson 24: The Output Delivery System; * --- not working ---;
* 24.1 - How ODS Works;
* 24.2 - Opening and Closing ODS Destinations;
* Example 24.1. You might recall that the SAS data set 
called penngolf contains information, such as the total 
yardage and par, of eleven golf courses in Pennsylvania. 
The following program opens the HTML destination so that 
a subset of the penngolf data set can be printed in HTML 
format as well as the default Listing format:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;
LIBNAME stat481 'C:\Data_SAS';

ODS HTML file = 'C:\Data_SAS\Output\golf.html';

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some of the penngolf data set variables';
   ID name;
   var year type par yards;
RUN;

ODS HTML CLOSE;


* Example 24.2. The following program is identical to the 
previous program, except here the Listing destination is 
closed at the beginning of the program, and re-opened 
again at the end:;
ODS LISTING CLOSE;
ODS HTML file = 'C:\Data_SAS\Output\golf.html';

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some of the penngolf data set variables';
   ID name;
   var year type par yards;
RUN;

ODS HTML CLOSE;
ODS LISTING;


