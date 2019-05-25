* 15.3 - Concatenating Two or More Data Sets;
* Example 15.6. The following program concatenates 
the store1 and store2 data sets to create a new "tall" 
data set called bothstores:;

DATA store1;
    input Store Day $ Sales;
	DATALINES;
	1 M 1200
	1 T 1435
	1 W 1712
	1 R 1529
	1 F 1920
	1 S 2325
	;
RUN;

DATA store2;
    input Store Day $ Sales;
	DATALINES;
	2 M 2215
	2 T 2458
	2 W 1798
	2 R 1692
	2 F 2105
	2 S 2847
	;
RUN;

DATA bothstores;
    set store1 store2;
RUN;

PROC PRINT data = bothstores NOOBS;
    title 'The bothstores data set';
RUN;

* Example 15.7. The following program concatenates 
the one and two data sets to create a new "tall" 
data set called onetopstwo:;

DATA one;
    input ID VarA $ VarB $;
	DATALINES;
	10 A1 B1
	20 A2 B2
	30 A3 B3
  ;
RUN;

DATA two;
   input ID VarB $ VarC $;
   DATALINES;
   40 B4 C1
   50 B5 C2
   ;
RUN;

DATA onetopstwo;
   set one two;
RUN;

PROC PRINT data = onetopstwo NOOBS;
   title 'The onetopstwo data set';
RUN;

* Example 15.8. If a variable is defined as numeric 
in one data set named in the SET statement and as 
character in another data set, SAS issues an error 
message and will not concatenate the data sets. 
The following program attempts to concatenate the 
store3 and store4 data sets, when the Store variable 
is defined as character in the store3 data set, but 
as numeric in the store4 data set:;

DATA store3;
    input Store $ 1 Day $ 3 Sales 5-8;
	DATALINES;
1 M 1200
1 T 1435
1 W 1712
1 R 1529
1 F 1920
1 S 2325
	;
RUN;

DATA store4;
    input Store 1 Day $ 3 Sales 5-8;
	DATALINES;
2 M 2215
2 T 2458
2 W 1798
2 R 1692
2 F 2105
2 S 2847
	;
RUN;

DATA bothstores2;
    set store3 store4;
RUN;

PROC PRINT data = bothstores2 NOOBS;
    title 'The bothstores2 data set';
RUN;

* NOTE In order to concatenate the store3 and store4 
data sets successfully, we need to change either the 
Store character variable in the store3 data set to 
numeric or the Store numeric variable in the store4 
data set to character. As you know from our work in 
Stat 480, to perform an explicit character-to-numeric 
conversion of the Store variable in the store3 data 
set, we'd have to use the INPUT function. Alternatively, 
we could use the PUT function to perform an explicit 
numeric-to-character conversion of the Store variable 
in the store4 data set. That's what the following 
DATA step does:;

DATA store4 (rename = (Store2 = Store));
    set store4;
	Store2 = put(Store,1.);
	drop Store;
RUN;

PROC CONTENTS data = store3;
   title 'Contents of store3';
RUN;

PROC CONTENTS data = store4;
   title 'Contents of store4';
RUN;

* Now that we've seen both the PUT function and INPUT 
function in action, it pays to summarize:

To perform an explicit numeric-to-character conversion, 
use the PUT(source, format) with a numeric source and a 
numeric format.
To perform an explicit character-to-numeric conversion, 
use the INPUT(source, informat) function with a 
character source and a numeric informat.
To remember which function requires a format versus an 
informat, note that the INPUT function requires and 
informat.

Ahhh... but back to the task on hand. Finally, the 
following program allows us to accomplish our original 
goal of concatenating the store3 and store4 data sets:;

DATA bothstores2;
    set store3 store4;
RUN;

PROC PRINT data = bothstores2 NOOBS;
    title 'The bothstores2 data set';
RUN;

* Example 15.9. The following program creates two 
data sets store5 and store6 that intentionally 
contain different labels and different formats for 
the Sales variable:;

DATA store5;
    input Store 1 Day $ 3 Sales 5-8;
	format Sales comma5.;
	label Sales = 'Total Sales';
	DATALINES;
1 M 1200
1 T 1435
1 W 1712
1 R 1529
1 F 1920
1 S 2325
	;
RUN;
DATA store6;
    input Store 1 Day $ 3 Sales 5-8;
	format Sales dollar6.;
	label Sales = 'Sales for Day';
	DATALINES;
2 M 2215
2 T 2458
2 W 1798
2 R 1692
2 F 2105
2 S 2847
	;
RUN;
PROC CONTENTS data = store5;
   title 'Contents of the store5 data set';
RUN;
PROC CONTENTS data = store6;
   title 'Contents of the store6 data set';
RUN;

* Now, the following program tells SAS to store 
first the observations from the store5 data set, 
followed by the observations from the store6 data 
set, into a new data set called bothstores3:;

DATA bothstores3;
    set store5 store6;
RUN;

PROC PRINT data = bothstores3 NOOBS LABEL;
    title 'The bothstores3 data set';
RUN;

* The following program reverses the order of the 
concatenation of the store5 and store6 data sets. 
That is, the program tells SAS to store first 
the observations from the store6 data set, followed 
by the observations from the store5 data set, into 
a new data set called bothstores4:;

DATA bothstores4;
    set store6 store5;
RUN;

PROC PRINT data = bothstores4 NOOBS LABEL;
    title 'The bothstores4 data set';
RUN;

* Example 15.10. The following program creates 
two data sets store7 and store8 that 
intentionally contain different lengths for the 
numeric variable Store and the character 
variable Day:;

DATA store7;
    length Store 4;
    input Store 1 Day $ 3-5 Sales 7-10;
	DATALINES;
1 Mon 1200
1 Tue 1435
1 Wed 1712
1 Thu 1529
1 Fri 1920
1 Sat 2325
	;
RUN;
DATA store8;
    input Store 1 Day $ 3 Sales 5-8;
	DATALINES;
2 M 2215
2 T 2458
2 W 1798
2 R 1692
2 F 2105
2 S 2847
	;
RUN;
PROC CONTENTS data = store7;
   title 'Contents of the store7 data set';
RUN;
PROC CONTENTS data = store8;
   title 'Contents of the store8 data set';
RUN;

* Now, the following program tells SAS to store 
first the observations from the store7 data set, 
followed by the observations from the store8 
data set, into a new data set called bothstores5:;

DATA bothstores5;
    set store7 store8;
RUN;

PROC PRINT data = bothstores5 NOOBS LABEL;
    title 'The bothstores5 data set';
RUN;

PROC CONTENTS data = bothstores5;
    title 'Contents of the bothstores5 data set';
RUN;

* The following program reverses the order of the 
concatenation of the store7 and store8 data sets. 
That is, the program tells SAS to store first the 
observations from the store8 data set, followed by 
the observations from the store7 data set, into a 
new data set called bothstores6:;

DATA bothstores6;
    set store8 store7;
RUN;

PROC PRINT data = bothstores6 NOOBS LABEL;
    title 'The bothstores6 data set';
RUN;

PROC CONTENTS data = bothstores6;
    title 'Contents of the bothstores6 data set';
RUN;

