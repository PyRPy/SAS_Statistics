* 9.5 - Using Codebooks to Help Define Formats;

* Example 9.11. The following SAS program creates a SAS data set called 
states from state_cd, which is the codebook for the variable state that 
is collected on the ICDB background form. Here's what the first ten 
observations of the state_cd data set look like:;

PROC PRINT data=icdb.state_cd;
   title 'Codebook for States';
RUN;

DATA states;
   set icdb.state_cd (rename = (code = start name=label));
   fmtname = 'stat2fmt';
RUN;

PROC FORMAT cntlin=states;
RUN;

PROC FREQ data=back;
   title 'Freqency Count of STATE (stat2fmt)';
   format state stat2fmt.;
   table state;
RUN;
