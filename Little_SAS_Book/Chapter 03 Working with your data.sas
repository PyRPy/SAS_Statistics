*** Chapter 03 Working with your data *** ;
*** 3.11 simplifing programs with arrays *** ;
* change all 9s to missing values;
data songs;
	infile 'Documents\My SAS Files\LSB5data\MyRawData\kbrk.dat';
	input city $ 1-15 age wi kt tr filp ttr;
	array song(5) wi kt tr filp ttr;
	do i = 1 to 5;
		if song(i) = 9 then song(i) = .;
	end;
run;

proc print data = songs;
	title 'kbrk song survey';
run;
