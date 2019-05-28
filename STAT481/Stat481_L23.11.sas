* Example 12 Substituting One Word for Another in a String ;
data convert;    
	input @1 address $20. ;    
	*** Convert Street, Avenue and    
	Boulevard to their abbreviations;    
	address = tranwrd(address,'Street','St.');    
	address = tranwrd (address,'Avenue','Ave.');    
	address = tranwrd (address,'Road','Rd.'); 
datalines; 
89 Lazy Brook Road  
123 River Rd. 
12 Main Street 
;
 
title "Listing of Data Set CONVERT"; 
proc print data=convert; 
run;

* Example 13 Fuzzy Merging: The SPEDIS Function;
* page - 11;
data compare;    
	length string1 string2 $ 15;    
	input string1 string2;    
	points = spedis(string1,string2); 
datalines; 
same same 
same sam 
firstletter xirstletter 
lastletter lastlettex 
receipt reciept 
; 
title "Listing of Data Set COMPARE"; 
proc print data=compare noobs; 
run; 

* NOTE The SPEDIS function measures the "spelling distance" 
between two strings.  If the two strings are identical, 
the function returns a 0.  For each category of spelling error, 
the function assigns "penalty" points.;

* Example 14 Demonstrating the "ANY" Functions;

data find_alpha_digit;    
input string $20.;    
first_alpha = anyalpha(string);    
first_digit = anydigit(string); 
datalines; 
no digits here 
the 3 and 4 
123 456 789 
;
title "Listing of Data Set FIND_ALPHA_DIGIT"; 
proc print data=find_alpha_digit noobs; 
run;
* These functions return the first position of a character 
of the appropriate class.  If no appropriate characters are 
found, the functions return a 0.;

* Example 15 Demonstrating the "NOT" Functions ;

data data_cleaning;    
	input string $20.;    
	only_alpha = notalpha(trim(string));    
	only_digit = notdigit(trim(string)); 
datalines; 
abcdefg 
1234567 
abc123 
1234abcd 
; 
title "Listing of Data Set DATA_CLEANING"; 
proc print data=data_cleaning noobs; 
run;

* The New Concatenation Function;
 
data join_up;    
	length cats $ 6 catx $ 17;    
	string1 = 'ABC   ';    
	string2 = '   XYZ   ';    
	string3 = '12345';    
	cats = cats(string1,string2);    
	catx = catx('***',string1,string2,string3); 
run; 
title "Listing of Data Set JOIN_UP"; 
proc print data=join_up noobs; 
run;

