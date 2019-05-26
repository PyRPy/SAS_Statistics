* Lesson 20: More on Importing Data -- Part I;
* In Stat 480, we learned how to read only the most basic 
data files into a SAS data set. In this lesson 
(and the next), we'll extend our knowledge in this area 
by learning how to read just about any data file into 
SAS — no matter how messy or unstructured the input data 
file. In most cases, the data files will be raw ascii 
data files that are obtained from exporting data from some 
other PC software.;

* Column Input

Because column input allows you to read variable values 
that occupy the same columns within each record, you'll 
often hear it described as "reading fixed-field data." 
As you know, to use column input, we simply list the 
variable names in the INPUT statement, immediately 
following each variable name with its corresponding 
column positions in each of the data lines.

Example 20.1. The following program uses column input 
to read in the values of one character variable (name) 
and four numeric variables (subj, gender, height, and 
weight) into a temporary SAS data set called temp:;

DATA temp;
  input subj 1-4 name $ 6-23 gender 25 height 27-28 weight 30-32;
  CARDS;
1024 Alice Smith        1 65 125
1167 Maryann White      1 68 140
1168 Thomas Jones       2 68 190
1201 Benedictine Arnold 2 68 190
1302 Felicia Ho         1 63 115
  ;
RUN;


PROC PRINT data=temp;
  title 'Output dataset: TEMP';
RUN;

* Formatted Input

The fundamental difference between column input and 
formatted input is that column input is only appropriate 
for reading standard numeric data, while formatted input 
allows us to read both standard and nonstandard numeric 
data. That is, formatted input combines the features of 
column input with the ability to read nonstandard data 
values.

Example 20.2. The following program uses formatted input 
to read two standard numeric variables (subj and height), 
two standard character variables (f_name and l_name) and 
two nonstandard numeric variables (wt_date and calorie) 
into a temporary SAS data set called temp:;

DATA temp;
  input @1  subj 4. 
        @6  f_name $11. 
		@18 l_name $6.
		+3 height 2. 
        +5 wt_date mmddyy8. 
        +1 calorie comma5.;
  format wt_date mmddyy8. calorie comma5.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  ;
RUN;

PROC PRINT data = temp;
  title 'Output dataset: TEMP';
  id subj;
RUN;

* Recall that the @n absolute pointer control tells SAS 
to move the input pointer to a specific column number n. 
For example, the INPUT statement tells SAS to move the 
input pointer to column 18 before starting to read the 
values for the l_name variable. And, recall that the +n 
relative pointer control tells SAS to move the input 
pointer forward n columns to a column number that is 
relative to the current position. For example, the INPUT 
statement tells SAS, after reading the values for the 
l_name variable, to move the input pointer 3 positions 
to the right before starting to read the values for the 
height variable.;

* List Input

If the data values that you are trying to read into a 
SAS data set are not arranged in neatly defined columns, 
but are separated by at least one space and contain no 
special characters, then you must use list input. To use 
list input, you simply place your desired variable names 
in your INPUT statement in the same order that your data 
fields appear in your input data 
file.

Example 20.3. The following program uses list input to 
read in the subject number, name, gender, weight, and 
height of five individuals into a temporary SAS data 
set called temp:;

DATA temp;
  input subj name $ gender height weight;
  CARDS;
  1024 Alice 1 65 125
  1167 Maryann 1 68 140
  1168 Thomas 2 68 190
  1201 Benedictine . 68 190
  1302 Felicia 1 63 115
  ;
RUN;

PROC PRINT data=temp NOOBS;
  title 'Output dataset: TEMP';
RUN;

* 20.2 - Issues with Reading Fixed-Field Data;
* Lengths of Variables

You might recall that the descriptor portion of a data 
set contains information about the attributes of each 
variable in your data sets. The length of each variable 
in your data sets is one such attribute. When you use 
informats to read in some of your data values, it pays 
to know how SAS defines the lengths of your variables 
when it processes your DATA step. Let's make our discussion 
of this concrete by taking a look at an example.

Example 20.4. The following program is identical to 
the program in Example 20.2, except the PRINT procedure 
has been replaced with the CONTENTS procedure so that we 
can explore how SAS defines the lengths of variables:;
DATA temp;
  input @1  subj 4. 
        @6  f_name $11. 
		@18 l_name $6.
		+3 height 2. 
        +5 wt_date mmddyy8. 
        +1 calorie comma5.;
  format wt_date mmddyy8. calorie comma5.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  ;
RUN;

PROC CONTENTS data = temp;
    title 'Contents of TEMP Data Set';
RUN;

* Example 20.5. The following program is similar to the program 
in the previous example, except all of the input pointer controls 
have been changed to @n absolute pointer controls and the numeric 
informat for the height variable has been changed from 2. to 8.:;
DATA temp;
  input @1  subj 4. 
        @6  f_name $11. 
		@18 l_name $6.
		@30 height 8. 
        @34 wt_date mmddyy8. 
        @43 calorie comma5.;
  format wt_date mmddyy8. calorie comma5.;
  DATALINES;
1024 Alice       Smith  1 65 125 12/1/95  2,036
1167 Maryann     White  1 68 140 12/01/95 1,800
1168 Thomas      Jones  2    190 12/2/95  2,302
1201 Benedictine Arnold 2 68 190 11/30/95 2,432
1302 Felicia     Ho     1 63 115 1/1/96   1,972
  ;
RUN;

PROC PRINT data = temp;
    title 'The TEMP Data Set';
RUN;

* In a nutshell, the moral of the story of the two previous 
examples is that you need to make sure that you define the 
widths of your character and numeric informats to be the 
number of columns the data values occupy in the input data, 
not the length of their resulting variables.;

* Reading Variable-Length Records;
* Example 20.6. The following program attempts to read the 
addresses.dat raw data file:;

DATA temp;
   infile 'C:\Data_SAS\addresses.dat';
   input @1 subj 4. name $ 6-23 street $ 27-45;
RUN;

PROC PRINT;
   title 'Temp data set';
RUN;

* Example 20.7. As you now know, by default, SAS goes to the 
next data line to read more data if SAS has reached the end 
of a data line and there are still more variables in the INPUT 
statement that have not been assigned values. The following 
program uses the INFILE statement's MISSOVER option to tell 
SAS not to advance to the next data line to read more values 
to complete an observation, but rather to assign missing values 
to the remaining variables:;
DATA temp;
   infile 'C:\Data_SAS\addresses.dat' MISSOVER;
   input @1 subj 4. name $ 6-23 street $ 27-45;
RUN;

PROC PRINT;
   title 'Temp data set';
RUN;

* Example 20.8. The following program uses the INFILE 
statement's PAD option to tell SAS to pad each record in 
the data file with blanks so that all of the data lines 
have the same length:;


DATA temp;
   infile 'C:\Data_SAS\addresses.dat' PAD;
   input @1 subj 4. name $ 6-23 street $ 27-45;
RUN;

PROC PRINT;
   title 'Temp data set';
RUN;
