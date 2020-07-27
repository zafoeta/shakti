nn:n,n:8; 		  								/ board size
m:(n;n)#0; 	  									/ board
lm:,m;
zz:0 0;
di:d,|''d:.[{[x]$[&/x=0;nn;x]}''(+(#'ndd)#'nd),''+ndd:nd_\nd:!n;zz;:;zz]; 		/ diagonals;
di,:d1,(!n)+'d1:{[x]$[|/n=x;nn;x]}''+'(:;(n-1)-)@'/+'d;
mdi::x,(+x),x@/://di									
win::|/3<+/'(?0,&~y)^y:x=y    								/ x wins for line?
wins::0<+/win[y]'xs@&3<sum y=+xs:mdi@x	 						/ y wins for any line?
mv::.[x;(y;x[y]?0);:;z]									/ move
pl::*1?&0<+/'0=x									/ draw from available moves
gover::(0=+//:0=x)||/wins[x]'1 2							/ game over
rmv:{[x]p:pl@*x;(mv[*x;p;*|x];(x 1),p;0 2 1@*|x)}  					/ random move and upate state
simu::$[gover@*x;x;rmv x]  								/ move wrapper with condition on win
cmove:{[x;y;z] 										/ cpu move
 r:{[x;y;z]simu/:(x;0;y)}[x;z]'!y; 
 m:*{[x] &x=|/x}@{[x]sum[x]%#x}'=wins[;z]'[r[;0]]!{[x]*1_x}'r[;1];
 mv[x;m;z]}
pmove::$[gover x;x;$[gover x:mv[x;y;1];x;cmove[x;2000;2]]]    				/ player move
show1::". ",($[x<0;$-1*x+1;" xo"x])," "
show::|((,/+(9#l;,'/show1''x,'-(1+!n))),l:,32#"."),\"."

\
to start/init/reset:
\l c4.k

to play:
k9 doesn't allow global state at this point
to move on column 3: 
m:pmove[m;2];show m

cpu against cpu:
show@m {[x;y]$[gover x;x;cmove[x;1000;y]]}/:64#1 2

