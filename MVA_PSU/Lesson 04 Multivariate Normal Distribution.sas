/* Lesson 4: Multivariate Normal Distribution */
*** 4.2 - Bivariate Normal Distribution ;
options ls = 78;
title 'bivariate normal density';
%let r = 0.1;
data a;
	pi = 3.1416;
	do x1 = -4 to 4 by 0.1;
		do x2 = -4 to 4 by 0.1;
			phi = exp(-(x1*x1 - 2*&r*x1*x2 + x2*x2)/2/(1-&r*&r))/2/pi/sqrt(1-&r*&r);
			output;
		end;
	end;
run;

proc g3d;
	plot x1*x2 = phi / rotate=-20;
run;

*** Example - Calculating and Printing Mahalonobis Distances in SAS ***;
data nutrient;
	infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\nutrient.txt';
	input id x1 x2 x3 x4 x5;
run;

proc princomp std out = pcout;
	var x1 x2 x3 x4;
run;

data out mahal;
	set pcout;
	dist2 = uss(of prin1-prin4);
run;

proc contents data = mahal;
run;

*** Example 4-2: Q-Q Plot for Board Stiffness Data 888 ;
data boards;
	infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\T4-3.dat';
	input x1 x2 x3 x4;
run;

proc princomp std out = pcresult;
	var x1 x2 x3 x4;
run;

data mahal;
	set pcresult;
	dist2 = uss(of prin1-prin4);
run;

proc print;
	var dist2;
run;

proc sort;
	by dist2;
run;

data plotdata;
	set mahal;
prb = (_n_ - 0.5)/30;
chiquant = cinv(prb, 4);
run;

proc gplot;
plot dist2*chiquant;
run;
quit;

*** 4.7 - Example: Wechsler Adult Intelligence Scale ***;
options ls = 78;
title 'eigenvalues and eigenvectors - wechsler data';
data wechsler;
	infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wechsler.txt';
	input id info sim arith pict;
run;

proc print;
run;

proc princomp cov;
	var info sim arith pict;
run;

*** plot the 95% confidence ellipse corresponding to any specified 
variance-covariance matrix.;
options ls = 78;
title '95% CI prediction ellipse';
data a;
	pi = 2.d0 * arsin(1);
	do i = 0 to 200;
		theta = pi*i / 100;
		u = cos(theta);
		v = sin(theta);
		output;
	end;
run;

proc iml;
	create b var {x y};
	start ellipse;
		mu = {0, 0};
		sigma = {1.0000 0.000, 0.000 1.0000};
		lambda = eigval(sigma);
		e = eigvec(sigma);
		d = diag(sqrt(lambda));
		z = z*d*e`*sqrt(5.99);
		do i = 1 to nrow(z);
			x = z[i, 1];
			y = z[i, 2];
			append;
		end;
	finish;
	use a;
	read all var{u v} into z;
run ellipse;

proc gplot;
	axis1 order=-5 to 5 length=3 in;
	axis2 order = -5 to 5 length=3 in;
	plot y*x / vaxis=axis1 haxis=axis2 vref=0 href=0;
	symbol v = none l=1 i=join color=black;
run;

proc print data = z; * did not output;
run;
quit;
