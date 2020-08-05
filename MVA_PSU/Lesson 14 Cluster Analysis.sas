/* Lesson 14: Cluster Analysis */

/* Example 14-2: Woodyard Hammock Data */
options ls=78;
title 'Cluster Analysis - Woodyard Hammock - Complete Linkage';
data wood;
  infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wood.txt';
  input x y acerub carcar carcor cargla cercan corflo faggra frapen
        ileopa liqsty lirtul maggra magvir morrub nyssyl osmame ostvir 
        oxyarb pingla pintae pruser quealb quehem quenig quemic queshu quevir 
        symtin ulmala araspi cyrrac;
  ident=_n_;
  drop acerub carcor cargla cercan frapen lirtul magvir morrub osmame pintae
       pruser quealb quehem queshu quevir ulmala araspi cyrrac;
  run;
proc sort;
  by ident;

proc print data = wood;
run;

proc cluster method=complete outtree=clust1;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;
proc tree horizontal nclusters=6 out=clust2;
  id ident;
  run;
proc sort;
  by ident;
  run;
proc print;
  run;
data combine;
  merge wood clust2;
  by ident;
  run;

proc print data = combine;
run;

proc glm;
  class cluster;
  model carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
        pingla quenig quemic symtin = cluster;
  means cluster;
  run;

/* Example 14-3: Woodyard Hammock Data (Ward's Method) */
options ls=78;
title "Cluster Analysis - Woodyard Hammock - Ward's Method";
data wood;
  infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wood.txt';
  input x y acerub carcar carcor cargla cercan corflo faggra frapen
        ileopa liqsty lirtul maggra magvir morrub nyssyl osmame ostvir 
        oxyarb pingla pintae pruser quealb quehem quenig quemic queshu quevir 
        symtin ulmala araspi cyrrac;
  ident=_n_;
  drop acerub carcor cargla cercan frapen lirtul magvir morrub osmame pintae
       pruser quealb quehem queshu quevir ulmala araspi cyrrac;
  run;
proc sort;
  by ident;
proc cluster method=ward outtree=clust1;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;
proc tree horizontal nclusters=4 out=clust2;
  id ident;
  run;
proc sort;
  by ident;
  run;
data combine;
  merge wood clust2;
  by ident;
  run;
proc glm;
  class cluster;
  model carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
        pingla quenig quemic symtin = cluster;
  means cluster;
run;

/* Example 14-5: Woodyard Hammock Data (Initial Clusters) */
options ls=78;
title "Cluster Analysis - Woodyard Hammock - K-Means";
data wood;
  infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wood.txt';
  input x y acerub carcar carcor cargla cercan corflo faggra frapen
        ileopa liqsty lirtul maggra magvir morrub nyssyl osmame ostvir 
        oxyarb pingla pintae pruser quealb quehem quenig quemic queshu quevir 
        symtin ulmala araspi cyrrac;
  ident=_n_;
  drop acerub carcor cargla cercan frapen lirtul magvir morrub osmame pintae
       pruser quealb quehem queshu quevir ulmala araspi cyrrac;
  run;
proc sort;
  by ident;
proc fastclus maxclusters=4 replace=random;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;

/* set the maximum number of clusters to four and also set the radius to equal 20, */
options ls=78;
title "Cluster Analysis - Woodyard Hammock - K-Means";
data wood;
  infile 'Documents\My SAS Files\STAT505_SAS\MVA_PSU\Data\wood.txt';
  input x y acerub carcar carcor cargla cercan corflo faggra frapen
        ileopa liqsty lirtul maggra magvir morrub nyssyl osmame ostvir 
        oxyarb pingla pintae pruser quealb quehem quenig quemic queshu quevir 
        symtin ulmala araspi cyrrac;
  ident=_n_;
  drop acerub carcor cargla cercan frapen lirtul magvir morrub osmame pintae
       pruser quealb quehem queshu quevir ulmala araspi cyrrac;
  run;
proc fastclus maxclusters=4 radius=20 maxiter=100 out=clust;
  var carcar corflo faggra ileopa liqsty maggra nyssyl ostvir oxyarb 
      pingla quenig quemic symtin;
  id ident;
  run;
