* 12.3 - Cell Statistics;

* Example 12.8. The following SAS program illustrates 
the NOROW, NOCOL, and NOPERCENT table options:;

PROC FREQ data=icdb.back;
    title 'Crosstabulation of SEX and RACE: No percents';
    tables race*sex/norow nocol nopercent;
 RUN;


* Example 12.9. In creating the two-way table between race 
 and sex, the following FREQ procedure requests that the 
 EXPECTED and CELLCHI2 statistics be printed, while at the 
 same time suppressing the printing of the joint, row, and 
 column percentages:;

PROC FREQ data=icdb.back;
   title 'Crosstabulation of SEX and RACE: With Expecteds';
   tables race*sex/expected cellchi2 norow nocol nopercent;
 RUN;

* Example 12.10. The following FREQ procedure illustrates 
 the LIST option:;

PROC FREQ data=icdb.back;
    title 'Crosstabulation of SEX and RACE: In List Format';
    tables sex*race/list;
 RUN;

* Example 12.11. The following FREQ procedure illustrates 
 the CROSSLIST option:;
PROC FREQ data=icdb.back;
    title 'Crosstabulation of SEX and RACE: In Crosslist Format';
    tables sex*race/crosslist;
 RUN;

* 12.5 - Creating Output Data Sets;
* Example 12.12. The following FREQ procedure tells SAS 
 to create an output data set which contains the counts 
 and percentages for each combination of the variables 
 sex and race:;

PROC FREQ data=icdb.back;
     tables sex*race/out=sexfreq noprint;
RUN;
 
PROC PRINT;
    title 'Output Dataset: SEXFREQ';
RUN;

* Example 12.13. The SPARSE tables option tells SAS to 
print information about all possible combinations of 
levels of the variables in the table request, even when 
some combinations of levels do not occur in the data. 
This option affects printouts under the LIST option 
and output data sets only. The following SAS code 
illustrates use of the SPARSE option in the creation of 
an output data set called sexfreq:;

PROC FREQ data=icdb.back;
     tables sex*race/out=sexfreq noprint sparse;
RUN;
 
PROC PRINT;
    title 'Output Dataset: SEXFREQ with SPARSE option';
RUN;

* 12.6 - Table Statistics;
* NOTE : ALL, which requests all of the tests and measures 
provided by the CHISQ, MEASURE, and CMH options.;
* Example 12.14. For the remaining examples in this lesson, 
we need an analysis data set with which to work. The analysis 
data set (right-click to save!) that we'll use contains (just!) 
four variables pulled from the ICDB background data set 
(with which we've already been working!), the ICDB cystoscopy 
data set and the ICDB symptoms data set. The following program 
merely displays the variable names of, and the first 15 
observations in, the analysis data set:;

OPTIONS NOFMTERR;

PROC CONTENTS data = icdb.analysis position;
   title 'The Analysis data set';
RUN;

PROC PRINT data = icdb.analysis (OBS = 15);
   title 'The Analysis data set';
RUN;

* Example 12.15. Some clinical centers may be more likely 
to perform a cystoscopy (which is a fairly invasive procedure) 
on their patients than other clinical centers. One could imagine 
this happening for a variety of reasons. For instance, one 
clinical center might have more severe patients thereby 
justifying more invasive procedures. Or perhaps the patients 
attending a particular clinical center might be better off 
financially and therefore more willing to pay for additional 
procedures. In any case, suppose we are interested in 
testing whether or not there is an association between 
performing a cystoscopy (cyst_hb) and clinical center 
(ctr). A chi-square test between the two variables would help 
us answer our research question. The following FREQ procedure 
illustrates the use of the CHISQ tables option in order to 
obtain the value of the chi-square test statistic and its 
associated P-value (as well as a few other useful 
statistics and P-values):;

PROC FORMAT;
    value cystfmt 0     = 'Local'
                  1     = 'Both'
                  2     = 'Hydro'
                  OTHER = 'Nothing';
 RUN;

 PROC FREQ data=icdb.analysis;
   title 'Chi-square Test of Hospital and Cystoscopy Procedure: CHISQ';
   format cyst_hb cystfmt.;
   tables ctr*cyst_hb/nopercent nocol missing chisq;
 RUN;

* You should first see a two-way table (with five rows for 
 ctr and four columns for cyst_hb). Then, you should 
 see a list of six different statistics, of which the 
 first one is the chi-square test statistic. Here, the 
 value of the statistic is 77.2 (rounded) with 12 degrees 
 of freedom (DF) and a P-value that is less than 0.0001. 
 (Assuming that there is enough non-missing data and 
 therefore that the chi-square test is valid), the 
 P-value tells us that it is highly unlikely that we 
 would observe the data we did under the assumption 
 that ctr and cyst_hb are not associated. Therefore, 
 we conclude that ctr and cyst_hb are associated.;

* Example 12.16. If we are interested in quantifying 
 the association between clinical center and performing 
 a cystoscopy, then we would want to take advantage of 
 the MEASURES tables option. The following FREQ procedure 
 illustrates the use of the MEASURES tables option to 
 obtain a basic set of measures of association and 
 their standard errors:;

PROC FORMAT;
    value cystfmt 0     = 'Local'
                  1     = 'Both'
                  2     = 'Hydro'
                  OTHER = 'Nothing';
 RUN;

PROC FREQ data=icdb.analysis;
    title 'Chi-square Test of Hospital and Cystoscopy Procedure: MEASURES';
	format cyst_hb cystfmt.;
    tables ctr*cyst_hb/nopercent nocol missing measures;
 RUN;

* Example 12.17. The Cochran-Mantel-Haenszel test allows 
 us to test for the association between two categorical 
 variables while adjusting for a third categorical 
 variable. To request that SAS performs such a test, 
 we must use the CMH tables option. The following CMH 
 tables option requests the Cochran-Mantel-Haenszel to 
 test for association between the two variables cyst_hb 
 and sym_1 while adjusting for the third variable ctr:;

OPTIONS NOFMTERR;

PROC FORMAT;
    value cystfmt 0     = 'Local'
                  1     = 'Both'
                  2     = 'Hydro'
                  OTHER = 'Nothing';
 RUN;

PROC FREQ data=icdb.analysis;
   title 'Chi-square Test of Hospital and Cystoscopy Procedure: CMH';
   title2 'Adjusting for Ctr';
   format cyst_hb cystfmt.;
   tables ctr*cyst_hb*sym_1/nopercent nocol cmh;
 RUN;

* NOTE : As always, we put the stratifying variable — 
 in this case, ctr — in the first position of the 
 tables statement. Then, we put the two variables 
 between which we are testing for association — in 
 this case, cyst_hb and sym_1 — in the second and 
 third positions. ;

