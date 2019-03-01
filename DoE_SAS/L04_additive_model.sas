data glucose;
input Method	Doping	Glucose;
datalines;
1	1	46.5
1	1	47.3
1	1	46.9
1	2	138.4
1	2	144.4
1	2	142.7
1	3	180.9
1	3	180.5
1	3	183
2	1	39.8
2	1	40.3
2	1	41.2
2	2	132.4
2	2	132.4
2	2	130.3
2	3	176.8
2	3	173.6
2	3	174.9
;
run;

proc mixed data=glucose method=type3;                                                                                           
class Method Doping;                                                                                                                     
model Glucose = Method Doping Method*Doping;                                                                                               
store glucose4;                                                                                                                          
run;  

* after remove the interaction term Method*Doping;
proc mixed data=glucose method=type3;                                                                                           
class Method Doping;                                                                                                                     
model Glucose = Method Doping;                                                                                               
store glucose4b;                                                                                                                          
run;   
