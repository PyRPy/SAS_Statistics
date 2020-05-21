
/* This program computes summary statistics and
   tests of univariate normality. It also creates
   a chi-square probability plot to test for
   multivariate normality. PROC IML is used to
   generate points for the chi-square probability
   plot, to compute a sample covariance matrix, 
   the sample mean vector, sample correlation 
   matrix, partial correlation matrix, and related 
   t-tests. This program is stored on the course web 
   page as trees.sas     */


DATA TREES;
  INFILE 'Documents\My SAS Files\STAT505_SAS\ISU\trees.dat';
  INPUT X1 X2 X3 X4 X5;
  LABEL X1 = PERCENTAGE CONTENT NITROGEN
        X2 = PERCENTAGE CONTENT PHOSPHOROUS
        X3 = PERCENTAGE CONTENT POTASSIUM
        X4 = PERCENTAGE CONTENT RESIDUAL ASH
        X5 = HEIGHT OF TREE IN CM;
run;

/* The data were collected by Leyton(1956)to 
   examine relationships between mineral 
   composition of foliage and the height of 
   8 year old Japanese larch trees. Mineral 
   contents were measured as percentages of 
   the dry weight of ground, dried needles
   collected from new needles growing just
   below the terminal shoot of each sampled  
   tree.  The data are stored in the file
   trees.dat */

/*   First print the data file  */

PROC PRINT DATA=TREES;
  Title "Layton Larch Tree Data";
  RUN;

/* You can make a scatterplot matrix and other
  data dipslays using the interactive data 
  analysis option in SAS.  Click on "Solutions"
  at the top of the SAS editing window.  
  Select "Analysis".  Then click on 
  "Interactive Data Analysis".  Assuming that
  you have run the previous lines in this code 
  to create the TREES data set, you can select
  the "Work" library and select the TREES data set.
  A spreadsheet containing the trees data will 
  appear.  Use the mouse to highlight columns 
  labelled X1 through X5.  Then click on the
  "analyze" button that now appears at the top 
  of the editing window and select scatter plot.  */ 

/*  Compute correlations  */

PROC CORR DATA=TREES;
  VAR X1-X5;
  RUN;

/* Display box plots */

DATA TREES; SET TREES;
  Z=1; run;

PROC BOXPLOT DATA=TREES;
  PLOT (X1-X5)*Z / BOXSTYLE=SCHEMATICID;
  run;

/* Check the quality of the data. Compute 
   summary statistics and tests of normality
   for each variable */

PROC UNIVARIATE DATA=TREES NORMAL;
  VAR X1-X5;
  RUN;

/*   Compute Q-Q plots  */

PROC RANK DATA=TREES NORMAL=BLOM OUT=TREES;
  VAR X1-X5; RANKS Q1-Q5;
  RUN;

PROC PRINT DATA=TREES;
run;

/* Create high quality graphs with SASGRAPH 

   Use the following to set up the graph for
   printing as a postscript plot on VINCENT 

goptions targetdevice=ps300 rotate=portrait;

    WINDOWS users can use the following 
    options */

goptions device=WIN target=ps rotate=portrait;

/* Specify features of the plot */

axis1 label=(f=swiss h=2.5  
      "Standard Normal Quantiles")
      ORDER = -2.5 to 2.5 by .5
      value=(f=triplex h=1.6)
      length= 5.5in;

axis2 label=(f=swiss h=2.5 a=90 r=0
       "Ordered Data ")
      value=(f=triplex h=2.0)
      length = 5.0in;

  SYMBOL1 V=CIRCLE H=2.0 ;

PROC GPLOT DATA=TREES;
  PLOT X1*Q1 / vaxis=axis2 haxis=axis1;
TITLE1 ls=1.5in H=3.0 F=swiss "NORMAL PROBABILITY PLOT";
TITLE2  H=2.3 F=swiss "X1: Nitrogen Content";
footnote ls=1.0in;
   RUN;

PROC GPLOT DATA=TREES;
  PLOT X2*Q2 / vaxis=axis2 haxis=axis1;
TITLE1 ls=1.5in H=3.0 F=swiss "NORMAL PROBABILITY PLOT";
TITLE2  H=2.3 F=swiss "X2: Phosphorous Content";
footnote ls=1.0in;
   RUN;

PROC GPLOT DATA=TREES;
  PLOT X3*Q3 / vaxis=axis2 haxis=axis1;
TITLE1 ls=1.5in H=3.0 F=swiss "NORMAL PROBABILITY PLOT";
TITLE2  H=2.3 F=swiss "X3: Potassium Content";
footnote ls=1.0in;
  RUN;

PROC GPLOT DATA=TREES;
  PLOT X4*Q4 / vaxis=axis2 haxis=axis1;
TITLE1 ls=1.5in H=3.0 F=swiss "NORMAL PROBABILITY PLOT";
TITLE2  H=2.3 F=swiss "X4: Residual Ash";
footnote ls=1.0in;
   RUN;

PROC GPLOT DATA=TREES;
  PLOT X5*Q5 / vaxis=axis2 haxis=axis1;
TITLE1 ls=1.5in H=3.0 F=swiss "NORMAL PROBABILITY PLOT";
TITLE2  H=2.3 F=swiss "X5: Tree Height";
footnote ls=1.0in;
   RUN;


/* Use PROC IML to compute summary statistics
   partial correlations, related t-tests,
   a chi-square Q-Q plot for assessing multivariate
   normality, and a goodness-of-fit test */

DATA TREES2; SET TREES;
  KEEP X1-X5;
  RUN;

PROC IML;
START NORMAL;
  USE TREES2;          /* Enter the data */
  READ ALL  INTO X;
N=NROW(X);             /* Number of observations is N */
P=NCOL(X);             /* Number of traits is p */
SUM=X[+, ];            /* Total for each trait */
A=X`*X-SUM`*SUM/N;     /* Corrected crossproducts matrix */
S=A/(N-1);             /* Sample covariance matrix */
XBAR=SUM/N;            /* Sample mean vector */
SCALE=INV(SQRT(DIAG(A)));
R=SCALE*A*SCALE;       /* Sample correlation matrix */
PTR=J(P,P);
TR=J(P,P);
DF=N-2;
DO I1=1 TO P;          /* T-tests for correlations */
  IP1=I1+1;
  DO I2=IP1 TO P;
    TR[I1,I2]=SQRT(N-2)#R[I1,I2]/SQRT(1-R[I1,I2]##2);
    TR[I2,I1]=TR[I1,I2];
    PTR[I1,I2]=(1-PROBT(ABS(TR[I1,I2]),DF))*2;
    PTR[I2,I1]=PTR[I1,I2];
  END;
END;
RINV=INV(R);           /* Partial Correlations */
SCALER=INV(SQRT(DIAG(RINV)));
PCORR=-SCALER*RINV*SCALER;
DO I = 1 TO P;
  PCORR[I,I]=1.0;
END;
PTPCORR=J(P,P);
TPCORR=J(P,P);
DF=N-P;
DO I1=1 TO P;  /* T-tests for partial correlations */
IP1=I1+1;
  DO I2=IP1 TO P;
    TPCORR[I1,I2]=SQRT(N-P)#PCORR[I1,I2]/
                  SQRT(1-PCORR[I1,I2]##2);
    TPCORR[I2,I1]=TPCORR[I1,I2];
    PTPCORR[I1,I2]=
        (1-PROBT(ABS(TPCORR[I1,I2]),DF))*2;
    PTPCORR[I2,I1]=PTPCORR[I1,I2];
  END;
END;

PRINT,,,,," THE SAMPLE MEAN VECTOR";
PRINT XBAR;
PRINT,,,,," THE SAMPLE CORRELATION MATRIX";
PRINT R;
PRINT,,,,," VALUES OF T-TESTS FOR ZERO CORRELATIONS";
PRINT TR;
PRINT,,,,," P-VALUES FOR THE T-TESTS FOR ZERO CORRELATIONS";
PRINT PTR;
PRINT,,,,," THE MATRIX OF PARTIAL CORRELATIONS CONTROLLING FOR";
PRINT "       ALL VARIABLES NOT IN THE PAIR";
PRINT PCORR;
PRINT,,,,," VALUES OF T-TESTS FOR PARTIAL CORRELATIONS";
PRINT TPCORR;
PRINT,,,,," P-VALUES FOR T-TESTS FOR PARTIAL CORRELATIONS";
PRINT PTPCORR;

/* Compute plotting positions
   for a chi-square probability plot */

E=X-(J(N,1)*XBAR);       
D=VECDIAG(E*INV(S)*E`);  /* Squared Mah. distances */
RD = RANK(D);            /* Compute ranks  */
  RD=(RD-.5)/N;
PD2=P/2;
  Q=2*GAMINV(RD,PD2);    /* Plotting positions */
  DQ=D||Q;
CREATE CHISQ FROM DQ ;   /* Open a file to store results */
APPEND FROM DQ;

                         /* Compute test statistic */
rpn = t(D)*Q - (sum(D)*sum(Q))/N;
rpn = rpn/sqrt((ssq(D)-(sum(D)**2)/N)
         *(ssq(Q)-(sum(Q)**2)/N));

/* Simultate a p-value for the correlation test  */

ns=10000;
pvalue=0;
do i=1 to ns;
  do j1=1 to n;
  do j2=1 to p;
    x[j1,j2] = rannor(-100);
    end;
    end;

   SUMX=X[+, ];           
   A=t(X)*X-t(SUMX)*SUMX/N;     
   S=A/(N-1);             
   XBAR=SUM/N;           
   E=X-(J(N,1)*XBAR);   
   DN=VECDIAG(E*INV(S)*t(E));   
   RN = RANK(DN);            
   RN =(RN-.5)/N;
   PD2=P/2;
   QN=2*GAMINV(RN,PD2);  
   rpnn = t(DN)*QN-(sum(DN)*sum(QN))/N;
   rpnn = rpnn/sqrt((ssq(DN)-(sum(DN)**2)/N)
           *(ssq(QN)-(sum(QN)**2)/N));
   if(rpn>rpnn) then pvalue=pvalue+1;   
   end;
   pvalue=pvalue/ns;

print,,,,,"Correlation Test of Normality";
print N P rpn pvalue;

FINISH;

RUN NORMAL;


/* Display the chi-square probability plot 
   for assessing multivariate normality */

axis2 label=(f=swiss h=2.5 a=90 r=0
       "Ordered Distances ")
      value=(f=triplex h=2.0)
      length = 5.0in;

axis1 label=(f=swiss h=2.5 
      "Chi-Square Quantiles")
      value=(f=triplex h=1.6)
      length= 5.5in;
 
 SYMBOL1 V=CIRCLE H=2.0 ;
 
PROC GPLOT DATA=CHISQ;
   PLOT Col1*COL2 / vaxis=axis2 haxis=axis1;
TITLE1 ls=1.5in H=3.0 F=swiss "CHI-SQUARE PLOT";
Title2 H=2.3 F=swiss "Leyton Tree Data";
footnote ls=1.0in;
   RUN;
QUIT;
