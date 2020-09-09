/*Chapter 5: Using Subqueries */
/* Subsetting Data Using Subqueries */
proc sql;
   select jobcode, avg(salary) as AvgSalary
         format=dollar11.2
      from certadv.payrollmaster
      group by jobcode
      having avg(salary)>(select avg(salary)
      from certadv.payrollmaster);
quit;

* Example: Using Single-Value Noncorrelated Subqueries;
proc sql;
   select jobcode, avg(salary) as AvgSalary format=dollar11.2
      from certadv.payrollmaster
      group by jobcode
      having avg(salary)>               /*1*/
         (select avg(salary)            /*2*/
            from certadv.payrollmaster);
quit;

* Example: Using a Conditional Operator in a Noncorrelated Subquery;
proc sql;
   select empid, lastname, firstname, city, state
      from certadv.staffmaster
         where empid in                                /*1*/
            (select empid from certadv.payrollmaster   /*2*/
               where month(dateofbirth)=2);            /*3*/
quit;

* Example: Using the ANY Operator;
proc sql;
   select empid, jobcode, dateofbirth
      from certadv.payrollmaster
         where jobcode in ('FA1', 'FA2')
            and dateofbirth <any     /*1*/
               (select dateofbirth   /*2*/
                  from certadv.payrollmaster
                  where jobcode='FA3');
quit;

* Example: Using the ALL Operator;
proc sql;
   select empid, jobcode, dateofbirth
      from certadv.payrollmaster
         where jobcode in ('FA1', 'FA2')
            and dateofbirth < all    /*1*/
               (select dateofbirth   /*2*/
                  from certadv.payrollmaster
                  where jobcode='FA3');
quit;

* Example: Using Correlated Subqueries;
proc sql;
   select lastname, firstname
      from certadv.staffmaster
         where 'NA'=
            (select jobcategory
               from certadv.supervisors
               where staffmaster.empid =
               supervisors.empid);
quit;

* Example: Correlated Subquery with NOT EXISTS;
proc sql;
   select lastname, firstname
      from certadv.flightattendants
         where not exists
            (select * from certadv.flightschedule
               where flightattendants.empid=
                  flightschedule.empid);
quit;

/* Creating and Managing Views Using PROC SQL */
* Example: Creating a PROC SQL View;
proc sql;
   create view certadv.faview as
      select lastname, firstname ,
             int((today()-dateofbirth)/365.25) as Age,
             substr(jobcode,3,1) as Level,
             salary
         from certadv.payrollmaster,
              certadv.staffmaster
         where jobcode contains 'FA' and 
               staffmaster.empid=
               payrollmaster.empid;
quit;

* Example: Using a PROC SQL View;
proc sql;
   select *
      from certadv.faview;
quit;

* Example: Displaying the Definition of a PROC SQL View;
proc sql;
   describe view certadv.faview;
quit;

* Omitting the Libref;
proc sql;
   create view certadv.payrollv as
      select *
         from certadv.payrollmaster;
quit;

proc sql;
   create view certadv.payrollv as
      select *
         from payrollmaster;
quit;

* Example: Using an Embedded LIBNAME Statement;
proc sql;
   create view certadv.payrollv as
      select*
         from airline.payrollmaster
         using libname airline 'SAS-library-one';
quit;
proc print data=certadv.payrollv;
run;

* Creating a View to Enhance Table Security;
proc sql;
   create view certadv.infoview as 
      select *
         from fa1.info
      outer union corr
      select *
         from fa2.info
      outer union corr
      select *
         from fa3.info;
quit;

* Example: Updating PROC SQL Views;
proc sql;
   create view certadv.raisev as
      select empid, jobcode, 
             salary format=dollar12., 
             salary/12 as MonthlySalary
             format=dollar12.
         from certadv.payrollmaster;
quit;
proc sql;
   select *
      from certadv.raisev
      where jobcode in ('PT2','PT3');
quit;

* updated;
proc sql;
   update certadv.raisev
      set salary=salary * 1.20 
      where jobcode='PT3';
quit;

* check results;
proc sql;
   select *
      from certadv.raisev
      where jobcode in ('PT2', 'PT3');
quit;

* Example: Dropping a PROC SQL View;
proc sql;
   drop view certadv.raisev;
quit;
