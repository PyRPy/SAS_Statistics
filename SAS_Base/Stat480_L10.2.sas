* Example 10.2. The following SAS program creates a basic list report 
of the entire permanent SAS data set called stat480.penngolf:;

LIBNAME stat480 '/folders/myfolders/sasuser.v94/STAT480/Data';

PROC REPORT data = stat480.penngolf NOWINDOWS;
   title 'Some Pennsylvania Golf Courses';
RUN;

* Example 10.3. Rather than telling SAS to display the entire 
stat480.penngolf data set, the following SAS program uses the COLUMN 
statement to tell SAS to display just five of the columns Name, 
Year, Type, Par and Yards in the order specified:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year Type Par Yards;
RUN;

* Example 10.4. Again, rather than telling SAS to display the entire 
stat480.penngolf data set, the following SAS program uses:
    -the COLUMN statement to tell SAS to display just five of the 
    columns Name, Year, Type, Par and Yards in the order 
    specified, and
    -the WHERE statement to tell SAS to display only those golf 
    courses whose Type equals Private or Resort.;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADSKIP;
     title 'Some Pennsylvania Golf Courses';
     column Name Year Type Par Yards;
     where Type in ('Private', 'Resort');
RUN;


