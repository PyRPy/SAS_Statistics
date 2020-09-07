/* Chapter 3: Joining Tables Using PROC SQL */
/* Understanding Joins */
/* Generating a Cartesian Product */
proc sql;
   select *
      from certadv.one, certadv.two;
quit;

/* Using Inner Joins */
* Example: Using a FROM Clause with the INNER JOIN Keyword;
proc sql;
   select *
      from certadv.one inner join certadv.two
      on one.x=two.x;
quit;

* Example: Eliminating Duplicate Columns;
proc sql;
   select one.x, a, b
      from certadv.one inner join certadv.two
      on one.x=two.x;
quit;
* using the asterisk (*) to select all columns from table One;
proc sql;
   select one.*, b
      from certadv.one inner join certadv.two
      on one.x=two.x;
quit;

* Example: Renaming a Column by Using a Column Alias;
proc sql;
   select one.x as ID, two.x, a, b
      from certadv.one inner join certadv.two
      on one.x=two.x;
quit;

* Example: Joining Tables That Have Rows with Matching Values;
proc sql;
   select *
      from certadv.three inner join certadv.four
      on three.x=four.x;
quit;

* Specifying a Table Alias;
proc sql;
title 'Employee Names and Job Codes';
   select staffmaster.empid, lastname, firstname, jobcode
      from certadv.staffmaster inner join certadv.payrollmaster
      on staffmaster.empid=payrollmaster.empid;
quit;

* specifies table aliases in the FROM clause;
proc sql;
title 'Employee Names and Job Codes';
   select s.empid, lastname, firstname, jobcode
      from certadv.staffmaster as s inner join 
           certadv.payrollmaster as p
      on s.empid=p.empid;
quit;

* Example: Complex PROC SQL Inner Join;
proc sql outobs=15;
   title 'New York Employees';
   select substr(firstname,1,1) || '. ' || lastname   /*1*/
      as Name,
      jobcode,
      int((today() - dateofbirth)/365.25)
      as Age
      from certadv.payrollmaster as p inner join      /*2*/
           certadv.staffmaster as s
      on p.empid =                                    /*3*/
         s.empid
      where state='NY'                                /*4*/
      order by 2,3                                    /*5*/
;
quit;

* Example: PROC SQL Inner Join with Summary Functions;
proc sql outobs=15;
   title 'Average Age of New York Employees';
   select jobcode,count(p.empid) as Employees,               /*1*/
                  avg(int((today() - dateofbirth)/365.25))
                  format=4.1 as AvgAge
      from certadv.payrollmaster as p inner join             /*2*/
           certadv.staffmaster as s
      on p.empid=                                            /*3*/
         s.empid 
      where state='NY'                                       /*4*/
      group by jobcode                                       /*5*/
      order by jobcode                                       /*6*/
;
quit;

/* Using Natural Joins */
proc sql;
   select *
      from certadv.schedule natural join
           certadv.courses
;
quit;
* identifies columns in each table that have the same name and type;

/* Using Outer Joins */
* Example: Using a Left Outer Join;
proc sql;
   select *
      from certadv.one left join
           certadv.two 
           on one.x=two.x
;
quit;

* Example: Eliminating Duplicate Columns in a Left Outer Join;
proc sql;
   select one.x, a, b
      from certadv.one left join
           certadv.two
           on one.x=two.x
;
quit;

* Example: Using a Right Outer Join;
proc sql;
   select *
      from certadv.one right join
           certadv.two
           on one.x=two.x
;
quit;

* Example: Using a Full Outer Join;
proc sql;
   select *
      from certadv.one full join
           certadv.two
           on one.x=two.x
;
quit;

* Example: Complex Outer Join;
proc sql outobs=20;
title 'All March Flights';
   select m.date,                                  /*1*/
          m.flightnumber label='Flight Number',
          m.destination  label='Left',
          f.destination  label='Right',
          delay label='Delay in Minutes'
   from certadv.marchflights as m left join        /*2*/
        certadv.flightdelays as f
      on m.date=f.date                             /*3*/
         and m.flightnumber=f.flightnumber
   order by delay;                                 /*4*/
quit;

/* Comparing SQL Joins and DATA Step Match-Merges */
* When All of the Values Match;
data merged;
   merge certadv.five certadv.six;
   by x;
run;
proc print data=merged noobs;
   title 'Table Merged';
run;

proc sql;
title 'Table Merged';
   select five.x, a, b
      from certadv.five, certadv.six
      where five.x = six.x
      order by x;
quit;

* When Only Some of the Values Match;
data merged;
   merge certadv.three certadv.four;
   by x;
run;

proc print data=merged noobs;
   title 'Table Merged';
run;

proc sql;
title 'Table Merged';
   select three.x, a, b
      from certadv.three
      full join
      certadv.four
      on three.x = four.x
      order by x;
quit;

* Example: Using the COALESCE Function;
data merged;
    merge certadv.three certadv.four;
    by x;
run;
proc print data=merged noobs;
    title 'Table Merged';
run;
* Example: Using the COALESCE Function;
proc sql;
 title 'Table Merged';
    select coalesce(three.x, four.x)
       as X, a, b
       from certadv.three
       full join
       certadv.four
       on three.x = four.x;
