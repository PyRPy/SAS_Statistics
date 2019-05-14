PROC CONTENTS data = sashelp._ALL_ nods;
RUN;

PROC CONTENTS data = sashelp.class;
RUN;

PROC CONTENTS data = sashelp.deskact varnum;
RUN;

* E3.4;
DATA temp;
  input subj name $ gender height weight;  
  * The $ that follows name tells SAS that it is 
       a character variable;
  * By default, name only allows up to 8 characters
       to be read in;
  CARDS;
  1024 Alice 1 65 125
  1167 Maryann 1 68 140
  1168 Thomas 2 68 190
  1201 Benny 2 72 190
  1302 Felicia 1 63 115
  ;
RUN;

PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;

* E3.5;
* Example 3.5. The following SAS program illustrates the necessary 
use of the missing value (.) placeholder when a data value is missing;

DATA temp;
  input subj name $ gender height weight;
  CARDS;
  1024 Alice 1 65 125
  1167 Maryann 1 68 140
  1168 Thomas 2 68 190
  1201 Benny 2 . 190
  1302 Felicia 1 63 115
  ;
RUN;

PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;


* Example 3.6. The following SAS program illustrates how a character variable is, by default, 
truncated if it contains more than 8 characters. 
The name 'Benedictine' is saved in the variable name as 'Benedict'.;

DATA temp;
  input subj name $ gender height weight;
  CARDS;
  1024 Alice 1 65 125
  1167 Maryann 1 68 140
  1168 Thomas 2 68 190
  1201 Benedictine 2 68 190
  1302 Felicia 1 63 115
  ;
RUN;

PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;

* Example 3.7. The following SAS program illustrates how you can use the 
DELIMITER option of the INFILE statement to use values separators other than blanks. 
This example, in particular, illustrates it for the commonly used comma (,) 
as a delimiter:;

DATA temp;
  infile datalines delimiter=',';
  input subj name $ gender height weight;
  datalines;
  1024,Alice,1,65,125
  1167,Maryann,1,68,140
  1168,Thomas,2,68,190
  1201,Benny,2,.,190
  1302,Felicia,1,63,115
  ;
RUN;

PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;

