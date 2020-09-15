/* Chapter 10: Advanced Macro Techniques */
* Storing Macro Definitions in External Files;
%include 'Documents\My SAS Files\SAS_Adv_Prep\certadv\prtlast.sas' /source2;
proc sort data=certadv.courses out=work.bydays;
   by days;
run;
%prtlast

/* Understanding Session Compiled Macros */
/* Using the Autocall Facility */

/* Data-Driven Macro Calls */
* Example: Using the DOSUBL Function;
%macro DelayReport(empid);
title "Flight Delays for Employee &Empid";
proc sql;
   select DelayCategory, Count(*) as Count
      from 
         certadv.flightdelays d
         inner join 
         certadv.flightschedule s
      on s.date=d.date and s.flightnumber=d.flightnumber
      where empid="&Empid"
      group by DelayCategory
;
quit;
title;
%mend;

%Delayreport(1928)
%Delayreport(1407)
%Delayreport(1574)
%Delayreport(1777)


data _null_;
   set certadv.FlightCrewNew;
   rc=dosubl(cats('%DelayReport(',empid,')'));
run;
