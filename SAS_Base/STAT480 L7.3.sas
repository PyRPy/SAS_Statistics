* 7.3 - Execution Phase;
* Example 7.3. The following SAS program reads in various measurements of 
six different trees into a data set called trees, and while doing so 
calculates the volume of each tree:;

OPTIONS PS = 58 LS = 72 NODATE NONUMBER;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght_ft)*(0.0000163*circ_in**2);
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

PROC PRINT data = trees;
RUN;

* 7.4 - DATA Step Debugger;
* Example 7.5. The following DATA step is identical to the one that appears 
in Example 7.3, except here the DATA step debugger has been invoked by 
adding the DEBUG option to the end of the DATA statement:;

* cannot be used in the U version;

DATA trees / DEBUG;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght_ft)*(0.0000163*circ_in**2);
	DATALINES;
oak, black        222 105 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* Example 7.6. At first glance, you might look at the following program 
and think that it is identical to the one in the previous example. 
If you look at the zero that appears in the value 105 in the "oak, black" 
record, however, you might notice that it is a little rounder than 
other zeroes that you've seen. That's because it is the letter O and 
not the number 0. When we ask SAS to execute the program, we should 
therefore expect an error when SAS tries to read the character value "1O5" 
in the first record for the numeric variable hght_ft. Let's use the SAS 
debugger again to see the behind the scenes execution of this program:;

DATA trees;
    input type $ 1-16 circ_in hght_ft crown_ft;
	volume = (0.319*hght_ft)*(0.0000163*circ_in**2);
	DATALINES;
oak, black        222 1O5 112
hemlock, eastern  149 138  52
ash, white        258  80  70
cherry, black     187  91  75
maple, red        210  99  74
elm, american     229 127 104
;
RUN;

* 7.5 - Types of Log Messages;
* Example 7.7. The following code causes SAS to print an ERROR message in 
the log window:;

DATA one;
  input A B C;
	DATALINES;
	1 2 3
	4 5 6
    7 8 9
	;
RUN;

*PROC PRINT / DATA = one;
PROC PRINT  DATA = one;
RUN;

* Example 7.8. The location of an error is typically easy to find, 
because it is usually underlined, but it is often tricky trying to 
figure out the source of the error. Sometimes what is wrong in the 
program is not what is underlined in the log window but something 
else earlier in the program. The following program illustrates 
such an event:;

DATA one;
    INPUT A B C;
	DATALINES;
	1 2 3
	4 5 6
	7 8 9
	;
RUN;

* Example 7.9. The following code results in SAS printing a WARNING 
message in the log window:;

DATA example2;
   IMPUT a b c;
   DATALINES;
112 234 345
115 367   .
190 110 111
;
RUN;

* Example 7.10. The following code results in SAS printing a NOTE 
in the log window:;
DATA example2;
   INFILE DATALINES MISSOVER;
   INPUT a b c;
   DATALINES;
112 234 345
115 367
190 110 111
;
RUN;

* Example 7.11. Beware that not every NOTE that appears in the log 
window is a problem. The following code is an example in which SAS 
going to the new line is exactly what is wanted:;
DATA example2;
   INPUT a b c;
   DATALINES;
101
111
118
215
620
910
;
RUN;

PROC PRINT data = example2;
RUN;










