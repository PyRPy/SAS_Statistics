* 6.6 - Output Appearance;
DATA basic;
  input subj 1-4 name $ 6-23 clinic $ 25-28 
        gender 30 no_vis 32-33 type_vis 35-37
        expense 39-45;
  DATALINES;
1024 Alice Smith        LEWN 1  7 101 1001.98
1167 Maryann White      LEWN 1  2 101 2999.34
1168 Thomas Jones       ALTO 2 10 190 3904.89
1201 Benedictine Arnold ALTO 2  1 190 1450.23
1302 Felicia Ho         MNMC 1  7 190 1209.94
1471 John Smith         MNMC 2  6 187 1763.09
1980 Jane Smiley        MNMC 1  5 190 3567.00
  ;
RUN;

* Example 6.16. The following PRINT procedure merely prints our basic 
data set, but this time with helpful TITLE and FOOTNOTE statements:;

OPTIONS LS = 80 PS = 20 NODATE NONUMBER;

PROC PRINT data = basic;
    title 'Our BASIC Data Set';
	footnote1 'Clinic: ALTO = altoona,  LEWN = Lewistown,  MNMC = Mount Nittany';
	footnote3 'Type_vis: 101 = Gynecology, 190 = Physical Therapy, 187 = Cardiology';
	footnote5 'Gender: 1 = female,  2 = male';
RUN;

footnote;

* Example 6.17. If you want to make your output more readable by double-spacing 
it, you can use the PRINT procedure's DOUBLE option. The following SAS program 
prints six variables in the basic data set using double-spacing:;

OPTIONS PS = 58 LS = 72;

PROC PRINT data = basic NOOBS DOUBLE;
   title 'Our BASIC Data Set';
   var subj name clinic no_vis type_vis expense;
RUN;

* 6.7 - Descriptive Labels;

* Example 6.18. The following SAS program illustrates the use of the LABEL 
option in conjunction with the LABEL statement in the PRINT procedure:;
PROC PRINT data = basic LABEL;
    label name = 'Name'
	      no_vis = 'Number of Visits'
		  type_vis = 'Type of Visit'
		  expense = 'Expense';
	id name;
	var no_vis type_vis expense;
RUN;

* Example 6.19. If you look at the output from the previous program, you'll 
see that SAS does what it can to fit longer labels, such as Number of Visits, 
above the column headings. You can instead control where SAS splits long 
labels by using the SPLIT= option. By using the option, you tell SAS to split 
the labels wherever the designated split character appears. The following SAS 
code illustrates the PRINT procedure's SPLIT= option:;

PROC PRINT data = basic SPLIT='/';
    label name = 'Name';
	label no_vis = 'Number of/Visits';
	label type_vis = 'Type of Visit';
    label expense = 'Expense';
	id name;
	var no_vis type_vis expense;
RUN;

* 6.8 - Formatting Data Values;
* Example 6.20. The following SAS program illustrates the use of the FORMAT 
statement to tell SAS to display the expense variable using the dollar9.2 format:;
PROC PRINT data = basic LABEL;
   label name = 'Name'
         clinic = 'Clinic'
         expense = 'Expense';
   format expense dollar9.2;
   id name;
   var clinic expense;
RUN;

PROC PRINT data = basic LABEL;
   label name = 'Name'
         clinic = 'Clinic'
         expense = 'Expense';
   format expense dollar8.2;
   id name;
   var clinic expense;
RUN;

/* more format documents
Format	Specifies These Values	Example
COMMAw.d	that contain commas and decimal places	comma8.2
DOLLARw.d	that contain dollar signs, commas, and decimal places	dollar6.2
MMDDYYw.	as date values of the form 10/03/08 (mmddyy8.) or 10/03/2008 (mmddyy10.)	mmddyy10.
w.	rounded to the nearest integer in w spaces	7.
w.d	rounded to d decimal places in w spaces	8.2
$w.	as character values in w spaces	$12.
DATEw.	as date values of the form 02OCT08 (date7.) or 02OCT2008 (date9.)	date9. */


