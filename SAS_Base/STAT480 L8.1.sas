* Lesson 8: Writing Programs That Work - Part II;
* 8.1 - Missing Semicolons;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

*Read in the trees data set
DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* Example 8.2. This example shows the same program as above, but now 
the semicolon is missing at the end of the DATA statement:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

*Read in the trees data set;
DATA trees
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* Example 8.3. The next example shows the same program as above, in 
which the semicolon is missing at the end of the DATA statement. 
However, now the DATASTMTCHK system option has been added to the code:;

OPTIONS DATASTMTCHK = ALLKEYWORDS;

*Read in the trees data set;
DATA trees
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* 8.2 - Invalid Options, Names, or Statements;
* Example 8.4. The following example illustrates the "Error: Invalid option" 
message SAS displays in the log window when you attempt to use an option 
that is invalid:;

DATA trees (ROP = crown_ft);
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* Example 8.5. The following example illustrates the "Error: Syntax error" 
message SAS displays in the log window when your input statement is 
incorrect:;
DATA trees;
    input *type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* Example 8.6. The following example illustrates the "Error: Statement 
is not valid or it is used out of proper order" message SAS displays 
in the log window when you attempt to use a statement that is not valid:;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT;
     set type circ_in hght_ft;
RUN;

* 8.3 - Missing Quotation Marks;
* Example 8.7. As should be fairly obvious by the coloration of the code, 
the following program is missing a closing quotation mark in the PRINT 
procedure's first TITLE statement:;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT;
     var type circ_in hght_ft;
	 title 'Some trees in Kentucky'
	 title2 'Division of Forestry';
RUN;

* 8.4 - Invalid Data;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	DATALINES;
oak, black        222 1O5 112
hemlock, eastern  149 138  52
ash, white        258  8O  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT data = trees;
    title 'Trees in Kentucky';
RUN;

* That's because the "105" and "80" actually contain the letter O rather 
than the number 0.;

* 8.5 - Variable Not Found;
OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght)*(0.0000163*circ_in**2);
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT data = trees;
    var type height circ_in volume;
run;

* 8.6 - Input Reached Past the End of the Line;
* Example 8.10. The following example shows what can happen if you 
are using list input, and your data file doesn't contain periods 
as placeholders for numeric missing values:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    input treeID circ_in hght_ft crown_ft;
	DATALINES;
101 222 105 112
102 149 138 
103 258  80  70
104 187  91  
105 210  99  74
106 229 127 104
;
RUN;

PROC PRINT data = trees;
    title 'Tree data';
RUN;

* Example 8.11. One way of solving the problem of SAS going to the next 
line to look for the missing data values is to insert missing value 
periods (.) as placeholders. That solution would work for this small 
data set, but it wouldn't work when you are working with a large data 
set with thousands of records. In that case, the simplest thing to do 
to prevent SAS from going to a new line looking for data is to use the 
MISSOVER option of the INFILE statement. The MISSOVER option tells SAS 
to assign missing values to any variables for which there were no data 
instead of proceeding to the next line looking for the values. The 
following example illustrates using the MISSOVER option:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    INFILE DATALINES MISSOVER;
    input treeID circ_in hght_ft crown_ft;
	DATALINES;
101 222 105 112
102 149 138 
103 258  80  70
104 187  91  
105 210  99  74
106 229 127 104
;
RUN;

PROC PRINT data = trees;
    title 'Tree data';
RUN;

* 8.7 - Missing Values Generated;
* Example 8.12. The following example illustrates how SAS propagates 
missing values. That is, for some calculations, SAS assigns a variable 
a missing value if any of the values contributing to the calculation 
are missing. In this example, SAS generates missing values when 
attempting to calculate the volume of the tree when either the height 
or the circumference is missing:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght_ft)*(0.0000163*circ_in**2);
	DATALINES;
oak, black        222   . 112
hemlock, eastern  .   138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT data = trees;
    title 'Tree data';
RUN;


* Example 8.13. When you are working with a large data set, it can 
be difficult to locate all the places in which a missing value was 
generated based on a calculation. In that case, you'll probably want 
to use a selecting IF statement to find the missing values. The 
following example illustrates using an IF statement to find the 
observations that are assigned a missing value for the newly 
calculated variable volume:;


OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght_ft)*(0.0000163*circ_in**2);
	if volume = .;
	DATALINES;
oak, black        222   . 112
hemlock, eastern  .   138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT data = trees;
    title 'Trees with Missing Volumes';
RUN;




























