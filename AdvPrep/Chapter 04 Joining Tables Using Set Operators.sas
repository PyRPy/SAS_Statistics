/* Chapter 4: Joining Tables Using Set Operators */
/* Understanding Set Operators */
* Example: The Basics of Using a Set Operator;
proc sql;
   select *
      from certadv.stress17 union
   select *
      from certadv.stress18;
quit;

proc print data = certadv.stress17;
run;

* Example: Using Multiple Set Operators;
proc sql; 
    select *
       from certadv.mechanicslevel1
    outer union
    select *
       from certadv.mechanicslevel2
    outer union
    select *
       from certadv.mechanicslevel3;
quit;

* Example: Overlaying Columns;
title 'PROC SQL Query Result';
proc sql;
   select *                      /*1*/
      from certadv.col1 except   /*2*/
   select *
      from certadv.col2;
quit;

/* Using the EXCEPT Set Operator */
* Example: Using the EXCEPT Operator Alone;
proc sql;
   select *
      from certadv.col1 except
   select *
      from certadv.col2;
quit;
* also removes duplicates;

* Example: Using the Keyword ALL with the EXCEPT Operator;
proc sql;
   select *
      from certadv.col1 except all
   select *
      from certadv.col2;
quit;
* does not remove duplicates;

* Example: Using the Keyword CORR with the EXCEPT Operator;
proc sql;
   select *
      from certadv.col1 except corr
   select *
      from certadv.col2;
quit;

* Example: Using the Keywords ALL and CORR with the EXCEPT Operator;
proc sql;
   select *
      from certadv.col1 except all corr
   select *
      from certadv.col2;
quit;

* Example: EXCEPT Operator;
proc sql;
   select firstname, lastname
      from certadv.staffchanges except all
   select firstname, lastname
      from certadv.staffmaster;
quit;
* for speed up using ALL;

/* Using the INTERSECT Set Operator */
* Example: Using the INTERSECT Operator Alone;
proc sql;
   select *
      from certadv.col1 intersect
   select *
      from certadv.col2;
quit;

* Example: Using the Keyword ALL with the INTERSECT Set Operator;
proc sql;
   select *
      from certadv.col1 intersect all
   select *
      from certadv.col2;
quit;

* Example: Using the Keyword CORR with the INTERSECT Set Operator;
proc sql;
   select * 
      from certadv.col1 intersect corr
   select *
      from certadv.col2;
quit;

* Example: Using the Keywords ALL and CORR with the INTERSECT Set Operator;
proc sql;
   select *
      from certadv.col1 intersect all corr
   select *
      from certadv.col2;
quit;

* Complex Example Using the INTERSECT Operator;
proc sql;
   select firstname, lastname
      from certadv.staffchanges
   intersect all
   select firstname, lastname
      from certadv.staffmaster;
quit;

/* Using the UNION Set Operator */
* Example: Using the UNION Operator Alone;
proc sql;
   select *
      from certadv.col1 union
   select *
      from certadv.col2;
quit;

* Example: Using the Keyword ALL with the UNION Operator;
proc sql;
   select *
      from certadv.col1 union all
   select *
      from certadv.col2;
quit;
* when ALL is used, no duplicates removal or sorting;

* Example: Using the Keyword CORR with the UNION Operator;
proc sql;
   select *
      from certadv.col1 union corr
   select *
      from certadv.col2;
quit;

* Example: Using the Keywords ALL and CORR with the UNION Operator;
proc sql;
   select *
      from certadv.col1 union all corr
   select *
      from certadv.col2;
quit;
* duplicates are kept with ALL;

* Example: Using the UNION Set Operator;
proc sql;
   select *
      from certadv.stress17 union
   select *
      from certadv.stress18;
quit;

* Example: Using a UNION Operator and Summary Functions;
proc sql;
   select sum(pointsearned) format=comma12.
         label='Total Points Earned',
         sum(pointsused) format=comma12.
         label='Total Points Used',
         sum(milestraveled) format=comma12.
         label='Total Miles Traveled'
      from certadv.frequentflyers;
quit;

* combine the three query results;
proc sql;
title 'Points and Miles Traveled';
title2 'by Frequent Flyers';
   select 'Total Points Earned:',
         sum(PointsEarned) format=comma12.
      from certadv.frequentflyers union
   select 'Total Points Traveled:',
         sum(MilesTraveled) format=comma12.
      from certadv.frequentflyers union
   select 'Total Points Used:',
         sum(PointsUsed) format=comma12.
      from certadv.frequentflyers
;
quit;

/* Using the OUTER UNION Set Operator */
*Example: Using the OUTER UNION Operator Alone;
proc sql;
   select *
      from certadv.col1 outer union
   select *
      from certadv.col2;
quit;

* Example: Using the Keyword CORR with One OUTER UNION Operator;
proc sql;
   select *
      from certadv.col1 outer union corr
   select *
      from certadv.col2
;
quit;

* Example: Using Two OUTER UNION Operators with the Keyword CORR;
proc sql;
   select *
      from certadv.mechanicslevel1 outer union corr
   select *
      from certadv.mechanicslevel2 outer union corr
   select *
      from certadv.mechanicslevel3;
quit;
* how does it compare with SAS base;
