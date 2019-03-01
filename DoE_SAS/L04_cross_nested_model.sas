data  machine;
input A B C Time;
datalines;
1	1	1	10.2
1	1	1	13.1
1	1	2	16.2
1	1	2	16.9
1	1	3	13.8
1	1	3	14.9
1	2	1	4.2
1	2	1	5.2
1	2	2	8
1	2	2	9.1
1	2	3	2.5
1	2	3	4.4
2	1	1	12
2	1	1	13.5
2	1	2	12.6
2	1	2	14.6
2	1	3	12.9
2	1	3	15
2	2	1	4.1
2	2	1	6.1
2	2	2	4
2	2	2	6.1
2	2	3	3.7
2	2	3	5
3	1	1	13.1
3	1	1	12.9
3	1	2	12.9
3	1	2	13.7
3	1	3	11.8
3	1	3	13.5
3	2	1	4.1
3	2	1	6.1
3	2	2	2.2
3	2	2	3.8
3	2	3	2.7
3	2	3	4.1
;
run;
proc print data=machine;
run;
proc mixed data=machine method=type3;                                                                                                   
class A B C;                                                                                                                
model Time = A B(A) C A*C B*C;                                                                                             
store nested1;                                                                                                                          
run;
