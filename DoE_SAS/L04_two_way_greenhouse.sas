data greenhouse_2way;                                                                                                                   
input fert $ species $ height;                                                                                                          
datalines;  

control SppA      21.0                                                                                                                  
control SppA      19.5                                                                                                                  
control SppA      22.5                                                                                                                  
control SppA      21.5                                                                                                                  
control SppA      20.5                                                                                                                  
control SppA      21.0                                                                                                                  
control SppB      23.7                                                                                                                  
control SppB      23.8                                                                                                                  
control SppB      23.8                                                                                                                  
control SppB      23.7                                                                                                                  
control SppB      22.8                                                                                                                  
control SppB      24.4                                                                                                                             
f1      SppA      32.0                                                                                                                  
f1      SppA      30.5                                                                                                                  
f1      SppA      25.0                                                                                                                  
f1      SppA      27.5                                                                                                                  
f1      SppA      28.0                                                                                                                  
f1      SppA      28.6                                                                                                                  
f1      SppB      30.1                                                                                                                  
f1      SppB      28.9                                                                                                                  
f1      SppB      30.9                                                                                                                  
f1      SppB      34.4                                                                                                                  
f1      SppB      32.7                                                                                                                  
f1      SppB      32.7                                                                                                                  
f2      SppA      22.5                                                                                                                  
f2      SppA      26.0                                                                                                                  
f2      SppA      28.0                                                                                                                  
f2      SppA      27.0                                                                                                                  
f2      SppA      26.5                                                                                                                  
f2      SppA      25.2                                                                                                                  
f2      SppB      30.6                                                                                                                  
f2      SppB      31.1                                                                                                                  
f2      SppB      28.1                                                                                                                  
f2      SppB      34.9                                                                                                                  
f2      SppB      30.1                                                                                                                  
f2      SppB      25.5                                                                                                                  
f3      SppA      28.0                                                                                                                  
f3      SppA      27.5                                                                                                                  
f3      SppA      31.0                                                                                                                  
f3      SppA      29.5                                                                                                                  
f3      SppA      30.0                                                                                                                  
f3      SppA      29.2                                                                                                                  
f3      SppB      36.1                                                                                                                  
f3      SppB      36.6                                                                                                                  
f3      SppB      38.7                                                                                                                  
f3      SppB      37.1                                                                                                                  
f3      SppB      36.8                                                                                                                  
f3      SppB      37.1                                                                                                                                
;                                                                                                                                       
run;                                                                                                                                    
                                                                                                                                        
proc mixed data=greenhouse_2way method=type3;                                                                                           
class fert species;                                                                                                                     
model height = fert species fert*species;                                                                                               
store out2way;                                                                                                                          
run;                                                                                                                                    
                                                                                                                                        
ods graphics on;                                                                                                                        
ods html style=statistical sge=on;                                                                                                      
proc plm restore=out2way;                                                                                                               
lsmeans fert*species / adjust=tukey plot=meanplot cl lines;                                                                             
/* Because the 2-factor interaction is significant, we need to work with                                                                
the treatment combination means */                                                                                                      
ods exclude diffs diffplot;                                                                                                             
run; title; run;
