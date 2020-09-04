/* Chapter 14: Using Functions to Manipulate Data */
/* The Basics of SAS Functions */
* Example: Multiple Arguments;
mean(x1,x2,x3)

/* Converting Data with Functions */
data work.newtemp;
  set cert.temp;
  Salary=payrate*hours;
run;

* Automatic Character-to-Numeric Conversion;
data work.newtemp; 
  set cert.temp; 
  Salary=payrate*hours; 
run;

* Restriction for WHERE Expressions;
data work.convtest; 
  Number=4; 
  Character='4'; 
run; 
proc print data=work.convtest; 
  where character=4; 
run; 
proc print data=work.convtest; 
  where number='4'; 
run;

* Using the INPUT Function;
data work.newtemp; 
  set cert.temp; 
  Salary=input(payrate,2.)*hours; 
run;

proc print data=work.newtemp;  
run;

* Explicit Numeric-to-Character Conversion;
data work.newtemp; 
  set cert.temp; 
  Assignment=site||'/'||dept; 
run;

* concatenation operator (||) ;

data work.newtemp; 
  set cert.temp; 
  Assignment=put(site,2.)||'/'||dept; 
run;
proc print data=work.newtemp;
run;

/* Manipulating SAS Date Values with Functions */
* Example: Finding the Year and Month;
/*
year(startdate)
month(startdate)
*/

data work.nov17; 
  set cert.temp; 
  if year(startdate)=2017 and month(startdate)=11; 
run;
proc print data=work.nov17; 
  format startdate enddate birthdate date9.;
run;

* Example: Finding the Year;
data work.temp16; 
  set cert.temp; 
  where year(startdate)=2016; 
run; 
proc print data=work.temp16; 
  format startdate enddate birthdate date9.;
run;

* WEEKDAY Function;
data work.schwkend; 
  set cert.sch; 
  if weekday(airdate)in(1,7); 
run;
proc print data=work.schwkend;
run;

* Example: MDY Function;
data work.datestemp; 
  set cert.dates; 
  Date=mdy(month,day,year); 
run;
proc print data=work.datestemp;
  format date mmddyy10.;
run;

data work.datestemp;
  set cert.dates;
  DateCons=mdy(6,17,2018);
run;
proc print data=work.datestemp;
  format DateCons mmddyy10.;
run;

* Example: Finding the Date;
data work.review2018 (drop=Day);
  set cert.review2018;
  ReviewDate=mdy(12,day,2018);
run;
proc print data=work.review2018;
  format ReviewDate mmddyy10.;
run;

* invalid date;
data work.review2018 (drop=Day);
  set cert.review2018;
  ReviewDate=mdy(15,day,2018);
run;
proc print data=work.review2018;
  format ReviewDate mmddyy10.;
run;

* Overview of the DATE Function;
data work.tempdate; 
  set cert.dates; 
  EditDate=date(); 
run;
proc print data=work.tempdate; 
  format EditDate date9.; 
run;

* Examples: INTCK Function;
data work.anniversary; 
  set cert.mechanics(keep=id lastname firstname hired); 
  Years=intck('year',hired,today()); 
  if years=20 and month(hired)=month(today()); 
run;
proc print data=work.anniversary; 
  title '20-Year Anniversaries'; 
run;

* Example: INTNX Function;
* DATDIF and YRDIF Functions;

data _null_;
  x=yrdif('16feb2016'd,'16jun2018'd,'30/360');
  put x;
run;

/* Modifying Character Values with Functions */
*Example: Create New Name Variables;

data work.newnames(drop=name); 
  set cert.staff; 
  LastName=scan(name,1); 
  FirstName=scan(name,2); 
run;

* Specifying Delimiters;
* Specifying Multiple Delimiters;
* Specifying Variable Length;
data work.newnames(drop=name); 
  set cert.staff; 
  length LastName FirstName $ 12; 
  LastName=scan(name,1); 
  FirstName=scan(name,2); 
  MiddleInitial=scan(name,3); 
run;
proc print data=newnames;
run;

*Overview of the SUBSTR Function;
data work.agencyemp(drop=middlename); 
  set cert.agencyemp; 
  length MiddleInitial $ 1;
  MiddleInitial=substr(middlename,1,1); 
run;
proc print data=work.agencyemp;
run;

*SUBSTR function to replace;
data work.temp2;
  set cert.temp;
  substr(phone,1,3)='433';
run;
proc print data=work.temp2;
run;

*on the right side of the assignment statement;
data work.temp2(drop=exchange);
  set cert.temp;
  Exchange=substr(phone,1,3);
  substr(phone,1,3)='433';
run;
proc print data=work.temp2;
run;

data work.temp2(drop=exchange);
  set cert.temp;
  Exchange=substr(phone,1,3);
  if exchange='622' then substr(phone,1,3)='433';
run;
proc print data=work.temp2;
run;

* LEFT and RIGHT Functions;
data _null_;
  a='DUE DATE';
  b='   DUE DATE';
  c=left(a);
  d=left(b);
  put c $8.;
  put d $12.;
run;

*Example: RIGHT Function;
data _null_;
  a='DUE DATE';
  b='DUE DATE   ';
  c=right(a);
  d=right(b);
  put c $8.;
  put d $12.;
run;

*Concatenation Operator;
FullName = First || Middle || Last;

*TRIM Function;
data work.nametrim;
  length Name $ 20 First Middle Last $ 10;
  Name= 'Jones, Mary Ann, Sue';
  First = left(scan(Name, 2, ','));
  Middle = left(scan(Name, 3, ','));
  Last = scan(name, 1, ',');
  FullName = trim(First) || trim(Middle) ||Last;
  drop Name;
run;

proc print data=work.nametrim;
run;

*CATX Function;
data work.newaddress(drop=address city state zip); 
  set cert.temp; 
  NewAddress=trim(address)||', '||trim(city)||', '||zip; 
run;

data work.newaddress(drop=address city state zip); 
  set cert.temp; 
  NewAddress=catx(', ',address,city,zip); 
run;
proc print data=work.newaddress;
run;

*INDEX Function;
data work.datapool; 
  set cert.temp; 
  where index(job,'word processing') > 0; 
run;
proc print data=work.datapool;
run;

*FIND Function;
data work.datapool; 
  set cert.temp; 
  where find(job,'word processing') > 0; 
run;
proc print data=work.datapool;
run;

*UPCASE Function;
data work.upcasejob; 
  set cert.temp; 
  Job=upcase(job); 
run;
proc print data=work.upcasejob;
run;

*LOWCASE Function;
data work.lowcasecontact; 
  set cert.temp; 
  Contact=lowcase(contact); 
run;
proc print data=work.lowcasecontact;
run;

*PROPCASE Function;
data work.propcasecontact;
  set cert.temp;
  Contact=propcase(contact);
run;
proc print data=work.propcasecontact;
run;

*TRANWRD Function;
data work.after; 
  set cert.before; 
  name=tranwrd(name,'Miss','Ms.'); 
  name=tranwrd(name,'Mrs.','Ms.'); 
run;
proc print data=work.after;
run;

*COMPBL Function;
data _null_;
  string='Hey
   Diddle  Diddle';
  string=compbl(string);
  put string;
run;

data _null_;
  string='125    E Main St';
  length address $10;
  address=compbl(string);
  put address;
run;

*COMPRESS Function;
data _null_;
  a='A B C D';
  b=compress(a);
  put b=;
run;

*Example: Compress a Character String Using a Modifier;
data _null_;
  x='919-000-000 nc  610-000-000 pa     719-000-000 CO  419-000-000 Oh';
  y=compress(x, 'ACHONP', 'i');
put y=;
run;

/* Modifying Numeric Values with Functions */
* CEIL and FLOOR Functions;
data _null_;
  var1=2.1;
  var2=-2.1;
  a=ceil(var1);
  b=ceil(var2);
  put "a=" a;
  put "b=" b;
run;

data _null_;
  c=ceil(1+1.e-11);
  d=ceil(-1+1e-11);
  e=ceil(1+1.e-13);
  put "c=" c;
  put "d=" d;
  put "e=" e;
run;

data _null_;
  f=ceil(223.456);
  g=ceil(763);
  h=ceil(-223.456);
  put "f=" f;
  put "g=" g;
  put "h=" h;
run;
* floor function;
data _null_;
  var1=2.1;
  var2=-2.1;
  a=floor(var1);
  b=floor(var2);
  put "a=" a;
  put "b=" b;
run;

* INT Function;
data work.creditx; 
  set cert.credit; 
  Transaction=int(transaction); 
run;
proc print data=work.creditx;
run;

*ROUND Function;
data work.rounders; 
  set cert.rounders; 
  AccountBalance=round(AccountBalance, 1);
  InvoicedAmount=round(InvoicedAmount, 0.1);
  AmountRemaining=round(AmountRemaining, 0.02);
  format AccountBalance InvoicedAmount PaymentReceived AmountRemaining dollar9.2;
run;
proc print data=work.rounders;
run;

/*Nesting SAS Functions */
MiddleInitial=substr(scan(name,3),1,1);

Years=intck('year','15jun2018'd,today());
