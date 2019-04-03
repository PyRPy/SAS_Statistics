data rmanova;                                                                                                                          
 input trt $ time subject resp;                                                                                                         
 datalines;                                                                                                                             
 A   1  1  10                                                                                                                           
 A   1  2  12                                                                                                                           
 A   1  3  13                                                                                                                           
 A   2  1  16                                                                                                                           
 A   2  2  19                                                                                                                           
 A   2  3  20                                                                                                                           
 A   3  1  25                                                                                                                           
 A   3  2  27                                                                                                                           
 A   3  3  28                                                                                                                           
 B   1  4  12                                                                                                                           
 B   1  5  11                                                                                                                           
 B   1  6  10                                                                                                                           
 B   2  4  18                                                                                                                           
 B   2  5  20                                                                                                                           
 B   2  6  22                                                                                                                           
 B   3  4  25                                                                                                                           
 B   3  5  26                                                                                                                           
 B   3  6  27                                                                                                                           
 C   1  7  10                                                                                                                           
 C   1  8  12                                                                                                                           
 C   1  9  13                                                                                                                           
 C   2  7  22                                                                                                                           
 C   2  8  23                                                                                                                           
 C   2  9  22                                                                                                                           
 C   3  7  31                                                                                                                           
 C   3  8  34                                                                                                                           
 C   3  9  33                                                                                                                           
 ;                                                                                                                                      
  /* 2-factor factorial for trt and time - saving residuals */                                                                           
 proc mixed data=rmanova method=type3;                                                                                                  
 class trt time subject;                                                                                                                
 model resp=trt time trt*time / ddfm=kr outpm=outmixed;                                                                                 
 title 'Two_factor_factorial';                                                                                                          
 run; title;                                                                                                                            
                                                                                                                                        
 /* re-organize the residuals (to unstacked data for correlation) */                                                                    
                                                                                                                                        
 data one; set outmixed; where time=1; time1=resid; keep time1; run;                                                                    
 data two; set outmixed; where time=2; time2=resid; keep time2;  run;                                                                   
 data three; set outmixed; where time=3; time3=resid; keep time3;  run;                                                                 
 data corrcheck; merge one two three; run;                                                                                              
 proc print data=corrcheck; title 'Residuals for each time'; run;                                                                       
 title;                                                                                                                                 
                                                                                                                                        
 proc corr data=corrcheck cov nosimple; var time1 time2 time3; run;                                                                     
                                                                                                                                        
 /* Mixed Model with Repeated Measures - Unstructured */                                                                                
                                                                                                                                        
 proc mixed data=rmanova;                                                                                                               
 class trt time subject;                                                                                                                
 model resp=trt time trt*time / ddfm=kr;                                                                                                
 repeated time / subject=subject type=un r rcorr;                                                                                       
 run;  title 'Unstructured'; run;                                                                                                       
 title; run;
