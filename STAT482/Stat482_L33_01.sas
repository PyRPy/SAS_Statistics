*** Stat482_L33_01 *** ;

*** SUBSTITUTING TEXT WITH %LET *** ;
options ps = 58 ls = 72 nodate nonumber;
data models;
	infile datalines truncover;
	input model $ 1-12 class $ price frame$ 28-38;
	datalines;
Black Bora   Track     796 Aluminum
Delta Breeze Road      399 CroMoly
Jet Stream   Track    1130 CroMoly
Mistral      Road     1995 Carbon Comp
Nor'easter   Mountain  899 Aluminum
Santa Ana    Mountain  459 Aluminum
Scirocco     Mountain 2256 Titanium
Trade Wind   Road      759 Aluminum
;
run;
%let bikeclass = Mountain;

proc print data = models noobs;
	where class = "&bikeclass";
	format price dollar6.;
	title "current models of &bikeclass bicyles";
run;

*** CREATING MODULAR CODE WITH MACROS *** ;
%macro printit;
proc print data = models noobs;
	title 'current models';
	var model class frame price;
	format price dollar6.;
run;
%mend printit;

proc sort data = models;
	by price;
run;

%printit

*** ADDING PARAMETERS TO MACROS *** ;
%macro sortandprint(sortseq=, sortvar=);
proc sort data = models;
	by &sortseq &sortvar;
run;

proc print data = models noobs;
	title 'current models';
	title2 'sorted by &sortseq &sortvar';
	var model class frame price;
	format price dollar6.;
run;
%mend sortandprint;

%sortandprint(sortseq = descending, sortvar = price)
%sortandprint(sortseq=, sortvar=class)

* mprint - another extended example ;
options mprint;

%macro sortandprint(sortseq=, sortvar=);
	proc sort data = models;
	by &sortseq &sortvar;
	run;

	proc print data = models noobs;
		title 'current models';
		title2 'sorted by &sortseq &sortvar';
		var model class frame price;
		format price dollar6.;
	run;
	%mend sortandprint;

	%sortandprint(sortseq = descending, sortvar = price)
	%sortandprint(sortseq=, sortvar=class)

*** CONDITIONAL LOGIC *** ;

data orders;
	input customerID $ 1-3 @5 orderDate date7. model $ 13-24 quantity ;
datalines;
287 15OCT03 Delta Breeze 15
287 15OCT03 Santa Ana    15
274 16OCT03 Jet Stream    1
174 17OCT03 Santa Ana    20
174 17OCT03 Nor'Easter    5
174 17OCT03 Scirocco      1
347 18OCT03 Mistral       1
287 21OCT03 Delta Breeze 30
287 21OCT03 Santa Ana    25
;
run;

%macro reports;
	%if &sysday = monday %then %do;
		proc print data = orders noobs;
			format orderdate date7.;
			title "&sysday report: current orders";
		run;
	%end;
	%else %if &sysday = saturday %then %do;
		proc tabulate data = orders;
			class customerID;
			var Quantity;
			table customerID all, quantity;
			title "&sysday report: summary of orders";
		run;
	%end;
%mend reports;

%reports

*** DATA-DRIVEN PROGRAMS *** ;
proc sort data = orders;;
	by descending quantity;
run;

data _null_;
	set orders;
	if _n_ = 1 then call symput("biggest", customerID);
	else stop;
run;

proc print data = orders noobs;
	where customerID = "&biggest";
	format orderdate date7.;
	title 'customer &biggest had the single largest order';
run;
