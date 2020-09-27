/* CHAPTER  1 Getting Started Using SAS Software */
* Convert miles to kilometers;

DATA distance;
   Miles = 26.22;
   Kilometers = 1.61 * Miles;
RUN;

PROC PRINT  DATA = distance; /* Print the results */  
RUN;

/* Using SAS System Options */
