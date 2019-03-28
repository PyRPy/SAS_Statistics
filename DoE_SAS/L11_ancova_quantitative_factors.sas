* https://newonlinecourses.science.psu.edu/stat502/sites/onlinecourses.science.psu.edu.stat502/files/lesson11/quant_factor_sascode/index.txt;

data quant_factor;                                                     
input reagent $ temp product;                                                                                                           
datalines;                                                                                                                              
A      40      10.2000                                        
A      40      9.4000                                         
A      40      10.4000                                        
A      50      14.0000                                        
A      50      13.5000                                       
A      50      14.5000                                        
A      60      16.6000                                       
A      60      18.2000                                        
A      60      16.2000                                       
A      70      15.6000                                        
A      70      17.3000                                        
A      70      15.1000                                       
A      80      16.0000                                       
A      80      14.4000                                        
A      80      14.6000                                       
B      40      9.1572                                        
B      40      7.2280                                        
B      40      8.8698                                        
B      50      13.1378                                       
B      50      12.0304                                        
B      50      13.6833                                        
B      60      15.1570                                       
B      60      17.8120                                        
B      60      14.6707                                       
B      70      14.8706                                       
B      70      16.0180                                                           
B      70      14.4354
B      80      15.3543
B      80      13.4660                                                     
B      80      13.4608                                  
;                                                              
run;                                                                                                 
/* centering the covariate */  /* creating the quadratic */                                                       
                                                                                                                                        
data quant_factor; set quant_factor;
x = temp-60;
x2 = x**2;                                                         
run;                                                                                                                                     
proc mixed data=quant_factor;                                                            
class reagent;                                                    
model product=reagent x x2                                                
        reagent*x reagent*x2;
run;
