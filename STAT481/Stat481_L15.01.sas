* 15.1 - One-to-One Reading;
* Example 15.1. The following program uses one-to-one 
reading to combine the patients data set with the 
scale data set:;

DATA patients;
    input ID Sex $ Age;
	DATALINES;
 1157    F     33
 2395    F     48
 1098    M     39
 4829    F     24
 3456    M     30
 5920    M     41
 1493    F     42
 ;
 RUN;
 DATA scale;
     input ID Height Weight;
	 DATALINES;
 1157    65     122
 2395    64     130
 1098    70     178
 4829    67     142
 3456    72     190
 5920    71     188
 ;
 RUN;

 DATA one2oneread;
    set patients;
	set scale;
 RUN;

 PROC PRINT NOOBS;
    title 'The one2oneread data set';
 RUN;
 * NOTE The DATA step stops after it reads the last 
 observation from the smallest data set. Therefore, 
 the number of observations in the new data set 
 always equals the numbers of observations in the 
 smallest data set you name for one-to-one reading.;

 
 * Example 15.2. The following program uses one-to-one 
 reading to combine the patients data set with the 
 scale data set in the reverse order from that of 
 the previous program:;
 
 DATA one2oneread2;
    set scale;
	set patients;
 RUN;

 PROC PRINT NOOBS;
    title 'The one2oneread2 data set';
 RUN;
 
 * Example 15.3. The following program uses one-to-one 
 reading to combine the one data set with the two data 
 set to create a new data set called onetwo:;
 
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

DATA onetwo;
   set one;
   set two;
RUN;

PROC PRINT data = onetwo NOOBS;
   title 'The onetwo data set';
RUN;

* 15.2 - One-to-One Merging;
* Example 15.4. The following program uses one-to-one 
merging to combine the patients data set with the 
scale data set:;

DATA one2onemerge;
    merge patients scale;
RUN;

PROC PRINT NOOBS;
    title 'The one2onemerge data set';
RUN;
* NOTE When SAS performs a one-to-one merge, the DATA 
step continues to read observations until the last 
observation is read from the largest data set.;
 
* Example 15.5. The following program uses one-to-one 
merging to combine the one data set with the two data 
set to create a new data set called onetwomerged:;
 
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

DATA onetwomerged;
   merge one two;
RUN;

PROC PRINT data = onetwomerged NOOBS;
   title 'The onetwomerged data set';
RUN;
* NOTE  It's for this reason that I personally don't 
find the one-to-one read or the one-to-one merge all 
that practical. The more useful and therefore much 
more common merge performed in SAS is what is called 
match-merging. ;
