/************************************************
 This program reads in a set of grades for six
 students, and prints out their student numbers 
 and genders.
 ************************************************/

 OPTIONS NODATE LS=78; 
 TITLE "Example: getting started with SAS"; 

 DATA grade;
   	InPuT subject gender $
		exam1 exam2 hwgrade $; 
   DATALINES; 
   10 M 80 84 A 
    7 . 85 89 A 
    4 F 90 .  B 
   20 M 82 85 B 
   25 F 94 94 A 
   14 F 88 84 C 
   ; 
 RUN;

 PROC PRINT data=grade;  
    var subject gender hwgrade;  *print student ID and gender;
 RUN;


