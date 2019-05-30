* Lesson 26: Working with Date and Longitudinal Data;
* D. Longitudinal Data;
* Page 130. Unless you really study this program and 
review the contents of the resulting data set, it 
might not be obvious what is going on with the 
structure of the data set. If you launch and run  
the program:;
OPTIONS PS = 58 LS = 72 NODATE NONUMBER; 

DATA HOSP_PATIENTS;
   INPUT #1 
      @1  ID           $3.
      @4  DATE1   MMDDYY8. 
      @12 HR1           3.
      @15 SBP1          3.
      @18 DBP1          3.
      @21 DX1           3.
      @24 DOCFEE1       4.
      @28 LABFEE1       4.
         #2
      @4  DATE2   MMDDYY8. 
      @12 HR2           3.
      @15 SBP2          3.
      @18 DBP2          3.
      @21 DX2           3.
      @24 DOCFEE2       4.
      @28 LABFEE2       4.
         #3
      @4  DATE3   MMDDYY8. 
      @12 HR3           3.
      @15 SBP3          3.
      @18 DBP3          3.
      @21 DX3           3.
      @24 DOCFEE3       4.
      @28 LABFEE3       4.
         #4
      @4  DATE4   MMDDYY8. 
      @12 HR4           3.
      @15 SBP4          3.
      @18 DBP4          3.
      @21 DX4           3.
      @24 DOCFEE4       4.
      @28 LABFEE4       4.;
   FORMAT DATE1-DATE4 MMDDYY10.;
DATALINES;
0071021198307012008001400400150
0071201198307213009002000500200
007
007
0090903198306611007013700300000
009
009
009
0050705198307414008201300900000
0050115198208018009601402001500
0050618198207017008401400800400
0050703198306414008401400800200
;
RUN;

PROC PRINT data = HOSP_PATIENTS;
RUN;

* G. Computing the Difference Between the First and Last 
Observation for each Subject;

DATA PATIENTS;
   INPUT @1  ID          $3.
         @4  DATE   MMDDYY8. 
         @12 HR           3.
         @15 SBP          3.
         @18 DBP          3.
         @21 DX           3.
         @24 DOCFEE       4.
         @28 LABFEE       4.;
   FORMAT DATE MMDDYY10.;
DATALINES;
0071021198307012008001400400150
0071201198307213009002000500200
0090903198306611007013700300000
0050705198307414008201300900000
0050115198208018009601402001500
0050618198207017008401400800400
0050703198306414008401400800200
;
RUN;

PROC SORT DATA=PATIENTS;
   BY ID DATE;
RUN;

DATA FIRST_LAST;
   SET PATIENTS;
   BY ID;
   ***Data set PATIENTS is sorted by ID and DATE;
   RETAIN FIRST_HR FIRST_SBP FIRST_DBP;
   ***Omit patients with only one visit;
   IF FIRST.ID AND LAST.ID THEN DELETE;
   ***If it is the first visit assign values to the
      retained variables;
   IF FIRST.ID THEN DO;
      FIRST_HR = HR;
      FIRST_SBP = SBP;
      FIRST_DBP = DBP;
   END;
   IF LAST.ID THEN DO;
      D_HR = HR - FIRST_HR;
      D_SBP = SBP - FIRST_SBP;
      D_DBP = DBP - FIRST_DBP;
      OUTPUT;
   END;
RUN;

PROC PRINT DATA= FIRST_LAST NOOBS;
   title 'The first approach';
RUN;

*******Page 140. The authors should have left well enough 
alone as their second program doesn't produce the correct 
differences! Their error is a simple typo, though, that is 
easy to correct. The assignment statement for D_DBP:;


DATA PATIENTS;
   INPUT @1  ID          $3.
         @4  DATE   MMDDYY8. 
         @12 HR           3.
         @15 SBP          3.
         @18 DBP          3.
         @21 DX           3.
         @24 DOCFEE       4.
         @28 LABFEE       4.;
   FORMAT DATE MMDDYY10.;
DATALINES;
0071021198307012008001400400150
0071201198307213009002000500200
0090903198306611007013700300000
0050705198307414008201300900000
0050115198208018009601402001500
0050618198207017008401400800400
0050703198306414008401400800200
;
RUN;

PROC SORT DATA=PATIENTS;
   BY ID DATE;
RUN;

DATA FIRST_LAST2;
   SET PATIENTS;
   BY ID;
   ***Data set PATIENTS is sorted by ID and DATE;
   ***Omit patients with only one visit;
   IF FIRST.ID AND LAST.ID THEN DELETE; 
   ***If it is the first or last visit execute the LAG
      function;
   IF FIRST.ID OR LAST.ID THEN DO;
      D_HR = HR - LAG(HR);
      D_SBP = SBP - LAG(SBP);
      D_DBP = DBP - LAG(DBP);
   END;
   IF LAST.ID THEN OUTPUT;
RUN;

PROC PRINT DATA = FIRST_LAST2 NOOBS;
    title 'The second approach';
RUN;

