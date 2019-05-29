* Example 16 The LENGTH, LENGTHN, and LENGTHC Functions;
data how_long;    
one = 'ABC   ';    
two = ' '; /* character missing value */    
three = 'ABC   XYZ';    
	length_one = length(one);    
	lengthn_one = lengthn(one);    
	lengthc_one = lengthc(one);    
	length_two = length(two);    
	lengthn_two = lengthn(two);    
	lengthc_two = lengthc(two);    
	length_three = length(three);    
	lengthn_three = lengthn(three);    
	lengthc_three = lengthc(three); 
run; 
title "Listing of Data Set HOW_LONG"; 
proc print data=how_long noobs; 
run;

* NOTE The LENGTHC function (V9) returns the storage length 
of character variables.  The other two functions, LENGTH and 
LENGTHN both return the length of a character variable not 
counting trailing blanks. ;
* The only difference between LENGTH and LENGTHN is that
LENGTHN returns a 0 for a null string while LENGTH returns a 1;

* Example 17 Comparing Two Strings Using the COMPARE Function ;
* Example Counting Occurrences of Characters or Substrings 
Using the COUNT and COUNTC Functions ;

data Dracula; /* Get it – Count Dracula */    
	input string $20.;    
	count_a_or_b = count(string,'ab');    
	countc_a_or_b = countc(string,'ab');    
	count_abc = count(string,'abc');    
	countc_abc = countc(string,'abc');    
	case_a = countc(string,'a','i'); 
datalines; 
xxabcxabcxxbbbb 
cbacba 
aaAA 
; 
title "Listing of Data Set DRACULA"; 
proc print data=Dracula noobs; 
run;




