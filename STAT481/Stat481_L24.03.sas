* 24.3 - Producing HTML Output; *--- note working ---;
* Creating HTML Output from Multiple Procedures
Example 24.3. The following program uses the penngolf data 
set to simultaneously create HTML output from the PRINT 
and REPORT procedures:;

ODS LISTING CLOSE;
ODS HTML body = 'C:\Data_SAS\Output\golf2.html';

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some Par 72 Pennsylvania Golf Courses';
   ID name;
   var year type yards;
   where par = 72;
RUN;

PROC REPORT data = stat481.penngolf NOWINDOWS HEADLINE HEADSKIP;
   title 'Average Size of Some PA Courses';
   column type par yards;
   define type /group;
   define yards / analysis mean format = 6.1 width = 10;
   define par / analysis mean format = 4.1 width = 10;
RUN;

ODS HTML CLOSE;
ODS LISTING;

* Creating HTML Output with a Table of Contents
Example 24.4. When you have a program that creates many 
pages of output, you might find it useful for SAS to 
create a table of contents for the output. The following 
program is identical to the previous program, except 
the first ODS HTML statement has been modified to tell 
SAS to create a table of contents for the output that 
SAS generates:;

ODS LISTING CLOSE;
ODS HTML body = 'C:\Data_SAS\Output\golf3.html'
         contents = 'C:\Data_SAS\Output\golf3toc.html'
         frame = 'C:\Data_SAS\Output\golf3frame.html';

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some Par 72 Pennsylvania Golf Courses';
   ID name;
   var year type yards;
   where par = 72;
RUN;

PROC REPORT data = stat481.penngolf NOWINDOWS HEADLINE HEADSKIP;
   title 'Average Size of Some PA Courses';
   column type par yards;
   define type /group;
   define yards / analysis mean format = 6.1 width = 10;
   define par / analysis mean format = 4.1 width = 10;
RUN;

ODS HTML CLOSE;
ODS LISTING;

