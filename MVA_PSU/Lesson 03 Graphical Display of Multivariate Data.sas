/* Lesson 3: Graphical Display of Multivariate Data */
options ls = 78;
title 'example : nutrient intak data - description statistics';
data nutrient;
	infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\nutrient.txt';
	input id calcium iron protein a c;
	l_calciu = log(calcium);
	s_calciu = calcium**.5;
	s_s_calciu = calcium**.25;
	l_iron = log(iron);
	s_s_iron = iron**.25;
	l_prot = log(protein);
	s_s_prot = protein**.25;
	s_s_a = a**.25;
	s_s_c = c**.25;

run;

proc univariate data = nutrient;
	histogram calcium s_calciu s_s_calciu l_calciu;
run;

proc g3d data = nutrient;
	scatter iron*protein = calcium / rotate= 60;
run;
quit;

proc corr data = nutrient plots(maxpoints = 75000) = matrix;
	var s_s_calciu s_s_iron s_s_prot s_s_a s_s_c;
run;
