
data school;
input region $ school_type $ teacher class SR_score;
datalines;
EastUS      Private      1      1    81
EastUS      Private      1      2    85
EastUS      Private      2      1    88
EastUS      Private      2      2    89
EastUS      Public      1      1    68
EastUS      Public      1      2    72
EastUS      Public      2      1    78
EastUS      Public      2      2    75
WestUS      Private      1      1    88
WestUS      Private      1      2    90
WestUS      Private      2      1    91
WestUS      Private      2      2    89
WestUS      Public      1      1    94
WestUS      Public      1      2    97
WestUS      Public      2      1    93
WestUS      Public      2      2    89
;
run;
proc summary data=school;
class region school_type teacher class;
var sr_score;
output out=a mean=; run; proc print; run;

proc mixed data=school covtest method=type3;
class region school_type teacher class;
model sr_score=region school_type region*school_type;
random teacher(region*school_type);
store school_res;

proc plm restore=school_res;
lsmeans region*school_type / adjust=tukey lines;
run;
