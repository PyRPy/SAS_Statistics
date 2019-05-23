* 10.2 - Column Attributes;

* Example 10.5. The following SAS program uses the FORMAT= attribute 
to tell SAS to display, when creating a report using the 
stat480.penngolf data set, the Yards variable using the SAS format 
comma5.0:;

PROC REPORT data = stat480.penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year Type Par Yards;
     define Yards / format = comma5.0;
RUN;

* Example 10.6. If a variable in the input data set doesn't have a 
format associated with it, then the default column width in a report 
is set at the variable's length for character variables and 9 for 
numeric variables. The following SAS program illustrates what can 
go wrong with the reports you generate when you allow SAS to use these 
defaults:;

DATA penngolf;
    set stat480.penngolf;
	length CourseType $ 8;
	CourseType =  Type;
	drop Type;
	format Slope 3.;
RUN;

PROC CONTENTS data = penngolf;
RUN;

PROC REPORT data = penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year CourseType Slope Par Yards;
     define Yards / format = comma5.0;
RUN;

* Example 10.7. The following SAS program modifies the REPORT procedure 
of the previous example, so that the width of the CourseType and Slope 
columns are set to 10 and 5, respectively:;

PROC REPORT data = penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year CourseType Slope Par Yards;
	 define Yards / format = comma5.0;
	 define CourseType / width = 10;
	 define Slope / width = 5;
RUN;

* Example 10.8. The following SAS program uses the DEFINE statement's 
SPACING= attribute to tell SAS to place 5 blank spaces before the Yards 
column and 6 blank spaces before the CourseType column:;

PROC REPORT data = penngolf NOWINDOWS HEADLINE;
     title 'Some Pennsylvania Golf Courses';
     column Name Year CourseType Slope Par Yards;
	 define Yards / format = comma5.0 spacing = 5;
	 define CourseType / width = 10 spacing = 6;
	 define Slope / width = 5;
RUN;
