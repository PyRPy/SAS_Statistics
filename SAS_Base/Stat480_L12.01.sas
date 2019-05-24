* Lesson 12: Summarizing Categorical Data;

* Example 12.1. The following FREQ procedure illustrates 
the simplest practical example, namely a one-way frequency 
table of the variable sex, with no bells or whistles added:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;
* LIBNAME icdb 'C:\simon\icdb\data';

PROC FREQ data=icdb.back;
   title 'Frequency Count of SEX';
   tables sex;
RUN;

* Example 12.2. Again, by default, SAS outputs frequency 
counts, percents, cumulative frequencies, and cumulative 
percents. The NOCUM table option suppresses the printing 
of the cumulative frequencies and cumulative percentages 
for one-way frequency tables. The following SAS code 
illustrates the NOCUM table option:;

PROC FREQ data=icdb.back;
    title 'Frequency Count of SEX: No Cumulative Stats';
    tables sex/nocum;
 RUN;

* Example 12.3. The following SAS program illustrates 
 the creation of two one-way frequency tables in 
 conjunction with the PAGE option:;

PROC FREQ data=icdb.back page;
    title 'Frequency Count of SEX and RACE';
    tables sex race;
 RUN;

 * Because the PAGE option was invoked, each table should 
 be printed on a separate page.;

*Example 12.4. As is the case for many SAS procedures, 
 you can use a BY statement to tell SAS to perform an 
 operation for each level of a BY group. The following 
 program tells SAS to create a one-way frequency table 
 for the variable ed_level for each level of the variable 
 sex:;

PROC SORT data=icdb.back out=s_back;
    by sex;
 RUN;

 PROC FREQ data=s_back;
   title 'Frequency Count of Education Level within Each Level of Sex';
   tables ed_level;
   by sex;
 RUN;

* Example 12.5. The following SAS program illustrates 
 the MISSING and MISSPRINT options on the variable state 
 in the background data set:;

PROC FREQ data=icdb.back;
    title 'One-way Table of State: with MISSING Option';
    tables state/missing;
 RUN;


 PROC FREQ data=icdb.back;
    title 'One-way Table of State: with MISSPRINT Option';
    tables state/missprint;
 RUN;
 * NOTES Because the MISSING option was used, SAS also tells 
 us the 42 subjects comprise 6.58% of the subjects in the 
 data set. SAS also includes the 42 subjects in the 
 calculation of the cumulative percentage.;


* 12.2 - Two-way and N-way Tables;
* Example 12.6. The following FREQ procedure illustrates 
 the simplest example of telling SAS to create a two-way 
 table, for the variables sex and ed_level, with no bells 
 and whistles added:;

PROC FREQ data=icdb.back;
   title 'Crosstabulation of Education Level and Sex';
   tables ed_level*sex;
RUN;

* Example 12.7. For a frequency analysis of more than 
two variables, we can use the FREQ procedure to create 
n-way crosstabulation tables. In that case, a series 
of two-way tables is created, with a table for each level 
of the other variable(s). The following program creates 
a three-way table of sex, job_chng, and ed_level:;

PROC FREQ data=icdb.back;
   title '3-way Table of Sex, Job Change, and Ed. Level';
   tables sex*job_chng*ed_level;
RUN;

