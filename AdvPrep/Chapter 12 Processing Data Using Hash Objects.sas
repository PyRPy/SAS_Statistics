/* Chapter 12: Processing Data Using Hash Objects */
/* Declaring Hash Objects */
/* Defining Hash Objects */
* Example: Defining a Hash Object;
data work.report;
      if 0 then
         set certadv.ctcities (keep=Code City Name);
   if _N_=1 then do;                                      /*1*/
   declare hash airports (dataset: "certadv.ctcities");   /*2*/
   airports.definekey ("Code");                           /*3*/
   airports.definedata ("City", "Name");                  /*4*/
   airports.definedone();                                 /*5*/
end;

/* Finding Key Values in a Hash Object */
/* Writing a Hash Object to a Table */
/* Hash Object Processing */
data work.countrycode;
   drop rc;
   length ContinentName $30;
   if _n_=1 then do;                                    /*1*/
      call missing (ContinentName);                     /*2*/
      declare hash ContName();                          /*3*/
      ContName.definekey('ContinentID');                /*4*/
      ContName.definedata('ContinentName');             /*5*/
      ContName.definedone();                            /*6*/
      ContName.add(key: 91, data: 'North America');     /*7*/
      ContName.add(key: 93, data: 'Europe');
      ContName.add(key: 94, data: 'Africa');
      ContName.add(key: 95, data: 'Asia');
      ContName.add(key: 96, data: 'Australia/Pacific');
   end;                                                 /*8*/
   set certadv.country                                  /*9*/
            (keep=ContinentID Country CountryName);
   rc=ContName.find();                                  /*10*/
run;                                                    /*11*/
proc print data=work.countrycode noobs;
run;

/* Using Hash Iterator Objects */
* Example: Using the Hash Iterator Object;

data work.topbottom;
   drop i;
   if _N_=1 then do;
      if 0 then set certadv.Orderfact (keep=CustomerID 
                                      ProductID TotalRetailPrice);
      declare hash customer(dataset: 'certadv.Orderfact',
                            ordered: 'descending');
      customer.definekey('TotalRetailPrice', 'CustomerID');
      customer.definedata('TotalRetailPrice', 'CustomerID',
                          'ProductID');
      customer.definedone();
      declare hiter C('customer');
end;
   C.first();
   do i=1 to 2;
      output work.topbottom;
      C.next();
   end;
   C.last();
   do i=1 to 2;
      output work.topbottom;
      C.prev();
   end;
   stop;
run;

proc print data = work.topbottom;
run;
