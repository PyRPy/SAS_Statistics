/* Chapter 01 Multivariate analysis concepts */
/* Example 1 Testing multivariate normality, cork data */

/* Program 1.1 */
options ls = 64 ps = 45 nodate nonumber;
data cork;
	infile 'Documents\My SAS Files\MVA_SAS\Data\cork.dat' firstobs = 1;
	input north easte south west;
*proc print data = cork;
*run;

proc calis data = cork kurtosis;
title1 "output 1.1";
title2 "computation of Mardia's Kertosis";
lineqs 
north = e1, 
east = e2, 
south = e3, 
west = e4;
std
e1 = eps1, e2 = eps2, e3 = eps3, e4 = eps4;
cov 
e1=eps1, e2=eps2, e3=eps3, e4=eps4; 
run;
* code above not working ! ;

* try this code again ;

data cork;
	infile 'Documents\My SAS Files\MVA_SAS\Data\cork.dat' firstobs = 1;
	input y1 y2 y3 y4;
run;

proc iml;
use cork;
read all into y;
n = nrow(y);
p = ncol(y);
dfchi = p*(p+1)*(p+2) / 6;

q = i(n) - (1/n)*j(n,n,1);
s = (1/(n))*y`*q*y;
s_inv = inv(s);
g_matrix = q*y*s_inv*y`*q;
beta1hat = (sum(g_matrix#g_matrix#g_matrix))/(n*n);
beta2hat = trace(g_matrix#g_matrix)/n;

kappa1 = n*beta1hat/6;
kappa2 = (beta2hat - p*(p+2) ) /sqrt(8*p*(p+2)/n);
pvalskew = 1 - probchi(kappa1, dfchi);
pvalkurt = 2*(1-probnorm(abs(kappa2)));
print s;
print s_inv;
print 'tests';
print 'based on skewness: ' beta1hat kappa1 pvalskew;
print 'based on kurtosis: ' beta2hat kappa2 pvalkurt;

/* Program 1.3 */
options ls=64 ps=45 nodate nonumber; 
title1 ’Output 1.3’; 
title2 ’Testing Multivariate Normality (Cube Root Transformation)’;

data D1;
	infile 'Documents\My SAS Files\MVA_SAS\Data\cork.dat';
	input t1 t2 t3 t4;
run;

data D2(keep =t1 t2 t3 t4 n p);
set d1;
n = 28;
p = 4;
run;

data D3(keep = n p);
set d2;
if _n_ > 1 then delete;
run;

proc print data= d3;
run;

proc princomp data =d2 cov std out=d4 noprint;
	var t1-t4;
run;

data D5(keep=n1 dsq n p); 
set D4; 
n1=_n_; 
dsq=uss(of prin1-prin4); 
run; 

data D6(keep=dsq1 n1 ); 
set D5; 
dsq1=dsq**((1.0/3.0)-(0.11/p)); 
run;

proc iml; 
use D3; 
read all var {n p}; 
u=j(n,1,1);

use D6; 
do k=1 to n; 
setin D6 point 0; 
sum1=0; 
sum2=0; 
do data; 
read next var{dsq1 n1} ; 
if n1 = k then dsq1=0; 
sum1=sum1+dsq1**2; 
sum2=sum2+dsq1; 
end; 
u[k]=(sum1-((sum2**2)/(n-1)))**(1.0/3); 
end; 
varnames={y}; 
create tyy from u (|colname=varnames|); 
append from u; 
close tyy; 
run; 
quit;


data D7; 
set D6; 
set tyy; 
run; 
proc corr data=D7 noprint outp=D8; 
var dsq1; 
with y; 
run; 
data D9; 
set D8; 
if _TYPE_ ^='CORR' then delete; 
run; 

data D10(keep=zp r tnp pvalue); 
set D9(rename=(dsq1=r)); 
set D3; 
zp=0.5*log((1+r)/(1-r)); 
b1p=3-1.67/p+0.52/(p**2); 
a1p=-1.0/p-0.52*p; 
a2p=0.8*p**2; 
mnp=(a1p/n)-(a2p/(n**2)); 
b2p=1.8*p-9.75/(p**2); 
ssq1=b1p/n-b2p/(n**2); 
snp=ssq1**0.5; 
tnp=abs(abs(zp-mnp)/snp); 
pvalue=2*(1-probnorm(tnp)); 
run; 
proc print data=D10; 
run;

/* Program 1.4 */
options ls = 64 ps=45 nodate nonumber; title1 ’Output 1.4’;

/* Generate n random vector from a p dimensional population 
with mean mu and the variance covariance matrix sigma */

proc iml;
seed = 549065467; 
n= 4;
sigma = { 4 2 1, 
		  2 3 1, 
		  1 1 5 };

mu = {1, 3, 0};
p = nrow(sigma);
m = repeat(mu`, n, 1);
g = root(sigma);
z = normal(repeat(seed, n, p));
y = z * g + m;
print 'Multivariate normal sample';
print y;

/* Program 1.5 */
options ls=64 ps=45 nodate nonumber; 
title1 ’Output 1.5’; 
/* Generate n Wishart matrices of order p by p 
with degrees of freedom f */

proc iml;
n = 4;
f = 7;
seed = 4509049 ; 
sigma = {4 2 1, 
		 2 3 1, 
		 1 1 5}; 
g = root(sigma); 
p = nrow(sigma) ; 
print 'Wishart Random Matrix'; 
do i = 1 to n ; 
	t = normal(repeat(seed,f,p)) ; 
	x = t*g ; 
	w = x`*x ; 
	print w ; 
end ;
quit;
