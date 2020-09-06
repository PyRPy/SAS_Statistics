/* Chapter 2: Creating and Managing Tables */
/* The CREATE TABLE Statement */
* Example: Creating an Empty Table by Defining Column Structure;
proc sql;
   create table work.discount 
         (Destination char(3),
         BeginDate num Format=date9.,
         EndDate num format=date9.,
         Discount num);
quit;

* Specifying Data Types for Columns;
proc sql;
   create table work.discount2 
      (Destination varchar(3),
       BeginDate date,
       EndDate date,
       Discount float);
quit;

* CHAR and NUM: VARCHAR, DATE, and FLOAT;

* Specifying Column Widths;
proc sql;
   create table work.discount 
      (Destination char(3),
       BeginDate num format=date9.,
       EndDate num format=date9.,
       Discount num);
quit;

* Example: Using Column Modifiers;
proc sql;
   create table work.departments 
      (Dept varchar(20) label='Department',
       Code integer label='Dept Code',
       Manager varchar(20), 
       AuditDate num format=date9.);
quit;

/* Using the LIKE Clause */
* Example: Creating an Empty Table That Is like Another;
proc sql;
   create table work.flightdelays2
      like certadv.flightdelays;
quit;

/* Using the AS Keyword */
* Example: Creating a Table from a Query Result;
proc sql;
   create table work.ticketagents as
      select lastname, firstname, jobcode, salary
         from certadv.payrollmaster,
              certadv.staffmaster
         where payrollmaster.empid
               = staffmaster.empid
               and jobcode contains 'TA';
quit;

proc sql;
   select *
      from work.ticketagents;
quit;

/* The INSERT Statement */
* Example: Inserting Rows by Using the SET Clause;
proc sql;
   insert into work.discount
      set destination='LHR',
          begindate='01MAR2018'd,
          enddate='05MAR2018'd,
          discount=.33
      set destination='CPH',
          begindate='03MAR2018'd,
          enddate='10MAR2018'd,
          discount=.15;
   select *
      from work.discount;
quit;

* Example: Inserting Rows Using the VALUES Clause;
proc sql;
   insert into work.discount (destination,
         begindate,enddate,discount)
      values ('ORD', '05MAR2018'd, '15MAR2018'd, .25)
      values ('YYZ', '06MAR2018'd, '20MAR2018'd, .10);
   select *
      from work.discount;
quit;

* Example: Inserting Rows from a Query Result;
proc sql;
   create table work.mechanicslevel3_new as
   select *
      from certadv.mechanicslevel3;
quit;


* PROC SQL Query Result: One Row Inserted;
proc sql;
   insert into work.mechanicslevel3_new
   select empid, jobcode, salary
      from certadv.mechanicslevel2
         where empid='1653';
   select *
      from work.mechanicslevel3_new;
quit;

* The DESCRIBE TABLE Statement;
proc sql;
   create table work.discount 
         (Destination char(3),
          BeginDate num format=date9.,
          EndDate num format=date9.,
          Discount num);
quit;

* Example: Displaying the Structure of a Table;
proc sql;
   describe table work.discount;
quit;

/* Using Dictionary Tables */
* Example: Exploring and Using Dictionary Tables;
proc sql;
   describe table dictionary.tables;
quit;

proc sql;
   select memname format=$20., nobs, nvar, crdate
      from dictionary.tables
      where libname='CERTADV';
quit;
