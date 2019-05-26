* Lesson 19: Processing Variables with Arrays;
* 19.1 - One-Dimensional Arrays;
* Example 19.1. The following program simply reads in the 
average montly temperatures (in Celsius) for ten different 
cities in the United States into a temporary SAS data set 
called avgcelsius:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA avgcelsius;
    input City $ 1-18 jan feb mar apr may jun 
                      jul aug sep oct nov dec;
    DATALINES;
State College, PA  -2 -2  2  8 14 19 21 20 16 10  4 -1
Miami, FL          20 20 22 23 26 27 28 28 27 26 23 20
St. Louis, MO      -1  1  6 13 18 23 26 25 21 15  7  1
New Orleans, LA    11 13 16 20 23 27 27 27 26 21 16 12
Madison, WI        -8 -5  0  7 14 19 22 20 16 10  2 -5
Houston, TX        10 12 16 20 23 27 28 28 26 21 16 12
Phoenix, AZ        12 14 16 21 26 31 33 32 30 23 16 12
Seattle, WA         5  6  7 10 13 16 18 18 16 12  8  6
San Francisco, CA  10 12 12 13 14 15 15 16 17 16 14 11
San Diego, CA      13 14 15 16 17 19 21 22 21 19 16 14
;
RUN;

PROC PRINT data = avgcelsius;
    title 'Average Monthly Temperatures in Celsius';
	id City;
	var jan feb mar apr may jun 
        jul aug sep oct nov dec;
RUN;

* to convert the Celsius temperatures in the avgcelsius data 
set to Fahrenheit temperatures stored in a new data set called 
avgfahrenheit:;
DATA avgfahrenheit;
    set avgcelsius;
    janf = 1.8*jan + 32;  	
    febf = 1.8*feb + 32;
	marf = 1.8*mar + 32;	
    aprf = 1.8*apr + 32;
	mayf = 1.8*may + 32;	
    junf = 1.8*jun + 32;
	julf = 1.8*jul + 32;	
    augf = 1.8*aug + 32;
	sepf = 1.8*sep + 32;	
    octf = 1.8*oct + 32;
	novf = 1.8*nov + 32;	
    decf = 1.8*dec + 32;
	drop jan feb mar apr may jun 
         jul aug sep oct nov dec;
RUN;

PROC PRINT data = avgfahrenheit;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var janf febf marf aprf mayf junf 
        julf augf sepf octf novf decf;
RUN;

* Example 19.2. The following program uses a one-dimensional 
array called fahr to convert the average Celsius temperatures 
in the avgcelsius data set to average Fahrenheit temperatures 
stored in a new data set called avgfahrenheit:;

DATA avgfahrenheit;
    set avgcelsius;
	array fahr(12) jan feb mar apr may jun
                   jul aug sep oct nov dec;
	do i = 1 to 12;
	      fahr(i) = 1.8*fahr(i) + 32;  	
    end;
RUN;

PROC PRINT data = avgfahrenheit;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var jan feb mar apr may jun 
        jul aug sep oct nov dec;
RUN;

* Example 19.3. The following program is identical to the 
program in the previous example, except the 12 in the ARRAY 
statement has been changed to an asterisk (*):;
DATA avgfahrenheittwo;
    set avgcelsius;
	array fahr(*) jan feb mar apr may jun
                  jul aug sep oct nov dec;
	do i = 1 to 12;
	      fahr(i) = 1.8*fahr(i) + 32;  	
    end;
RUN;

PROC PRINT data = avgfahrenheittwo;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var jan feb mar apr may jun 
        jul aug sep oct nov dec;
RUN;

* Example 19.4. The following program re-reads the average 
monthly temperatures of the ten cities into numbered variables 
m1, m2, ..., m12, and then uses a numbered range list m1-m12 
as a shortcut in specifying the elements of the fahr array in 
the ARRAY statement:;

DATA avgtempsF;
    input City $ 1-18 m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12;
	array fahr(*) m1-m12;
	do i = 1 to 12;
	      fahr(i) = 1.8*fahr(i) + 32;  	
    end;
    DATALINES;
State College, PA  -2 -2  2  8 14 19 21 20 16 10  4 -1
Miami, FL          20 20 22 23 26 27 28 28 27 26 23 20
St. Louis, MO      -1  1  6 13 18 23 26 25 21 15  7  1
New Orleans, LA    11 13 16 20 23 27 27 27 26 21 16 12
Madison, WI        -8 -5  0  7 14 19 22 20 16 10  2 -5
Houston, TX        10 12 16 20 23 27 28 28 26 21 16 12
Phoenix, AZ        12 14 16 21 26 31 33 32 30 23 16 12
Seattle, WA         5  6  7 10 13 16 18 18 16 12  8  6
San Francisco, CA  10 12 12 13 14 15 15 16 17 16 14 11
San Diego, CA      13 14 15 16 17 19 21 22 21 19 16 14
;
RUN;

PROC PRINT data = avgtempsF;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var m1-m12;
RUN;

* Example 19.5. The following program re-reads the average 
monthly temperatures of the ten cities into month variables 
jan, feb, ..., dec, and then uses the special _NUMERIC_ list 
as a shortcut in specifying the elements of the fahr array 
in the ARRAY statement:;
DATA avgtempsFtwo;
    input City $ 1-18 jan feb mar apr may jun 
                      jul aug sep oct nov dec;
	array fahr(*) _NUMERIC_;
	do i = 1 to 12;
	      fahr(i) = 1.8*fahr(i) + 32;  	
    end;
    DATALINES;
State College, PA  -2 -2  2  8 14 19 21 20 16 10  4 -1
Miami, FL          20 20 22 23 26 27 28 28 27 26 23 20
St. Louis, MO      -1  1  6 13 18 23 26 25 21 15  7  1
New Orleans, LA    11 13 16 20 23 27 27 27 26 21 16 12
Madison, WI        -8 -5  0  7 14 19 22 20 16 10  2 -5
Houston, TX        10 12 16 20 23 27 28 28 26 21 16 12
Phoenix, AZ        12 14 16 21 26 31 33 32 30 23 16 12
Seattle, WA         5  6  7 10 13 16 18 18 16 12  8  6
San Francisco, CA  10 12 12 13 14 15 15 16 17 16 14 11
San Diego, CA      13 14 15 16 17 19 21 22 21 19 16 14
;
RUN;

PROC PRINT data = avgtempsFtwo;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var jan--dec;
RUN;

* 19.2 - Processing of Arrays;
* Example 19.6. The following program is identical to the 
program in Example 19.2. That is, the program uses a 
one-dimensional array called fahr to convert the average 
Celsius temperatures in the avgcelsius data set to average 
Fahrenheit temperatures stored in a new data set called 
avgfahrenheit:;

DATA avgfahrenheit;
    set avgcelsius;
	array fahr(12) jan feb mar apr may jun
                   jul aug sep oct nov dec;
	do i = 1 to 12;
	      fahr(i) = 1.8*fahr(i) + 32;  	
    end;
RUN;

PROC PRINT data = avgfahrenheit;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var jan feb mar apr may jun 
        jul aug sep oct nov dec;
RUN;

* NOTE As always, at the end of the compile phase, SAS 
will have created a program data vector containing the 
automatic variables ( _N_ and _ERROR_), the variables 
from the input data set avgcelsius (that is, City, jan, 
feb, ..., dec), and any newly created variables in the 
DATA step (the DO loop's index variable i);


* 19.3 - Creating Variables in an Array Statement;
* Example 19.7. The following program again converts the 
average monthly Celsius temperatures in ten cities to 
average montly Fahrenheit temperatures. To do so, the 
already existing Celsius temperatures, jan, feb, ..., 
and dec, are grouped into an array called celsius, and 
the resulting Fahrenheit temperatures are stored in new 
variables janf, febf, ..., decf, which are grouped into 
an array called fahr:;

DATA avgtemps;
    set avgcelsius;
	array celsius(12) jan feb mar apr may jun 
                      jul aug sep oct nov dec;
	array fahr(12) janf febf marf aprf mayf junf
                   julf augf sepf octf novf decf;
	do i = 1 to 12;
	      fahr(i) = 1.8*celsius(i) + 32;  	
    end;
RUN;

PROC PRINT data = avgtemps;
    title 'Average Monthly Temperatures';
	id City;
	var jan janf feb febf mar marf;
    var apr aprf may mayf jun junf;
    var jul julf aug augf sep sepf;
    var oct octf nov novf dec decf;
RUN;

* The DATA step should look eerily similar to that of 
Example 7.6. The only thing that differs here is rather 
than writing over the Celsius temperatures, they are 
preserved by storing the calculated Fahrenheit temperatures 
in new variables called janf, febf, ..., and decf. ;

* Example 19.8. The following program is identical to the 
previous program, except this time rather than naming the 
new variables grouped into the fahr array, we let SAS do 
the naming for us:;

DATA avgtempsinF;
    set avgcelsius;
	array celsius(12) jan feb mar apr may jun 
                      jul aug sep oct nov dec;
	array fahr(12);
	do i = 1 to 12;
	      fahr(i) = 1.8*celsius(i) + 32;  	
    end;
RUN;

PROC PRINT data = avgtempsinF;
    title 'Average Monthly Temperatures in Fahrenheit';
	id City;
	var fahr1-fahr12;
RUN;

* 19.4 - Temporary Array Elements;
* Example 19.9. The following program first reads a subset of 
Quality of Life data (variables qul3a, qul3b, ..., and qul3j) 
into a SAS data set called qul. Then, the program checks to 
make sure that the values for each variable have been recorded 
as either a 1, 2, or 3 as would be expected from the data form. 
If a value for one of the variables does not equal 1, 2, or 3, 
then that observation is output to a data set called errors. 
Otherwise, the observation is output to the qul data set. Because 
the error checking takes places without using arrays, the 
program contains a series of ten if/then statements, corresponding 
to each of the ten concerned variables:;

DATA qul errors;
   input subj qul3a qul3b qul3c qul3d qul3e 
              qul3f qul3g qul3h qul3i qul3j;
   flag = 0;
   if qul3a not in (1, 2, 3) then flag = 1;
   if qul3b not in (1, 2, 3) then flag = 1;
   if qul3c not in (1, 2, 3) then flag = 1;
   if qul3d not in (1, 2, 3) then flag = 1;
   if qul3e not in (1, 2, 3) then flag = 1;
   if qul3f not in (1, 2, 3) then flag = 1;
   if qul3g not in (1, 2, 3) then flag = 1;
   if qul3h not in (1, 2, 3) then flag = 1;
   if qul3i not in (1, 2, 3) then flag = 1;
   if qul3j not in (1, 2, 3) then flag = 1;
   if flag = 1 then output errors;
               else output qul;
   drop flag;
   DATALINES;
   110011 1 2 3 3 3 3 2 1 1 3
   210012 2 3 4 1 2 2 3 3 1 1
   211011 1 2 3 2 1 2 3 2 1 3
   310017 1 2 3 3 3 3 3 2 2 1
   411020 4 3 3 3 3 2 2 2 2 2
   510001 1 1 1 1 1 1 2 1 2 2
   ;
RUN;
PROC PRINT data = qul;
   TITLE 'Observations in Qul data set with no errors';
RUN;
PROC PRINT data = errors;
   TITLE 'Observations in Qul data set with errors';
RUN;

* Example 19.10. The following program performs the same error 
checking as the previous program except here the error checking 
is accomplished using two arrays, bounds and quldata:;
DATA qul errors;
   input subj qul3a qul3b qul3c qul3d qul3e 
              qul3f qul3g qul3h qul3i qul3j;
   array bounds (3) error1 - error3 (1 2 3);
   array quldata (10) qul3a -- qul3j;
   flag = 0;
   do i = 1 to 10;
      if quldata(i) ne bounds(1) and
         quldata(i) ne bounds(2) and
         quldata(i) ne bounds(3)   
      then flag = 1;
   end;
   if flag = 1 then output errors;
               else output qul;
   drop i flag;
   DATALINES;
   110011 1 2 3 3 3 3 2 1 1 3
   210012 2 3 4 1 2 2 3 3 1 1
   211011 1 2 3 2 1 2 3 2 1 3
   310017 1 2 3 3 3 3 3 2 2 1
   411020 4 3 3 3 3 2 2 2 2 2
   510001 1 1 1 1 1 1 2 1 2 2
   ;
RUN;

PROC PRINT data = qul;
   TITLE 'Observations in Qul data set with no errors';
RUN;

PROC PRINT data = errors;
   TITLE 'Observations in Qul data set with errors';
RUN;

* Example 19.11. The valid values 1, 2, and 3 are needed only 
temporarily in the previous program. Therefore, we alternatively 
could have used temporary array elements in defining the bounds 
array. The following program does just that. It is identical to 
the previous program except here the bounds array is defined 
using temporary array elements rather than using three new 
variables error1, error2, and error3:;

DATA qul errors;
   input subj qul3a qul3b qul3c qul3d qul3e 
              qul3f qul3g qul3h qul3i qul3j;
   array bounds (3) _TEMPORARY_ (1 2 3);
   array quldata (10) qul3a -- qul3j;
   flag = 0;
   do i = 1 to 10;
      if quldata(i) ne bounds(1) and
         quldata(i) ne bounds(2) and
         quldata(i) ne bounds(3)   
      then flag = 1;
   end;
   if flag = 1 then output errors;
               else output qul;
   drop i flag;
   DATALINES;
   110011 1 2 3 3 3 3 2 1 1 3
   210012 2 3 4 1 2 2 3 3 1 1
   211011 1 2 3 2 1 2 3 2 1 3
   310017 1 2 3 3 3 3 3 2 2 1
   411020 4 3 3 3 3 2 2 2 2 2
   510001 1 1 1 1 1 1 2 1 2 2
   ;
RUN;

PROC PRINT data = qul;
   TITLE 'Observations in Qul data set with no errors';
RUN;

PROC PRINT data = errors;
   TITLE 'Observations in Qul data set with errors';
RUN;

* If you compare this program to the previous program, 
you'll see that the only difference here is the presence 
of the _TEMPORARY_ argument in the definition of the 
bounds array. The bounds array is again initialized to 
the three valid values "(1 2 3)".

Launch and run the SAS program. Review the output to convince 
yourself that just as before qul contains the four observations 
with clean data, and errors contains the two observations 
with bad data. Also, note that the temporary array elements 
do not appear in the data set.;
