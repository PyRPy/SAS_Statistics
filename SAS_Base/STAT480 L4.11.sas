* Example 4.11. The following SAS program illustrates how SAS tries to perform an 
automatic character-to-numeric conversion of standtest and e1, e2, e3, and e4 so that 
arithmetic operations can be performed on them:;

DATA grades;
	input name $ 1-15 e1 $ e2 $ e3 $ e4 $ standtest $;
	avg = round(mean(e1,e2,e3,e4),1); 
	std = standtest/4;
	DATALINES;
Alexander Smith   78 82 86 69   1,210
John Simon        88 72 86  .     990
Patricia Jones    98 92 92 99   1,010
Jack Benedict     54 63 71 49     875
Rene Porter      100 62 88 74   1,180
;
RUN;

PROC PRINT data = grades;
RUN;

* Example 4.12. The following SAS program illustrates the use of the INPUT function 
to convert the character variable standtest to a numeric variable explicitly so that 
an arithmetic operation can be performed on it:;

DATA grades;
	input name $ 1-15 e1 $ e2 $ e3 $ e4 $ standtest $;
	std = input(standtest,comma5.)/4;
	DATALINES;
Alexander Smith   78 82 86 69   1,210
John Simon        88 72 86  .     990
Patricia Jones    98 92 92 99   1,010
Jack Benedict     54 63 71 49     875
Rene Porter      100 62 88 74   1,180
;
RUN;

PROC PRINT data = grades;
   var name standtest std;
RUN;


