/* Chapter 11: Defining and Processing Arrays */
/* Defining and Referencing One-Dimensional Arrays */
* Example: Processing Repetitive Code;
data work.highcount;
   set certadv.patdata;
   array health[5] Weight--BP;
   do i = 1 to 5;
      if health[i]='High' then HighCount+1;
   end;
run;

* Example: Using the DIM Function in an Iterative DO Statement;
data work.sysbp2 (drop=i);
   set work.sysbp;
   array sbparray[*] sbp:;
   do i=1 to dim(sbparray);
      if sbparray[i]=999 then sbparray[i]=.;
end;
run;

* Compilation and Execution Phases for Array Processing;
data work.survsalary (drop=i);
   set certadv.salary;
   array BelowAvgS[4] Salary1-Salary4;
   do i=1 to 4;
      if BelowAvgS[i] <=51000 then BelowAvg+1;
   end;
run;

proc print data = survsalary;
run;

/* Expanding Your Use of One-Dimensional Arrays */
* Example: Assigning Initial Values to Arrays;
data work.report (drop=i);                       /*1*/
   set certadv.qsales;
   array sale[4] sales1-sales4;                  /*2*/
   array Goal[4] (9000 9300 9600 9900);          /*3*/
   array Achieved[4];                            /*4*/
   do i=1 to 4;                                  /*5*/
      achieved[i]=100*sale[i]/goal[i];
   end;
run;
proc print data=work.report noobs;
run;

proc print data = certadv.qsales;
run;

* Example: Rotating Data;
data work.yrsales;
   set certadv.qtrsales;
   array Yr[4] SalesQ1-SalesQ4;
   do Quarter=1 to 4;
      Sales=Yr[Quarter];
      output;
   end;
run;

proc print data=work.yrsales;
   var Country Year Quarter Sales;
run;

/* Defining and Referencing Two-Dimensional Arrays */
* Example: Creating a Two-Dimensional Array with Initial Values;
data work.customercoupons;
   array cpnvalue[3,4] _temporary_ (.10, .15, .20, .25,
                                    .30, .40, .10, .15,
                                    .20, .25, .15, .10);
   set certadv.stcoup (keep=CustomerID OrderType Quantity);
   CouponValue=cpnvalue[OrderType,Quantity];
   format CouponValue percent10.;
run;
title 'Coupons for October 2019';
proc print data=work.customercoupons;
run;

* Example: Creating a Two-Dimensional Array to Perform Table Lookup;
data work.diffsales;
   array yrsales[2014:2018,4] _temporary_;    /*1*/
   if _N_=1 then do Yr=2014 to 2018;          /*2*/
      set certadv.us_sales;                   /*3*/
      array qtrsal[4] SalesQ1-SalesQ4;        /*4*/
      do Qtr=1 to 4;                          /*5*/
         yrsales[Yr,Qtr]=qtrsal[Qtr];
      end;
   end;
   set certadv.us_goals;                      /*6*/
   Sales=yrsales[Year,QtrNum];                /*7*/
   Difference=Sales-Goal;                     /*8*/
   drop Yr Qtr SalesQ1-SalesQ4;               /*9*/
run;
proc print data=work.diffsales;
   format Goal Sales Difference dollar14.2;
run;
