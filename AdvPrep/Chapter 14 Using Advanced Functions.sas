/* Chapter 14: Using Advanced Functions */
/* Using a Variety of Advanced Functions */

* Example: Retrieving Previous Values;
data work.stockprev;
   set certadv.Stock6Mon(drop=Close);
   FirstPrevDay=lag1(Open);
   SecondPrevDay=lag2(Open);
   ThirdPrevDay=lag3(Open);
run;
proc print data=work.stockprev;
run; 

* Example: Calculating a Moving Average;
data work.stockavg;
   set certadv.stocks(drop=Close);
   Open1Month=lag1(Open);
   Open2Month=lag2(Open);
   Open3MonthAvg=mean(Open,Open1Month,Open2Month);
   format Open3MonthAvg 8.2;
run;
proc print data=work.stockavg;
run;

* Example: Counting the Number of Words;
data work.sloganact;
   set certadv.slogans;
   Num24=count(Slogans,'24/7');
   NumWord=countw(Slogans);
run;
proc print data=work.sloganact;
run;

* Example: Finding the Word Number;
data work.sloganact;
   set certadv.slogans;
   Num24=count(Slogans,'24/7');
   NumWord=countw(Slogans);
   FindWord24=findw(Slogans,'24/7',' ','e');
run;
proc print data=work.sloganact;
run;

/* Performing Pattern Matching with Perl Regular Expressions */
* Example: Using Metacharacters;
* Example: PRXMATCH Function Using a Constant;
data work.matchphn;
   set certadv.nanumbr;
   loc=prxmatch('/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/',PhoneNumber);
run;
proc print data=work.matchphn;
   where loc>0;
run;

* Example: PRXMATCH Function Using a Column;
data work.phnumbr (drop=Exp);
   set certadv.nanumbr;
   Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
   Loc=prxmatch(Exp,PhoneNumber);
run;
proc print data=work.phnumbr;
   where loc>0;
run;

* Example: PRXPARSE and PRXMATCH Function Using a Pattern ID Number;
data work.phnumbr (drop=Exp);
   set certadv.nanumbr;
   Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
   Pid=prxparse(Exp);
   Loc=prxmatch(Pid,PhoneNumber);
run;
proc print data=work.phnumbr;
run;

*Example: Using the PRXCHANGE Function to Standardize Data;
data work.prxsocial;
   set certadv.socialacct;
   Social_Media_Pref1=prxchange('s/(FB)/Facebook/i',-1,Social_Media_Pref1);
   Social_Media_Pref1=prxchange('s/(IG)/Instagram/i',-1,Social_Media_Pref1);
   Social_Media_Pref2=prxchange('s/(FB)/Facebook/i',-1,Social_Media_Pref2);
   Social_Media_Pref2=prxchange('s/(IG)/Instagram/i',-1,Social_Media_Pref2);
run;
proc print data=work.prxsocial;
run;

* Example: Changing the Order Using the PRXCHANGE Function;
data work.revname;
   set certadv.survnames;
   ReverseName=prxchange('s/(\w+), (\w+)/$2 $1/', -1, name);
run;
proc print data=work.revname;
run;

* Example: Capture Buffers for Substitution Using the PRXCHANGE Function;
data work.latlong;
   set certadv.email;
   LatLong=prxchange('s/(-?\d+\.\d*)(@)(-?\d+\.\d*)/$3$2$1/', -1, LongLat);
run;
proc print data=work.latlong;
run;
