nn:n,n:8 		  								/ board size
m:nn#0	 	  									/ board
zz:0 0
iter:1000										/ max number of iterations per simulation; increase/decrease for cpu strength/level
di:d,|''d:.[{[x]$[&/x=0;nn;x]}''(+(#'ndd)#'nd),''+ndd:nd_\nd:!n;zz;:;zz] 		/ diagonals;
di,:d1,(!n)+'d1:{[x]$[|/n=x;nn;x]}''+'(:;(n-1)-)@'/+'d
ll::x,(+x),x@/://di									
win::|/3<+/'(?0,&~y)^y:x=y    								/ x wins for line
wins::0<+/win[y]'xs@&3<sum y=+xs:ll@x	 						/ y wins for any line
mv::.[x;(y;x[y]?0);:;z]									/ move
pl::*1?&0<+/'0=x									/ draw from available moves
gover::(0=+//:0=x)||/wins[x]'1 2							/ game over
rmv:{[x]p:pl@*x;(mv[*x;p;*|x];(x 1),p;0 2 1@*|x)}  					/ random move and upate state
simu1::$[gover@*x;x;rmv x]  								/ move wrapper with condition on win
simu:{[x;y;z]										/ simulation
 r:{[x;y;z]simu1/:(x;0;y)}[x;z]'!y; 
 *!|<{[x](+/x)%#x}'wins'[r[;0];z]@=r[;1][;1]}
cmove:{[x;y;z]mv[x;;z] simu[x;y;z]}							/ cpu move
pmove::$[gover x;x;$[gover x:mv[x;y;1];x;cmove[x;iter;2]]]	   			/ player move
show1::". ",($[x<0;$-1*x;" xo"x])," "
show::|((,/+((n+1)#l;,'/show1''x,'-(1+!n))),l:,(n*4)#"."),\"."
play::show@m:pmove[m;x-1]

\
to start/init/reset:
\l c4.k

state: 0 - empty, 1 - red, 2 - yellow

to play on column 3:
play 3

cpu against cpu:
show@m {[x;y]$[gover x;x;cmove[x;iter;y]]}/:64#1 2
