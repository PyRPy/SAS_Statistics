* ice.cream.sas, ice cream experiment, Section 17.10.2, pp656-7;
;
* Text p656;
DATA ICE; 
  INPUT FLAVOR MELTTIME ORDER; 
  X=ORDER-16.5; 
  X2=X*X; 
  LINES;
   1  924  1
   1  876  2
   1 1150  5
   1 1053  7
   1 1041 10
   1 1037 12
   1 1125 15
   1 1075 16
   1 1066 20
   1  977 22
   1  886 25
   2  891  3
   2  982  4
   2 1041  8
   2 1135 13
   2 1019 14
   2 1093 18
   2  994 27
   2  960 30
   2  889 31
   2  967 32
   2  838 33
   3  817  6
   3 1032  9
   3  844 11
   3  841 17
   3  785 19
   3  823 21
   3  846 23
   3  840 24
   3  848 26
   3  848 28
   3  832 29
;
* Text p657;
PROC GLM; 
  CLASS FLAVOR; 
  MODEL MELTTIME = X X2 FLAVOR; 
  RANDOM FLAVOR / TEST;  
;
* Generate Figure 17.7, p657;
PROC GLM;
  CLASS FLAVOR;
  MODEL MELTTIME = FLAVOR;
  OUTPUT OUT=STATS RESIDUAL=Z;
PROC STANDARD STD=1.0;
  VAR Z;
PROC SGPLOT;
  SCATTER Y=Z X=ORDER; 
  REFLINE 0 / AXIS=Y;
;
run;

* Fig. 17.9 SAS software sample size calculations for the ice cream experiment;
DATA POWER;
	ALPHA=0.05; POWER=0.95;
	DO R=11,3;
		RATIO = (2*R+1)/(R+1);
		RESULT="Need more data";
		V=1;
		DO WHILE (RESULT="Need more data" and V < 201);
		V=V+1;
		DF1=V-1; DF2=V*(R-1);
		F1 = FINV(1-ALPHA,DF1,DF2); * Compute F(DF1,DF2,ALPHA);
		F2 = FINV(POWER,DF2,DF1); * Compute F(DF2,DF1,1-POWER);
		PRODUCT=F1*F2;
		IF PRODUCT < RATIO THEN RESULT="Enough data";
		END;
		OUTPUT; * Output results to data set;
	END; * End R loop;
;
PROC PRINT DATA = POWER;
	VAR R V RESULT POWER ALPHA F1 F2 PRODUCT RATIO DF1 DF2;
