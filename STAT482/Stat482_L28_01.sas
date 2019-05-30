* Lesson 28: T-tests and Nonparametric Comparisons;
***Chapter 6 programs and data;

DATA RESPONSE;
   INPUT GROUP $ TIME;
DATALINES;
C 80
C 93
C 83
C 89
C 98
T 100
T 103
T 104
T 99
T 102
;
PROC TTEST DATA=RESPONSE;
   TITLE 'T-test Example';
   CLASS GROUP;
   VAR TIME;
RUN;

PROC FORMAT;
    VALUE GRPFMT 0='CONTROL' 1='TREATMENT';
RUN;

DATA RANDOM;
   INPUT SUBJ NAME $20.;
   GROUP=RANUNI(0);
DATALINES;
1 CODY
2 SMITH
3 HELM
4 GREGORY
;
PROC RANK DATA=RANDOM GROUPS=2 OUT=SPLIT;
   VAR GROUP;
RUN;

PROC SORT DATA=SPLIT;
   BY NAME;
RUN;

PROC PRINT DATA=SPLIT;
   TITLE 'Subject Group Assignments';
   ID NAME;
   VAR SUBJ GROUP;
   FORMAT GROUP GRPFMT.;
RUN;

DATA TUMOR;
   INPUT GROUP $ MASS @@;
DATALINES;
A 3.1 A 2.2 A 1.7 A 2.7 A 2.5
B 0.0 B 0.0 B 1.0 B 2.3
;

PROC PRINT DATA = TUMOR;
RUN;
PROC NPAR1WAY DATA=TUMOR WILCOXON;
   TITLE 'Nonparametric Test to Compare Tumor Masses';
   CLASS GROUP;
   VAR MASS;
   EXACT WILCOXON;
RUN;                  

DATA PAIRED;
   INPUT CTIME TTIME;
   DIFF = TTIME - CTIME;
DATALINES;
90 95
87 92
100 104
80 89
95 101
90 105
;
PROC MEANS DATA=PAIRED N MEAN STDERR T PRT;
   TITLE 'Paired T-test Example';
   VAR DIFF;
RUN;                           

***Data fro problem 6-1;
          Aspirin        Tylenol
          (Relief time in minutes)
          ----------------------
             40             35
             42             37
             48             42
             35             22
             62             38
             35             29

***Data for problem 6-3;
      Subject      Drug A   Drug B
      ----------------------------
          1         20        18
          2         40        36
          3         30        30
          4         45        46
          5         19        15
          6         27        22
          7         32        29
          8         26        25
