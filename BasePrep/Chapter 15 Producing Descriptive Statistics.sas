/* Chapter 15: Producing Descriptive Statistics */
/* The MEANS Procedure */
* Example: Default PROC MEANS Output;
proc means data=cert.survey; 
run;

*Example: Specifying Statistic Keywords;
proc means data=cert.survey median range; 
run;

* Limiting Decimal Places with MAXDEC= Option;
proc means data=cert.diabetes min max maxdec=0; 
run;

* Specifying Variables Using the VAR Statement;
proc means data=cert.diabetes min max maxdec=0;
  var age height weight;
run;

* a numbered range of variables;
proc means data=cert.survey mean stderr maxdec=2;
  var item1-item5;
run;

* Group Processing Using the CLASS Statement;
proc means data=cert.heart maxdec=1;
  var arterial heart cardiac urinary;
  class survive sex;
run;

* Group Processing Using the BY Statement;
proc sort data=cert.heart out=work.heartsort;
  by survive sex;
run;
proc means data=work.heartsort maxdec=1;
  var arterial heart cardiac urinary;
  by survive sex;
run;

* Creating a Summarized Data Set Using the OUTPUT Statement;
proc means data=cert.diabetes;
  var age height weight;                                /*#1*/
  class sex;                                            /*#2*/
  output out=work.diabetes_by_gender                    /*#3*/
    mean=AvgAge AvgHeight AvgWeight
    min=MinAge MinHeight MinWeight;
run;
proc print data=work.diabetes_by_gender noobs;          /*#4*/
  title1 'Diabetes Results by Gender';
run;

/* The FREQ Procedure */
* Example: Creating a One-Way Frequency Table (Default);
proc freq data=cert.usa;
run;

* Specifying Variables Using the TABLES Statement ;

proc freq data=cert.diabetes;
  tables sex;
run;

* Example: Determining the Report Layout;
proc freq data=cert.loans;
  tables rate months;
run;
* no data for above;

proc freq data=cert.survey;
  tables item1-item3;
run;

* Create Two-Way and N-Way Tables ;
proc freq data=cert.diabetes;
  tables sex*fastgluc;
run;

* Examples: Creating N-Way Tables;
proc format;
  value Survive 0='Dead'
                1='Alive';
run;
proc freq data=cert.leukemia;
  tables Survived*AG*WhiteCells;
  format Survived survive.;
run;

* Example: Using the LIST Option;
proc format;
  value survive 0='Dead'
                1='Alive';
run;
proc freq data=cert.leukemia;
  tables Survived*AG*WhiteCells / list;
  format Survived survive.;
run;

* Example: Using the CROSSLIST Option;
proc format;
  value survive 0='Dead'
                1='Alive';
run;
proc freq data=cert.leukemia;
  tables Survived*AG*whitecells / crosslist;
  format Survived survive.;
run;

* Example: Suppressing Percentages ;
proc format;
  value survive  0='Dead'
                 1='Alive';
run;
proc freq data=cert.leukemia;
  tables Survived*AG*whitecells / nofreq norow nocol;
  format Survived survive.;
run;
