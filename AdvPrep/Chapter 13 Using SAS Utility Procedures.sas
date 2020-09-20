/* Chapter 13: Using SAS Utility Procedures */
/* Creating Picture Formats with the FORMAT Procedure */
proc format;
   picture rainamt
           0-2='9.99 slight'
           2<-4='9.99 moderate'
           4<-<10='9.99 heavy'
           other='999 check value';
run;
proc print data=certadv.rain;
   format amount rainamt.;
run;

/* Creating Functions with PROC FCMP */
proc fcmp outlib=certadv.functions.dev;      /*1*/
   function ReverseName(lastfirst $) $ 40;   /*2*/
     First=scan(lastfirst,2,',');            /*3*/
     Last=scan(lastfirst,1,',');
   return(catx(' ',First,Last));             /*4*/
   endsub;                                   /*5*/
run;

options cmplib=certadv.functions;   /*1*/
data work.baseball;                 /*2*/
   set certadv.baseball;
   Player=reversename(Name);        /*3*/
   keep Name Team Player; 
run;
proc print data=work.baseball;
run;

* Example: Creating a Custom Numeric Function with One Argument;

proc fcmp outlib=certadv.functions.dat;            /*1*/
   function MyQuarter(month);                      /*2*/
      if month in(2,3,4) then myqtr=1;             /*3*/
         else if month in(5,6,7) then myqtr=2;
         else if month in (8,9,10) then myqtr=3;
         else myqtr=4;
      return(myqtr);                               /*4*/
   endsub;                                         /*5*/
run;

options cmplib=certadv.functions;                  /*6*/
data work.dates;                                   /*7*/
   do Dates='15JAN2019'd to '31DEC2019'd by 30;
      MonNum=month(Dates);
      FiscalQuarter=MyQuarter(MonNum);             /*8*/
      output;
   end;
run;

proc print data=work.dates;                        /*9*/
   format Dates mmddyy10.;
run;

* Example: Creating a Custom Character Function with Multiple Arguments;

proc fcmp outlib=certadv.functions.dev;              /*1*/
   function ReverseName(lastfirst $, pos $) $ 40;    /*2*/
      First=scan(lastfirst,2,',');                   /*3*/
      Last=scan(lastfirst,1,',');
      if substr(pos,2,1)='F' then 
         return(catx(' ','Outfielder',First,Last));
      else if substr(pos,2,1)='B' then 
         return(catx(' ','Baseman',First,Last));
      else return(catx(' ',pos,First,Last));
   endsub;                                           /*4*/
quit;

options cmplib=work.functions;                       /*5*/

data work.baseball;                                  /*6*/
   set certadv.baseball;
   Player=reversename(Name,Position);                /*7*/
   keep Name Team Position Player;
run;
proc print data=baseball;
run;

