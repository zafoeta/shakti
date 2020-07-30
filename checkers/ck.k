nn:n,n:8
m:nn#0
m:.[;;:;]/[m;((0;0 2 4 6);(1;1+0 2 4 6);(6;0 2 4 6);(7;1+0 2 4 6));1 1 2 2]
p:,/(!n),/\!n;
ppos::p@&y=,/x					/ pieces position
nmv::x+/y*(1 1;1 -1;-1 1;-1 -1)
esq::y@&0=x ./ y
fmv1::x@&&/(&/'x>-1;&/'x<n)
fmv::fmv1@x@&(0;<;>)[z][*y;*'x]
pmv:{[s;x;y;z]
 mvs:nmv[x;y];
 mvs:fmv[mvs;x;z];
 $[&/(#mvs;#mvs2:mvs@&((0 2 1)@z)=s@/:/mvs);mvs,:,/pmv[s;;y;z]'mvs2;];
 esq[s] mvs }
wmv::pmv[x;y;z;1]
bmv::pmv[x;y;z;2]
mv::m:.[m;x;:;y]
pmvs::(&0<#'pm)#pm:pm!$[y=1;wmv;bmv][x;;1]'pm:ppos[x;y]
sig::1 -1@0>x
simu2:{[mm;x;y]
 k:*1?!mm;
 t:*1?mm@k;
 mvs1:k+/+!|//:1 -1*/t-k;
 mvs1:fmv1@mvs1;
 .[;;:;]/[x;(,t),mvs1;y,(#mvs1)#0]}
simu1:{[x;y]
 mm:pmvs[x;y];
 $[#mm;simu2[mm;x;y];x]}

\ 
checkers
