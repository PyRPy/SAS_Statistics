* 15.4 - Interleaving SAS data sets;
* To interleave, you specify the data sets you want 
interleaved in the SET statement, and indicate on 
which variable you want the final data set sorted 
in the BY statement. You may interleave as many 
data sets as you'd like. The resulting data set 
contains all of the variables and all of the 
observations from all of the input data sets.

Example 15.11. The following program interleaves 
the one and two data sets by year:;

DATA one;
   input year x;
   DATALINES;
   2000 1
   2001 2
   2002 3
   2003 4
   ;
RUN;

DATA two;
   input year x;
   DATALINES;
   2001 5
   2002 6
   2003 7
   2004 8
   ;
RUN;

DATA three;
    set one two;
	by year;
RUN;

PROC PRINT data = three NOOBS;
   title 'The interleaved three data set';
RUN;

* The first two DATA steps, of course, just tell 
SAS to read the data values into the one and two 
data sets. The third, and most relevant DATA step 
to this topic, contains both a SET statement and 
a BY statement. That tells SAS that we want to 
interleave the data sets appearing in the SET 
statement (one and two) by the variable appearing 
in the BY statement (year) and to store the result 
in a data set called three. Launch and run  the 
SAS program. Review the output from the PRINT 
procedure to convince yourself that the three data 
set contains the contents of the one and two data 
sets sorted by year.;

* Example 15.12. As you may have noticed, interleaving 
is equivalent to the two-step process of concatenating 
two or more data sets and then sorting them. The following 
program illustrates this point by using the two-step process 
to create a data set four that is identical to the data 
set three:;

DATA unsortedfour;
    set one two;
RUN;

PROC PRINT data = unsortedfour NOOBS;
   title 'The unsortedfour data set';
RUN;

PROC SORT data = unsortedfour out = four;
   by year;
RUN;

PROC PRINT data = four NOOBS;
   title 'The four data set';
RUN;

* 15.5 - Data Step Options;
* Example 15.13. The following program attempts to 
one-to-one merge two data sets firstnames and lastnames. 
The firstnames data set contains a variable called 
name that contains the first names of five individuals, 
and the lastnames data set also contains a variable 
called name that contains the last names of four 
individuals:;

DATA firstnames;
    input subj 5-9 name $ 10-16 gender 19 
          height 21-22 weight 24-26;
   datalines;
    1024 Alice    1 65 125
    1167 Maryann  1 68 140
    1168 Thomas   2 68 190
    1201 Benny    2 68 190
    1302 Felicia  1 63 115
  ;
 RUN;

 DATA lastnames;
   input name $ 4-9 sysbp 11-13 diasbp 14-15;
   datalines;
   Smith  120 80
   White  130 90
   Jones  125 72
   Arnold 135 95
 ;
 RUN;

 DATA alldata;
   merge firstnames lastnames;
 RUN;

 PROC PRINT data=alldata NOOBS;
   title 'The alldata data set';
 RUN;
 
 * In order to merge the firstnames and lastnames 
 data sets correctly, we must first change the name 
 of the variable name to something different in 
 one of the two data sets. We'll change the name 
 in both data sets. The following program illustrates 
 changing the variable name to f_name in the firstnames 
 data set and to l_name in the lastnames data set, 
 while simultaneously merging firstnames and 
 lastnames in a one-to-one manner:;
 
DATA alldata2;
   merge firstnames (rename = (name=f_name))
         lastnames  (rename = (name=l_name));
 RUN;

 PROC PRINT data=alldata2 NOOBS;
   title 'The alldata2 data set';
 RUN;
