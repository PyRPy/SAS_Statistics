/* Chapter 6: Advanced SQL Techniques */
/* Creating Data-Driven Macro Variables with PROC SQL */
* Step 1: Create the Macro Variable;
proc sql;
   select avg(Salary)
      into:avgSal
      from certadv.payrollmaster;
quit;

* Step 2: Use the Macro Variable;
title "Salaries above: &AvgSal";
proc sql;
   select EmpID, JobCode, Salary, DateofHire
      from certadv.payrollmaster
      where Salary>&avgSal and DateofHire>'01JAN2015'd;
quit;

title "Salaries above: %left(%qsysfunc(putn(&AvgSal,dollar16.)))";
proc sql;
   select EmpID, JobCode, Salary, DateofHire
      from certadv.payrollmaster
      where Salary>&avgSal and DateofHire>'01JAN2015'd;
quit;

* Displaying Macro Variable Values;
%put avgsal=&avgSal;

* Removing Leading and Trailing Blanks;
proc sql;
   select min(PointsEarned)
      into:MinMiles
      from certadv.frequentflyers;
quit;
%put &=MinMiles;


* the TRIMMED option;
proc sql;
   select min(PointsEarned)
      into:MinMiles trimmed
      from certadv.frequentflyers;
quit;
%put &=MinMiles;

* Concatenating Values in Macro Variables;
proc sql noprint;
   select distinct location into: sites separated by ' '
      from certadv.schedule;
quit;

title1 "Total Revenue";
title2 "from Course Sites: &sites";
proc means data=certadv.all sum maxdec=0;
   var fee;
run;

* Applying a Format to Character and Numeric Variables;
proc sql noprint;
   select avg(Census_Apr2010) as No_Format, 
          avg(Census_Apr2010) as Format format=comma16.
      into:CensusAvg2010,
          :CensusAvg2010_Format
      from certadv.census;
quit;

*  creates one macro variable, StateList;
proc sql noprint;
   select State format=$upcase23. as State
      into:StateList separated by ', '
      from certadv.census
      where PopEst_Apr2018>&CensusAvg2010 and PopEst_Apr2018>10000000
      order by State
;
quit;
%put &=StateList;

*  produces a query result;
title "States with Population Estimates Above Census Avg: &CensusAvg2010_Format";
footnote "&StateList";
proc sql; 
   select strip(State) format=$upcase23. as State,
          Census_Apr2010 format=comma12.,
          PopEst_Apr2010 format=comma12.,
          (PopEst_Apr2018-Census_Apr2010) format=comma12. as PopChange
      from certadv.census
      where PopEst_Apr2018>&CensusAvg2010 and PopEst_Apr2018>10000000
      order by State;
quit;
title;
footnote;

/* Accessing DBMS Data with SAS/ACCESS */
* Example: Connecting to an Oracle Database;
proc sql;
   connect to oracle (user=User password=Student827 path=localhost);
   select *
      from connection to oracle
      (select * from customers
       where customer like '1%');
   disconnect from oracle;
quit;

/* The FedSQL Procedure */


libname market oracle user=cert password=student
                              path=localhost schema=Analyst;
proc fedsql;
   select State,
         count(*) as TotalCustomer format=comma14.
      from market.customer
      where CreditScore > 650
      group by State
      order by TotalCustomer desc;
quit;

* The LIMIT Clause;
libname certadv v9 'Documents\My SAS Files\SAS_Adv_Prep\Certadv\';
proc fedsql;
   select State, Census_Apr2010, PopEst_Apr2018
      from certadv.census
      order by State
      limit 10;
quit;

* The PUT Function;
libname certadv v9 'Documents\My SAS Files\SAS_Adv_Prep\Certadv\';
proc fedsql;
   select SalesRep,
          put(Sales1, dollar10.2),
          put(Sales2, dollar10.2),
          put(Sales3, dollar10.2),
          put(Sales4, dollar10.2)
      from certadv.qsales;
quit;

* use the AS keyword ;
libname certadv 'Documents\My SAS Files\SAS_Adv_Prep\Certadv\';
proc fedsql;
   select SalesRep,
          put(Sales1, dollar10.2) as Sales1,
          put(Sales2, dollar10.2) as Sales2,
          put(Sales3, dollar10.2) as Sales3,
          put(Sales4, dollar10.2) as Sales4
      from certadv.qsales;
quit;
