* An Introduction to SAS® Character Functions
Ronald Cody, Ed.D.;


* Example 1 Converting Multiple Blanks to a Single Blank;
data multiple;    
	input #1 @1  name    $20.          
		  #2 @1  address $30.          
		  #3 @1  city    $15.             
			 @20 state    $2.             
			 @25 zip      $5.;    
	name = compbl(name);    
	address = compbl(address);    
	city = compbl(city); 
datalines; 
Ron Cody
89 Lazy Brook Road 
Flemington         NJ   08822 
Bill     Brown 
28   Cathy   Street 
North   City       NY   11518 
; 
title "Listing of Data Set MULTIPLE"; 
proc print data=multiple noobs;    
	id name;    
	var address city state zip; 
run; 
* NOTE This seemingly difficult task is accomplished in a 
single line using the COMPBL function.  It COMPresses 
successive  blanks to a single blank.  How useful!;

* Example 2 How to Remove Characters from a String
Here comes the COMPRESS function to the rescue!  
The COMPRESS function can remove any number of specified 
characters from a character variable.  The program below 
uses the COMPRESS function twice.  The first time, to remove 
blanks from the string. the second to remove blanks plus the 
other above mentioned characters.  Here is the code: 
;

data phone;    
	input phone $ 1-15;    
	phone1 = compress(phone);    
	phone2 = compress(phone,'(-) '); 
datalines; 
(908)235-4490 
(201) 555-77 99 
; 
title "Listing of Data Set PHONE"; 
proc print data=phone noobs; 
run; 
 
* Example 3 : charactor data verification
In the example below, only the values 'A', 'B', 'C', 'D', 
and 'E' are valid data values.  A very easy way to test 
if there are any invalid characters present is shown next:;

data verify;    
	input @1  id $3.          
		  @5  answer $5.;    
	position = verify(answer,'abcde'); 
datalines; 
001 acbed 
002 abxde 
003 12cce 
004 abc e ; 
title "Listing of Data Set VERIFY"; 
proc print data=verify noobs; 
run;

* NOTE  It inspects every character in the first argument 
and, if it finds any value not in the verify string (the 
second argument), it will return the position of the first 
offending value.  If all the values of the string are located 
in the verify string, a value of 0 is returned. ;
/* 
data trailing;    
length string $ 10;    
string = 'abc';    
pos = verify(string,'abcde'); 
run; 
*/

* Example 4 substring example;
data pieces_parts;    
	input id $ 1-9;    
	length state $ 2;    
	state = substr(id,1,2);    
	num = input(substr(id,7,3),3.); 
datalines; 
NYXXXX123 
NJ1234567 
; 
title "Listing of Data Set PIECES_PARTS"; 
proc print data= pieces_parts noobs; 
run;

* Example 5 Using the SUBSTR Function on the Left-Hand Side of the Equal Sign;

data pressure;    
	input sbp dbp @@;    
	length sbp_chk dbp_chk $ 4;    
	sbp_chk = put(sbp,3.);    
	dbp_chk = put(dbp,3.);    
	if sbp gt 160 then       
		substr(sbp_chk,4,1) = '*';    
	if dbp gt 90 then       
		substr(dbp_chk,4,1) = '*'; 
datalines; 
120 80 180 92 200 110 
; 
title "Listing of Data Set PRESSURE"; 
proc print data=pressure noobs; 
run;

* Example 6 unpacking a string;
* save some disk space ?;
data pack;    
	input string $ 1-5; 
datalines; 
12345 
8 642 
; 
data unpack;    
	set pack;    
	array x[5];    
	do j = 1 to 5;       
		x[j] = input(substr(string,j,1),1.);    
	end;    
	drop j; 
run; 
 
title "Listing of Data Set UNPACK"; 
proc print data=unpack noobs; 
run; 

* Example 7 parsing a string;
data parse;     
	input long_str $ 1-80;    
	array pieces[5] $ 10          
		piece1-piece5;    
	do i = 1 to 5;       
	pieces[i] = scan(long_str,i,',.! ');    
	end;    
	drop long_str i; 
datalines; 
this line,contains!five.words 
abcdefghijkl xxx yyy 
; 
title "Listing of Data Set PARSE"; 
proc print data=parse noobs; 
run; 

* exmaple 8 Using the SCAN Function to Extract a Last Name;
data first_last;    
	input @1  name  $20.          
		  @21 phone $13.;    
	***extract the last name from name;    
	last_name = scan(name,-1,' '); /* scans from the right */ 
datalines; 
Jeff W. Snoker       (908)782-4382 
Raymond Albert       (732)235-4444 
Alfred Edward Newman (800)123-4321 
Steven J. Foster     (201)567-9876 
Jose Romerez         (516)593-2377 
; 
title "Names and Phone Numbers in Alphabetical Order (by Last Name)"; 
proc report data=first_last nowd;    
	columns name phone last_name;    
	define last_name / order noprint width=20;    
	define name      / display 'Name' left width=20;    
	define phone     / display 'Phone Number' width=13 format=$13.; 
run;
* NOTE It is easy to extract the last name by using a –1 
as the second argument of the SCAN function.  Remember, 
a negative value for this arguments results in a scan 
from right to left. ;

* Eaxample 9 Locating the Position of One String Within Another String;

data locate;    
input string $ 1-10;    
first = index(string,'xyz');    
first_c = indexc(string,'x','y','z'); 
datalines; 
abcxyz1234 
1234567890 
abcx1y2z39 
abczzzxyz3 
; 
title "Listing of Data Set LOCATE"; 
proc print data=locate noobs; 
run; 

* Example 10 Changing Lower Case to Upper Case and Vice Versa ;
* page - 10;
data up_down;    
	length a b c d e $ 1;    
	input a b c d e x y; 
datalines; 
M f P p D 1 2 
m f m F M 3 4 
; 
data upper;    
	set up_down;    
	array all_c[*] _character_;    
	do i = 1 to dim(all_c);       
		all_c[I] = upcase(all_c[i]);    
	end;    
	drop i; 
run; 
 
title "Listing of Data Set UPPER"; 
proc print data=upper noobs; 
run;

* Example 11 Converting String to Proper Case ;
data proper;    
input Name $40.; 
datalines; 
rOn coDY 
the tall and the short 
the "%$#@!" escape 
; 
title "Listing of Data Set PROPER"; 
proc print data=proper noobs; 
run; 
