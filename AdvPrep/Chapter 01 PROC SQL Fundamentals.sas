/* Chapter 1: PROC SQL Fundamentals */
/* PROC SQL Basics */
* Example: Selecting Columns;

proc sql;
   select empid, jobcode, salary, salary*.06 as bonus
      from certadv.payrollmaster
      where salary<32000
      order by jobcode;
quit;

* Example: Displaying All Columns Using SELECT *;

proc sql;
   select *
      from certadv.staffchanges;
quit;

* Example: Using the FEEDBACK Option;
proc sql feedback;
   select *
      from certadv.staffchanges;
quit;

* Example: Creating a New Column;
proc sql;
   select empid, jobcode, salary, salary*.06 as bonus
      from certadv.payrollmaster
      where salary<32000
      order by jobcode;
quit;

* Example: Eliminating Duplicate Rows from Output;
proc sql;
   select distinct flightnumber, destination
      from certadv.internationalflights;
quit;

/* The FROM Clause */
* Example: Querying a Single Table Using the FROM Clause;
proc sql;
   select empid, jobcode, salary, salary*0.06 as bonus
      from certadv.payrollmaster
      where salary<32000
      order by jobcode;
quit;

/* The WHERE Clause */
proc sql outobs=10;
   select flightnumber, date, destination,
         boarded + transferred + nonrevenue as Total
      from certadv.marchflights;
quit;

* error message;
proc sql outobs=10;
   select flightnumber, date, destination,
          boarded + transferred + nonrevenue as Total
      from certadv.marchflights
      where total < 100;
quit;

* Example: Using Calculated Values in a WHERE Clause;
proc sql outobs=10;
   select flightnumber, date, destination,
         boarded + transferred + nonrevenue as Total
      from certadv.marchflights
      where calculated total < 100;
quit;
/*
where boarded + transferred + nonrevenue <100;
*/

* Example: Using Calculated Values in a SELECT Clause;
proc sql outobs=10;
   select flightnumber, date, destination,
         boarded + transferred + nonrevenue as Total,
         calculated total/2 as Half
      from certadv.marchflights;
quit;

* Subsetting Rows Using Conditional Operators;
* Using the CONTAINS Operator to Select a String;
proc sql;
   select name
      from certadv.frequentflyers
      where name contains 'ER';
quit;

* Using the IN Operator to Select Values from a List;
/*
where jobcategory in ('PT','NA','FA')
*/


* Using the IS MISSING or IS NULL Operator to Select Missing Values;
proc sql;
   select boarded, transferred, nonrevenue, deplaned
      from certadv.marchflights
      where boarded is missing;
quit;

* Using the LIKE Operator to Select a Pattern;
proc sql;
   select ffid, name, address
      from certadv.frequentflyers
      where address like '%P%PLACE';
quit;

* Using the Sounds-Like (=*) Operator to Select a Spelling Variation;
/* The GROUP BY Clause */

proc sql;
   select membertype, sum(milestraveled) as TotalMiles  /*1*/
      from certadv.frequentflyers
      group by membertype;                              /*2*/
quit;

* Example: Using a Summary Function with a Single Argument (Column);
title 'Average Salary for All Employees';
proc sql;
   select avg(salary) as AvgSalary
      from certadv.payrollmaster;
quit;

* Example: Using a Summary Function with Multiple Arguments (Columns);
proc sql;
   select sum(boarded, transferred, nonrevenue) as Total
      from certadv.marchflights;
quit;

* Example: Using a Summary Function with Columns outside the Function;
proc sql;
   select jobcode, avg(salary) as AvgSalary
      from certadv.payrollmaster;
quit;

* Example: Using a Summary Function with a GROUP BY Clause;
proc sql;
   select jobcode, avg(salary) as AvgSalary format=dollar11.2
      from certadv.payrollmaster
      group by jobcode;
quit;

* Counting Values by Using the COUNT Summary Function;
* Example: Counting All Rows in a Table;
proc sql;
   select count(*) as Count
      from certadv.payrollmaster;
quit;

* Example: Counting Rows within Groups of Data;
proc sql;
   select substr(jobcode,1,2)     /*1*/
      label='Job Category',
      count(*) as Count           /*2*/
      from certadv.payrollmaster
      group by 1;                 /*3*/
quit;
* grouped by the first defined column;

* Counting All Nonmissing Values in a Column;

* Example: Counting All Unique Values in a Column;
proc sql;
   select count(distinct jobcode) as Count
      from certadv.payrollmaster;
quit;

* Example: Listing All Unique Values in a Column;
proc sql;
   select distinct jobcode
      from certadv.payrollmaster;
quit;

/* The HAVING Clause */
* Example: Selecting Groups by Using the HAVING Clause;
proc sql;
   select jobcode, avg(salary) as AvgSalary format=dollar11.2
      from certadv.payrollmaster
      group by jobcode
      having avg(salary)>56000;
quit;

* Understanding Data Remerging;
proc sql;
   select empid, salary,(salary/sum(salary)) as Percent format=percent8.2
      from certadv.payrollmaster
      where jobcode contains 'NA';
quit;

/* The ORDER BY Clause */
* Example: Ordering Rows by the Values of a Single Column;
proc sql;
   select empid,jobcode,salary,
          salary*.06 as bonus
     from certadv.payrollmaster
     where salary<32000
     order by jobcode;
quit;

* Example: Ordering by Multiple Columns;
proc sql;
   select empid,jobcode,salary,
          salary*.06 as bonus
      from certadv.payrollmaster
      where salary<32000
      order by jobcode,empid;
quit;

* Example: Ordering Columns by Position;
* sorts the values of the fourth column and the second column;
proc sql;
   select empid, jobcode, salary, dateofhire
      from certadv.payrollmaster
      where salary<32000
      order by 4, 2;
quit;

/* PROC SQL Options */
proc sql inobs=5;
   select *
      from certadv.mechanicslevel1;
quit;

* Example: Limiting the Number of Rows Displayed;
proc sql outobs=10;
   select *
      from certadv.payrollmaster
      order by Salary desc;
quit;

* Example: Including a Column of Row Numbers;
proc sql inobs=10 number;
   select flightnumber, destination
      from certadv.internationalflights;
quit;

/* Validating Query Syntax */
* Example: Using the NOEXEC Option;
proc sql noexec;
   select empid, jobcode, salary
      from certadv.payrollmaster
      where jobcode contains 'NA'
      order by salary;
quit;

* Example: Using the VALIDATE Keyword;
proc sql;
   validate
   select empid, jobcode, salary
      from certadv.payrollmaster
      where jobcode contains 'NA'
      order by salary;
quit;
