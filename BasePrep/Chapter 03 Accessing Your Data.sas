/* Chapter 3: Accessing Your Data */
proc print daata = cert.admit;
run;
* Example: View the Contents of an Entire Library;
proc contents data=cert._all_ nods;
run;

* Example: View Descriptor Information;
proc contents data=cert.amounts;
run;

* Example: View Descriptor Information Using the Varnum Option;
proc contents data=cert.amounts varnum;
run;
