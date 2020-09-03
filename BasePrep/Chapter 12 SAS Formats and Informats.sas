/** Chapter 12: SAS Formats and Informats **/
/** Applying SAS Formats and Informats **/
proc print data=cert.admit;
  var actlevel fee;
  where actlevel='HIGH';
  format fee dollar4.;
run;
/** The FORMAT Procedure **/

/* Defining a Unique Format */
proc format;
   value gender 	
              1 = 'Male'
              2 = 'Female';
   value agegroup  
             13 -< 20  = 'Teen'
             20 -< 65  = 'Adult'
             65 - HIGH = 'Senior';
   value $col 		
             'W' = 'Moon White'
             'B' = 'Sky Blue'
             'Y' = 'Sunburst Yellow'
             'G' = 'Rain Cloud Gray';
run;

proc format lib=formtlib; 
   value $col 
         'W' = 'Moon White' 
         'B' = 'Sky Blue' 
         'Y' = 'Sunburst Yellow' 
         'G' = 'Rain Cloud Gray'; 
run;

* Specifying Value Ranges;
proc format lib=formtlib; 
   value agefmt 
         0-<13='child' 
         13-<20='teenager' 
         20-<65='adult' 
         65-100='senior citizen'; 
run;

proc format lib=formtlib; 
   value agefmt 
         low-<13='child' 
         13-<20='teenager' 
         20-<65='adult' 
         65-high='senior citizen' 
         other='unknown'; 
run;

proc format;
   value gender 	
              1 = 'Male'
              2 = 'Female';
   value agegroup  
             13 -< 20  = 'Teen'
             20 -< 65  = 'Adult'
             65 - HIGH = 'Senior';
   value $col 		
             'W' = 'Moon White'
             'B' = 'Sky Blue'
             'Y' = 'Sunburst Yellow'
             'G' = 'Rain Cloud Gray';
run;

/* Associating User-Defined Formats with Variables */
data work.carsurvey;
  set cert.cars;
  format Sex gender. Age agegroup. Color $col. Income Dollar8.;
run;
