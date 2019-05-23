* 10.1 - Basic List Reports;

* Example 10.1. Throughout this lesson, we'll work with a permanent SAS 
data set called stat480.penngolf that contains information on some 
Pennsylvania golf courses. The following SAS program merely tells SAS 
to print the stat480.penngolf data set:;

OPTIONS PS = 58 LS = 80 NODATE NONUMBER;

LIBNAME stat480 '/folders/myfolders/sasuser.v94/STAT480/Data';

PROC PRINT data = stat480.penngolf;
   title 'Some Pennsylvania Golf Courses';
RUN;
