* 13.3 - Finding First and Last Observations;

* Example 13.11. The following program tells SAS to 
process the sales data set by Store, just so we can 
get a behind-the-scenes look at how SAS groups 
observations and how we can subsequently find the 
first and last observations of each group:;

LIBNAME stat481 'C:/Data_SAS';

PROC SORT data = stat481.sales out = srtdsales;
  by Store;
RUN;

/*
FIRST.variable = 1 when an observation is the first observation in a BY group
FIRST.variable = 0 when an observation is not the first observation in a BY group
LAST.variable = 1 when an observation is the last observation in a BY group
LAST.variable = 0 when an observation is not the last observation in a BY group
*/

DATA storesales;
    set srtdsales;
	by Store;
	firstStore = first.Store;
	lastStore = last.Store;
RUN;

PROC PRINT data= storesales;
   title 'Behind the scene view of the storesales data set';
   id Store;
RUN;

* Example 13.12. The following program uses the SET and 
BY statements to tell SAS to identify the first and 
last observations for each Store that appears in the 
sales data set, and to subsequently use that information 
to determine and display the total sales (StoreTotal) — 
that is, across all of the departments and quarters — for each Store:;


PROC SORT data = stat481.sales out = srtdsales;
  by Store;
RUN;

DATA storesales;
    set srtdsales;
	by Store;
	if first.Store then StoreTotal = 0;
	StoreTotal + Sales;
	if last.Store;
	drop Dept Quarter Sales;
	format StoreTotal Dollar13.2;
RUN;

PROC PRINT data= storesales;
   title 'Sales by Store';
   id Store;
   sum StoreTotal;
RUN;

* Example 13.13. The following program tells SAS to 
process the sales data set by Store and Dept, so we 
can get a behind-the-scenes look at how we can find 
the first and last observations of two subgroups:;

PROC SORT data = stat481.sales out = srtdsales;
  by Store Dept;
RUN;

DATA storesales;
    set srtdsales;
	by Store Dept;
	firstStore = first.Store;
    lastStore  = last.Store;
    firstDept  = first.Dept;
	lastDept   = last.Dept;
RUN;

PROC PRINT data = storesales;
   title 'Behind the scene view of the storesales data set';
   id Store;
RUN;

