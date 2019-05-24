* Finding the First and Last Observations in a Group;
* Example 13.14. The following program uses the SET 
and BY statements to tell SAS to identify the first 
and last observations for each Store and for each Dept 
within each Store, and to subsequently use that 
information to determine and display the total sales 
(DeptTotal) for each Dept within each Store:;

PROC SORT data = stat481.sales out = srtdsales;
  by Store Dept;
RUN;

DATA storesales;
    set srtdsales;
	by Store Dept;
	if first.Dept then DeptTotal = 0;
	DeptTotal + Sales;
	if last.Dept;
	drop Quarter Sales;
	format DeptTotal Dollar13.2;
RUN;

PROC PRINT data = storesales NOOBS;
   title 'Sales by Store and Department';
   sum DeptTotal;
RUN;

* 13.5 - Understanding How Data Sets are Read;
* Example 13.15. The following program uses an 
accumulator variable called TotalSales to determine 
the overall total Sales amount in the sales data set:;

DATA storesales;
    set stat481.sales;
	TotalSales + Sales;
	format Sales TotalSales Dollar13.2;
RUN;

PROC PRINT data = storesales NOOBS;
   title;
RUN;

* Example 13.16. The following program uses the SET 
statement's END= option and a subsetting IF statement 
to tell SAS to write only the last observation in the 
input data set (stat481.sales) to the output data 
set (storesales):;

DATA storesales;
    set stat481.sales end=last;
	TotalSales + Sales;
	format Sales TotalSales Dollar13.2;
	drop Store Dept Sales Quarter;
	if last;
RUN;

PROC PRINT data = storesales NOOBS;
   title;
RUN;


* Example 13.17. The following program uses a SET 
statement to read the permanent SAS data set stat481.sales, 
and then creates a variable called SalesTax, as well as a new 
temporary SAS data set called tax:;

DATA tax;
   set stat481.sales;
   SalesTax = Sales * 0.06; 
RUN;

PROC PRINT data = tax;
   title 'The tax data set';
RUN;
