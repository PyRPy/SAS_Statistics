* 24.4 - Producing Other Types of Output;
* Using ODS Statements to Create RTF Output
Example 24.5. The following program tells SAS to print 
a subset of the penngolf data set and when doing so 
to send the output to an RTF destination:;

ODS LISTING CLOSE;
LIBNAME stat481 'C:\Data_SAS';
ODS RTF file = 'C:\Data_SAS\Output\golf5.rtf'
        BODYTITLE;

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some Par 72 Pennsylvania Golf Courses';
   ID name;
   var year type yards;
   where par = 72;
RUN;

ODS RTF CLOSE;
ODS LISTING;

* Using ODS Statements to Create PDF Output
Example 12.6. The following program does exactly the 
same thing as the previous program, except the output 
here is sent to a PDF file:;

ODS LISTING CLOSE;
ODS PDF file = 'C:\Data_SAS\Output\golf6.pdf';

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some Par 72 Pennsylvania Golf Courses';
   ID name;
   var year type yards;
   where par = 72;
RUN;

ODS PDF CLOSE;
ODS LISTING;

* The ODS TRACE ON statement tells SAS to print information 
in the log about the output objects created by all of the 
code in your program between the ODS TRACE ON statement and a 
closing ODS TRACE OFF statement.

Example 24.7. The following program uses ODS TRACE statements 
to capture information about the output objects created by the 
MEANS procedure on a data set called golfbypar, which is just 
a sorted version of the penngolf data set:;

PROC SORT data = stat481.penngolf out = golfbypar;
  by par;
RUN;

ODS TRACE ON;
PROC MEANS data = golfbypar;
   by par;
   title 'Pennsylvania Golf Courses by Par';
RUN;
ODS TRACE OFF;

* As the log suggests, the MEANS procedure creates one output 
object for each BY group (par = 70, par = 71, and par = 72). 
The three output objects share the same name, label, and template, 
but different paths. The path for the par = 70 output object, 
for example, is called Means.ByGroup1.Summary, while the path 
for the par = 71 output objects is called Means.ByGroup2.Summary. 
Once we know the names of the output objects, we can use an ODS 
SELECT statement to tell SAS the specific output objects that 
we want displayed. To select specific output objects, simply 
place an ODS SELECT statement within the relevant procedure. 
By default, the ODS SELECT statement lasts only for the procedure in 
which it is contained.;

* Example 24.8. The following program uses an ODS SELECT 
statement and what we learned from tracing our MEANS procedure 
to print just the portion of the output that pertains to 
the par 70 golf courses:;

PROC MEANS data = golfbypar;
   by par;
   title 'Par 70 Golf Courses';
   ODS SELECT Means.ByGroup1.Summary;
RUN;

* 24.6 - Changing the Appearance of Your Output;
* Example 24.9. The following program uses the ODS HTML 
statement's STYLE= option to tell SAS to use the meadow 
style when displaying the HTML output created by printing 
a subset of the stat481.penngolf data set:;

ODS HTML file = 'C:\Data_SAS\Output\golf9.html'
                 style = meadow;

PROC PRINT data = stat481.penngolf NOOBS;
   title 'Some of the penngolf data set variables';
   ID name;
   var year type par yards;
RUN;

ODS HTML CLOSE;

* Example 24.10. Of course you are asking yourself 
"how would I know that meadow is one of the available 
predefined styles?" Fortunately, the answer is simple 
enough. The following TEMPLATE procedure produces a 
list of the predefined style templates that are available 
on your system:;

PROC TEMPLATE;
    LIST STYLES;
RUN;

* Example 24.11. The following program uses an ODS OUTPUT 
statement to create a temporary SAS data set called summout 
from the Summary output object created by the MEANS 
procedure, and then prints the resulting summout data set:;

PROC MEANS data = golfbypar;
   by par;
   var yards;
   title 'Pennsylvania Golf Courses by Par';
   ODS OUTPUT Summary = summout;
RUN;

PROC PRINT data = summout NOOBS;
   title 'The summout data set';
RUN;

* You do need to be careful where you put ODS statements 
in your program. For example, if rather than putting the 
ODS OUTPUT statement just before the MEAN procedure's 
RUN statement, we had instead put it after the MEAN 
procedure's RUN statement and before the PRINT procedure's 
PROC PRINT statement, we would not have captured the Summary 
data set. Instead, we would get the following Warning message:;
