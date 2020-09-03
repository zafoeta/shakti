nn:(n:7),o:6 		  								/ board size
m:(n;o)#0	 	  								/ board
iter:3000										/ number of iterations per simulation; increase/decrease strength/level
di:d,|''d:(+{[x]x,(n-#x)#n}'(|1+nd)#'nd),''|\+nd_\:nd:!n;				/ diagonals
di,:d1,(!n)+'d1:{[x]$[|/n=x;nn;x]}''+'(:;(n-1)-)@'/:+'d
ll::x,(+x),x@//:/:di								 	/ game lines	
win::|/3<+/'(?0,&~y)^y:x=y    								/ x wins for line
wins::|//:win[y]'xs@&3<+/y=+xs:ll@x	 						/ y wins for any line
mv::.[x;(y;x[y]?0);:;z]									/ update state for move
zeros::0<+/'0=x										/ state=0, aka available moves	
pl::*1?&zeros x 									/ draw from available moves
gover::(&/~zeros x)||//:wins[x]'1 2							/ game over
opl::0 2 1@x										/ oposite player
rmv:{[x]p:pl@*x;(mv[*x;p;*|x];(x 1),p;opl@*|x)} 					/ random move and upate state
simu1::$[gover@*x;x;rmv x]  								/ move wrapper with condition on win
simu:{[x;y;z]   									/ simulation
 r:{[x;y;i]simu1/:(x;();y)}[x;z]'!y; 
 l:wins'[r[;0];opl z];
 r:!<{[x](+/x)%#x}'l@=r[;1][;0];
 *r}
cmove:{[x;y;z]mv[x;;z]simu[x;y;z]}							/ cpu move
play:{[m;x]$[gover m;m;$[gover m:mv[m;x-1;1];m;cmove[m;iter;2]]]}	  		/ player move
show1::". ",($[x<0;$-1*x;" xo"x])," "
show::|((,/+((o+1)#l;,'/show1''x,'-(1+!n))),l:,(n*4)#"."),\:"."				/ show board

\
to start/init/reset:
\l c4.k

state: 0 - empty, 1/x - red, 2/o - yellow

to play on column 3:
show m:play[m] 3
/ play 3 - once shakti allows setting global state

cpu against cpu:
show@m {[x;y]$[gover x;x;cmove[x;iter;y]]}/42#1 2
