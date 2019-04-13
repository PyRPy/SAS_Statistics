# crossover repeated measures design;
/* Investigators want to evaluate the effect of 3 diets on Neutral Detergent Fiber (NDF) 
levels in steer. The three diets are administered to each steer in a sequence over 3 periods. 
A total of 6 sequences were used and two steers were assigned to each sequence of treatments */
data steer;                                                                                        
input PER  SEQ   DIET  $   STEER  NDF x1 x2;                                           
datalines;                                                                                                                              
1      1      A      1      50      0      0                                                       
1      1      A      2      55      0      0                                                       
1      2      B      1      44      0      0                                                       
1      2      B      2      51      0      0                                                       
1      3      C      1      35      0      0                                                       
1      3      C      2      41      0      0                                                       
1      4      A      1      54      0      0                                                       
1      4      A      2      58      0      0                                                       
1      5      B      1      50      0      0                                                       
1      5      B      2      55      0      0                                                       
1      6      C      1      41      0      0                                                       
1      6      C      2      46      0      0                                                       
2      1      B      1      61      1      0                                                       
2      1      B      2      63      1      0                                                       
2      2      C      1      42      0      1                                                       
2      2      C      2      45      0      1                                                       
2      3      A      1      55      -1      -1                                                     
2      3      A      2      56      -1      -1                                                     
2      4      C      1      48      1      0                                                       
2      4      C      2      51      1      0                                                       
2      5      A      1      57      0      1                                                       
2      5      A      2      59      0      1                                                       
2      6      B      1      56      -1      -1                                                     
2      6      B      2      58      -1      -1                                                     
3      1      C      1      53      0      1                                                       
3      1      C      2      57      0      1                                                       
3      2      A      1      57      -1      -1                                                     
3      2      A      2      59      -1      -1                                                     
3      3      B      1      47      1      0                                                       
3      3      B      2      50      1      0                                                       
3      4      B      1      51      -1      -1                                                     
3      4      B      2      54      -1      -1                                                     
3      5      C      1      51      1      0                                                       
3      5      C      2      55      1      0                                                       
3      6      A      1      58      0      1                                                       
3      6      A      2      61      0      1                                                       
;                                                                                                  
run;   

proc print data = steer;
run; 
                                                                                                                                                                                                                                                                  
/* Model Adjusting for carryover effects */                                                                                                   
proc mixed data= steer;                                                                            
class per seq diet steer;                                                                          
model ndf = per diet seq x1 x2;                                                                    
repeated per / subject=steer(seq) type=csh; 
store out_steer;
run;                                                        
                                                                
ods graphics on;                                                                                                                      
ods html style=statistical sge=on; 
                                                                                              
proc plm restore=out_steer;
lsmeans diet / adjust=tukey plot=meanplot cl lines; 
ods exclude diffs diffplot;                                                                                                             
run; 

/* Reduced Model, Ignoring carryover effects */                                                                                                                
proc mixed data= steer;                                                                            
class per seq diet steer;                                                                          
model ndf = per diet seq;                                                                              
repeated per / subject=steer(seq) type=csh;  
lsmeans diet / pdiff adjust=tukey; 
run;   
