/* Lesson 13: Canonical Correlation Analysis */
/* Example 13-1: Sales Section */
options ls=78;
title "Canonical Correlation Analysis - Sales Data";
data sales;
  infile "Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\sales.txt";
  input growth profit new create mech abs math;
  run;

proc print data = sales;
run;

proc cancorr out=canout vprefix=sales vname="Sales Variables" 
                       wprefix=scores wname="Test Scores";
  var growth profit new;
  with create mech abs math;
  run;
proc gplot;
  axis1 length=3 in;
  axis2 length=4.5 in;
  plot sales1*scores1 / vaxis=axis1 haxis=axis2;
  symbol v=J f=special h=2 i=r color=black;
  run;
