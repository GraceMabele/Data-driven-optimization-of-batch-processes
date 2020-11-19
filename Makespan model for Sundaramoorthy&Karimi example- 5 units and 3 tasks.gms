$Ontext

This GAMS Model presents an application of the novel mathematical formulation
for the short-term scheduling of batch plants. The proposed formulation by Shaik and Floudas (2009) 
is used on a literature example by Sundaramoorthy and Karimi that involves 3 tasks and 5 units (2 mixers, 1 reactor and 2 purificators). The main process involves a series of 
processing tasks i.e. a mixing, reaction and purification.

Example 1 reference
Sundaramoorthy A, Karimi IA. (2005) A simpler better slot-based continuous-time formulation for short-term scheduling in multipurpose
batch plants. Chemical Engineering Science 60 (2679–2702)
$Offtext

Formulation reference
Novel Unified Modeling Approach for Short-Term Scheduling
Munawar A. Shaik and Christodoulos A. Floudas Industrial & Engineering Chemistry Research 2009 48 (6), 2947-2964
$Offtext
$onempty

Scalar
H 'short-term time horizon' /50/
delta 'limit on the maximum number of events over which task i is allowed to continue' /1/
;

Sets
  i 'tasks' /t1*t5/
  j 'units' /j1*j5/
  n 'events' /n0*n15/
  s 'states' /s1*s4/
  
Ij1(i) 'tasks which can be performed in unit 1' /t1/
Ij2(i) 'tasks which can be performed in unit 2' /t2/
Ij3(i) 'tasks which can be performed in unit 3' /t3/
Ij4(i) 'tasks which can be performed in unit 4' /t4/
Ij5(i) 'tasks which can be performed in unit 5' /t5/


Is1(i)'tasks which process state 1 and either produce or consume' /t1,t2/
Is2(i)'tasks which process state 2 and either produce or consume' /t1,t2,t3/
Is3(i)'tasks which process state 3 and either produce or consume' /t3,t4,t5/
Is4(i)'tasks which process state 4 and either produce or consume' /t4,t5/

Ips1(i) 'tasks which produce state 2' //
Ips2(i) 'tasks which produce state 2' /t1,t2/
Ips3(i) 'tasks which produce state 3' /t3/
Ips4(i) 'tasks which produce state 4' /t4,t5/

Ics1(i) 'tasks which consume state 1' /t1,t2/
Ics2(i) 'tasks which consume state 2' /t3/
Ics3(i) 'tasks which consume state 3' /t4,t5/
Ics4(i) 'tasks which consume state 4' //

Jt1(j) 'units which are suitable for performing task 1' /j1/
Jt2(j) 'units which are suitable for performing task 2' /j2/
Jt3(j) 'units which are suitable for performing task 3' /j3/
Jt4(j) 'units which are suitable for performing task 4' /j4/
Jt5(j) 'units which are suitable for performing task 5' /j5/

Sr(s) 'states that are raw materials' /s1/
Sfis(s) 'intermediate states with dedicated finite intermediate storage' /s2,s3/
Sp(s) 'states that are final products' /s4/


alias(i,ip)
alias(j,jp)
alias(n,np,npp)

;

Parameters

Bmin(i) 'minimum capacity (batch size) of task i'
   /
   t1 0
   t2 0
   t3 0
   t4 0
   t5 0
   /

Bmax(i) 'maximum capacity (batch size) of task i'
   /
   t1   100 
   t2   150
   t3   200
   t4   150
   t5   150  
   /
   
STin(s) 'initial amount of state s available'
   /
   s1  10000
   s2  0
   s3  0
   s4  0
   /
   
STmax(s) 'maximum amount of state s'
/
   s1  +inf
   s2  200
   s3  250
   s4  +inf
   /
;
 
Parameter
  a(i) 'constant term of processing time of task i at unit j'
 /t1      1.333
  t2              1.333
  t3                      1.000
  t4              0.667
  t5                      0.667/
  
b(i) 'coefficient of variable term of processing time of task i'

 /t1      0.01333
  t2              0.01333
  t3                      0.00500
  t4              0.00445
  t5                      0.00445 /
;
   
Table p(i,s) 'proportion of state s produced (p(i,s) > 0), consumed (p(i,s) < 0) by task i'
           s1          s2        s3        s4
   t1      -1          +1
   t2      -1          +1
   t3                  -1        +1
   t4                            -1        +1
   t5                            -1        +1

;

Parameter

Ps(s) 'price of state s'
   /
   s1    0
   s2    0
   s3    0
   s4    5
   /
Ds(s) 'demand for state s'
    /
   s1 0
   s2 0
   s3 0
   s4 2000
   /
;

Variables
w(i,n,np) 'binary variable for assignment of task i that starts at event n and ends at event np'
bs(i,n,np) 'amount of material undertaking task i that starts at event n and ends at event np'
ST0(s) 'initial amount of state s (not R) required from external resources'
ST(s,n) 'excess amount of state s that needs to be stored at event n'
Ts(i,n) 'time at which task i starts at event n'
Tf(i,n) 'time at which task i ends at event n'
NetP 'Net profit'
MS 'Makespan'
;

Binary variables w ;
Positive variables bs,ST,ST0,Ts,Tf ;
Free variables NetP,MS;

Equations
allocation1a
allocation2a
allocation3a
allocation4a
allocation5a

allocation1b
allocation2b
allocation3b
allocation4b
allocation5b

allocation1c
allocation2c
allocation3c
allocation4c
allocation5c

allocation1d
allocation2d
allocation3d
allocation4d
allocation5d

allocation1e
allocation2e
allocation3e
allocation4e
allocation5e

capacity1a
capacity1b

mat1a
mat1b
mat1c
mat1d

mat2a
mat2b
mat2c
mat2d

demand1

duration1
duration2
duration3

sequencestsu1
sequencestsu2

sequencedtsu1
sequencedtsu2
sequencedtsu3
sequencedtsu4
sequencedtsu5

sequencedtdu1
sequencedtdu2
sequencedtdu3

tight1
tight2
tight3
tight4
tight5

dfsp1
dfsp2
dfsp3

storage

feas1
feas2
feas3

bv1
bv2
bv3
bv4
bv5

objectivefunction
;

*ALLOCATION CONSTRAINTS
allocation1a(n).. sum(i$(Ij1(i)), sum(np$(ord(n) <= ord(np) and ord(np)<= (ord(n)+delta)), w(i,n,np))) =l= 1;
allocation2a(n).. sum(i$(Ij2(i)), sum(np$(ord(n) <= ord(np) and ord(np)<= (ord(n)+delta)), w(i,n,np))) =l= 1;
allocation3a(n).. sum(i$(Ij3(i)), sum(np$(ord(n) <= ord(np) and ord(np)<= (ord(n)+delta)), w(i,n,np))) =l= 1;
allocation4a(n).. sum(i$(Ij4(i)), sum(np$(ord(n) <= ord(np) and ord(np)<= (ord(n)+delta)), w(i,n,np))) =l= 1;
allocation5a(n).. sum(i$(Ij5(i)), sum(np$(ord(n) <= ord(np) and ord(np)<= (ord(n)+delta)), w(i,n,np))) =l= 1;

allocation1b(np).. sum(i$(Ij1(i)), sum(n$((ord(np)-delta) <= ord(n) and ord(n) <= ord(np)), w(i,n,np))) =l= 1; 
allocation2b(np).. sum(i$(Ij2(i)), sum(n$((ord(np)-delta) <= ord(n) and ord(n) <= ord(np)), w(i,n,np))) =l= 1; 
allocation3b(np).. sum(i$(Ij3(i)), sum(n$((ord(np)-delta) <= ord(n) and ord(n) <= ord(np)), w(i,n,np))) =l= 1; 
allocation4b(np).. sum(i$(Ij4(i)), sum(n$((ord(np)-delta) <= ord(n) and ord(n) <= ord(np)), w(i,n,np))) =l= 1; 
allocation5b(np).. sum(i$(Ij5(i)), sum(n$((ord(np)-delta) <= ord(n) and ord(n) <= ord(np)), w(i,n,np))) =l= 1; 

allocation1c(i,n)$(ord(i)=1).. sum(ip$(Ij1(ip) and ord(i) <> ord(ip)), sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n))) =l= 1 - sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)); 
allocation2c(i,n)$(ord(i)=2).. sum(ip$(Ij2(ip) and ord(i) <> ord(ip)), sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n))) =l= 1 - sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)); 
allocation3c(i,n)$(ord(i)=3).. sum(ip$(Ij3(ip) and ord(i) <> ord(ip)), sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n))) =l= 1 - sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)); 
allocation4c(i,n)$(ord(i)=4).. sum(ip$(Ij4(ip) and ord(i) <> ord(ip)), sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n))) =l= 1 - sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)); 
allocation5c(i,n)$(ord(i)=5).. sum(ip$(Ij5(ip) and ord(i) <> ord(ip)), sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n))) =l= 1 - sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)); 

allocation1d(i,n)$(ord(n)>1 and ord(i)=1).. sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)) =l= 1 - sum(np$(ord(np) < ord(n)), sum(npp$(ord(npp) >= ord(np) and ord(npp) <= (ord(np)+delta)), sum(ip$(Ij1(ip)),w(ip,np,npp)))) + sum(npp, sum(np$(ord(np) < ord(n) and ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta)), sum(ip$(Ij1(ip)), w(ip,npp,np)))); 
allocation2d(i,n)$(ord(n)>1 and ord(i)=2).. sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)) =l= 1 - sum(np$(ord(np) < ord(n)), sum(npp$(ord(npp) >= ord(np) and ord(npp) <= (ord(np)+delta)), sum(ip$(Ij2(ip)),w(ip,np,npp)))) + sum(npp, sum(np$(ord(np) < ord(n) and ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta)), sum(ip$(Ij2(ip)), w(ip,npp,np))));
allocation3d(i,n)$(ord(n)>1 and ord(i)=3).. sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)) =l= 1 - sum(np$(ord(np) < ord(n)), sum(npp$(ord(npp) >= ord(np) and ord(npp) <= (ord(np)+delta)), sum(ip$(Ij3(ip)),w(ip,np,npp)))) + sum(npp, sum(np$(ord(np) < ord(n) and ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta)), sum(ip$(Ij3(ip)), w(ip,npp,np))));
allocation4d(i,n)$(ord(n)>1 and ord(i)=4).. sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)) =l= 1 - sum(np$(ord(np) < ord(n)), sum(npp$(ord(npp) >= ord(np) and ord(npp) <= (ord(np)+delta)), sum(ip$(Ij4(ip)),w(ip,np,npp)))) + sum(npp, sum(np$(ord(np) < ord(n) and ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta)), sum(ip$(Ij4(ip)), w(ip,npp,np))));
allocation5d(i,n)$(ord(n)>1 and ord(i)=5).. sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), w(i,n,np)) =l= 1 - sum(np$(ord(np) < ord(n)), sum(npp$(ord(npp) >= ord(np) and ord(npp) <= (ord(np)+delta)), sum(ip$(Ij5(ip)),w(ip,np,npp)))) + sum(npp, sum(np$(ord(np) < ord(n) and ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta)), sum(ip$(Ij5(ip)), w(ip,npp,np))));

allocation1e(i,n)$(ord(i)=1).. sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(i,np,n)) =l= sum(np$(ord(np) <= ord(n)), sum(npp$(ord(np) <= ord(npp) and ord(npp) <= (ord(np)+delta)), w(i,np,npp))) - sum(npp, sum(np$(ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta) and ord(np)<ord(n)), w(i,npp,np)));
allocation2e(i,n)$(ord(i)=2).. sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(i,np,n)) =l= sum(np$(ord(np) <= ord(n)), sum(npp$(ord(np) <= ord(npp) and ord(npp) <= (ord(np)+delta)), w(i,np,npp))) - sum(npp, sum(np$(ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta) and ord(np)<ord(n)), w(i,npp,np)));
allocation3e(i,n)$(ord(i)=3).. sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(i,np,n)) =l= sum(np$(ord(np) <= ord(n)), sum(npp$(ord(np) <= ord(npp) and ord(npp) <= (ord(np)+delta)), w(i,np,npp))) - sum(npp, sum(np$(ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta) and ord(np)<ord(n)), w(i,npp,np)));
allocation4e(i,n)$(ord(i)=4).. sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(i,np,n)) =l= sum(np$(ord(np) <= ord(n)), sum(npp$(ord(np) <= ord(npp) and ord(npp) <= (ord(np)+delta)), w(i,np,npp))) - sum(npp, sum(np$(ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta) and ord(np)<ord(n)), w(i,npp,np)));
allocation5e(i,n)$(ord(i)=5).. sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(i,np,n)) =l= sum(np$(ord(np) <= ord(n)), sum(npp$(ord(np) <= ord(npp) and ord(npp) <= (ord(np)+delta)), w(i,np,npp))) - sum(npp, sum(np$(ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta) and ord(np)<ord(n)), w(i,npp,np)));

*CAPACITY CONSTRAINTS
capacity1a(i,n,np)$(ord(n)<=ord(np) and ord(np)<=(ord(n)+delta)).. Bmin(i)*w(i,n,np) =l= bs(i,n,np);
capacity1b(i,n,np)$(ord(n)<=ord(np) and ord(np)<=(ord(n)+delta)).. bs(i,n,np) =l= Bmax(i)*w(i,n,np);

*MATERIAL BALANCE
mat1a(s,n)$(ord(s)=1 and ord(n)>1).. ST(s,n) =e= ST(s,n-1) + sum(i$(Ips1(i)), sum(np$((ord(n)-1-delta) <= ord(np) and ord(np) <= (ord(n)-1)), p(i,s)*bs(i,np,n-1))) + sum(i$(Ics1(i)), sum(np$(ord(n)<=ord(np) and ord(np) <= (ord(n)+delta)), p(i,s)*bs(i,n,np)));
mat1b(s,n)$(ord(s)=2 and ord(n)>1).. ST(s,n) =e= ST(s,n-1) + sum(i$(Ips2(i)), sum(np$((ord(n)-1-delta) <= ord(np) and ord(np) <= (ord(n)-1)), p(i,s)*bs(i,np,n-1))) + sum(i$(Ics2(i)), sum(np$(ord(n)<=ord(np) and ord(np) <= (ord(n)+delta)), p(i,s)*bs(i,n,np)));
mat1c(s,n)$(ord(s)=3 and ord(n)>1).. ST(s,n) =e= ST(s,n-1) + sum(i$(Ips3(i)), sum(np$((ord(n)-1-delta) <= ord(np) and ord(np) <= (ord(n)-1)), p(i,s)*bs(i,np,n-1))) + sum(i$(Ics3(i)), sum(np$(ord(n)<=ord(np) and ord(np) <= (ord(n)+delta)), p(i,s)*bs(i,n,np)));
mat1d(s,n)$(ord(s)=4 and ord(n)>1).. ST(s,n) =e= ST(s,n-1) + sum(i$(Ips4(i)), sum(np$((ord(n)-1-delta) <= ord(np) and ord(np) <= (ord(n)-1)), p(i,s)*bs(i,np,n-1))) + sum(i$(Ics4(i)), sum(np$(ord(n)<=ord(np) and ord(np) <= (ord(n)+delta)), p(i,s)*bs(i,n,np)));

mat2a(s,n)$(ord(s)=1 and ord(n)=1).. ST(s,n) =e= ST0(s) + sum(i$(Ics1(i)), sum(np$(ord(n)<=ord(np) and ord(np)<=(ord(n)+delta)), p(i,s)*bs(i,n,np)));
mat2b(s,n)$(ord(s)=2 and ord(n)=1).. ST(s,n) =e= ST0(s) + sum(i$(Ics2(i)), sum(np$(ord(n)<=ord(np) and ord(np)<=(ord(n)+delta)), p(i,s)*bs(i,n,np)));
mat2c(s,n)$(ord(s)=3 and ord(n)=1).. ST(s,n) =e= ST0(s) + sum(i$(Ics3(i)), sum(np$(ord(n)<=ord(np) and ord(np)<=(ord(n)+delta)), p(i,s)*bs(i,n,np)));
mat2d(s,n)$(ord(s)=4 and ord(n)=1).. ST(s,n) =e= ST0(s) + sum(i$(Ics4(i)), sum(np$(ord(n)<=ord(np) and ord(np)<=(ord(n)+delta)), p(i,s)*bs(i,n,np)));

*DEMAND CONSTRAINTS
demand1(s)$(Sp(s)).. ST(s,'n13') + sum(n$(ord(n)=card(n)), sum(i$(Ips4(i)), sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), p(i,s)*bs(i,np,n)))) =g= Ds(s);

*DURATION CONSTRAINTS
duration1(i,n).. Tf(i,n) =g= Ts(i,n);
duration2(i,n,np)$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)).. Tf(i,n) =g= Ts(i,n) + a(i)*w(i,n,np) + b(i)*bs(i,n,np) - H*(1 - w(i,n,np));
duration3(i,n,np)$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)).. Tf(i,n) =l= Ts(i,n) + a(i)*w(i,n,np) + b(i)*bs(i,n,np) + H*(1 - w(i,n,np));

*SEQUENCE CONSTRAINTS
*Same Task in Same Unit
sequencestsu1(i,n)$(ord(n)<card(n)).. Ts(i,n+1) =g= Tf(i,n);
sequencestsu2(i,n)$(ord(n)<card(n)).. Ts(i,n+1) =l= Tf(i,n) + H*(1 - (sum(np$(ord(np) <= ord(n)), sum(npp$(ord(np) <= ord(npp) and ord(npp) <= (ord(np)+delta)), w(i,np,npp))) - sum(npp, sum(np$(ord(np) < ord(n) and ord(npp) <= ord(np) and ord(np) <= (ord(npp)+delta)), w(i,npp,np))))) + H*(sum(np$((ord(n)-delta) <= ord(np) and ord(np)<= ord(n)), w(i,np,n)));

*Different Task in Same Unit
sequencedtsu1(i,ip,n)$(Ij1(ip) and Ij1(i) and ord(i) <> ord(ip) and ord(n) < card(n)).. Ts(i,n+1) =g= Tf(ip,n);
sequencedtsu2(i,ip,n)$(Ij2(ip) and Ij2(i) and ord(i) <> ord(ip) and ord(n) < card(n)).. Ts(i,n+1) =g= Tf(ip,n);
sequencedtsu3(i,ip,n)$(Ij3(ip) and Ij3(i) and ord(i) <> ord(ip) and ord(n) < card(n)).. Ts(i,n+1) =g= Tf(ip,n);
sequencedtsu4(i,ip,n)$(Ij4(ip) and Ij4(i) and ord(i) <> ord(ip) and ord(n) < card(n)).. Ts(i,n+1) =g= Tf(ip,n);
sequencedtsu5(i,ip,n)$(Ij5(ip) and Ij5(i) and ord(i) <> ord(ip) and ord(n) < card(n)).. Ts(i,n+1) =g= Tf(ip,n);

*Different Task in Different Unit
sequencedtdu1(i,ip,n)$(ord(n) < card(n) and ord(i) <> ord(ip) and Ics2(i) and Ips2(ip) and not Ij1(i) and Ij1(ip)).. Ts(i,n+1) =g= Tf(ip,n) - H*(1 - sum(np$((ord(n)-delta) <= ord(np) and ord(np)<=ord(n)), w(ip,np,n)));
sequencedtdu2(i,ip,n)$(ord(n) < card(n) and ord(i) <> ord(ip) and Ics2(i) and Ips2(ip) and not Ij2(i) and Ij2(ip)).. Ts(i,n+1) =g= Tf(ip,n) - H*(1 - sum(np$((ord(n)-delta) <= ord(np) and ord(np)<=ord(n)), w(ip,np,n)));
sequencedtdu3(i,ip,n)$(ord(n) < card(n) and ord(i) <> ord(ip) and Ics3(i) and Ips3(ip) and not Ij3(i) and Ij3(ip)).. Ts(i,n+1) =g= Tf(ip,n) - H*(1 - sum(np$((ord(n)-delta) <= ord(np) and ord(np)<=ord(n)), w(ip,np,n)));

*TIGHTENING CONSTRAINTS
tight1(j).. sum(i$(Ij1(i)), sum(n, sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), a(i)*w(i,n,np) + b(i)*bs(i,n,np)))) =l= H;
tight2(j).. sum(i$(Ij2(i)), sum(n, sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), a(i)*w(i,n,np) + b(i)*bs(i,n,np)))) =l= H;
tight3(j).. sum(i$(Ij3(i)), sum(n, sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), a(i)*w(i,n,np) + b(i)*bs(i,n,np)))) =l= H;
tight4(j).. sum(i$(Ij4(i)), sum(n, sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), a(i)*w(i,n,np) + b(i)*bs(i,n,np)))) =l= H;
tight5(j).. sum(i$(Ij5(i)), sum(n, sum(np$(ord(n) <= ord(np) and ord(np) <= (ord(n)+delta)), a(i)*w(i,n,np) + b(i)*bs(i,n,np)))) =l= H;

*DEDICATED FINITE STORAGE POLOICY
dfsp1(i,ip,n)$(Ics2(i) and Ips2(ip) and Ij1(ip) and not Ij1(i) and ord(i) <> ord(ip)).. Ts(i,n+1) =l= Tf(ip,n) + H*(2 - sum(np$((ord(n)-delta) <= ord(np) and ord(np) < ord(n)), w(ip,np,n)) - sum(np$((ord(n)+1) <= ord(np) and ord(np) <= (ord(n)+1+delta)), w(i,n+1,np)));
dfsp2(i,ip,n)$(Ics2(i) and Ips2(ip) and Ij2(ip) and not Ij2(i) and ord(i) <> ord(ip)).. Ts(i,n+1) =l= Tf(ip,n) + H*(2 - sum(np$((ord(n)-delta) <= ord(np) and ord(np) < ord(n)), w(ip,np,n)) - sum(np$((ord(n)+1) <= ord(np) and ord(np) <= (ord(n)+1+delta)), w(i,n+1,np)));
dfsp3(i,ip,n)$(Ics3(i) and Ips3(ip) and Ij3(ip) and not Ij3(i) and ord(i) <> ord(ip)).. Ts(i,n+1) =l= Tf(ip,n) + H*(2 - sum(np$((ord(n)-delta) <= ord(np) and ord(np) < ord(n)), w(ip,np,n)) - sum(np$((ord(n)+1) <= ord(np) and ord(np) <= (ord(n)+1+delta)), w(i,n+1,np)));

*STORAGE CAPACITY
storage(s,n)$(Sfis(s)).. ST(s,n) =l= STmax(s);

*MATERIAL BALANCE FEASIBILITY
feas1(i,ip,n)$(Ics2(i) and Ips2(ip) and Ij1(ip) and not Ij1(i) and ord(i)<>ord(ip)).. Tf(ip,n) =g= Ts(i,n) - H*(1 - sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n)));
feas2(i,ip,n)$(Ics2(i) and Ips2(ip) and Ij2(ip) and not Ij2(i) and ord(i)<>ord(ip)).. Tf(ip,n) =g= Ts(i,n) - H*(1 - sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n)));
feas3(i,ip,n)$(Ics3(i) and Ips3(ip) and Ij3(ip) and not Ij3(i) and ord(i)<>ord(ip)).. Tf(ip,n) =g= Ts(i,n) - H*(1 - sum(np$((ord(n)-delta) <= ord(np) and ord(np) <= ord(n)), w(ip,np,n)));

*BOUNDS ON VARIABLES
bv1(i,n).. Ts(i,n) =l= H;
bv2(i,n).. Tf(i,n) =l= H;
bv3(i,n,np)$(ord(n) <= ord(np) and ord(np) <= (ord(n) + delta)).. bs(i,n,np) =l= Bmax(i);
bv4(s).. ST0(s) =l= STin(s);
bv5(s)$(Sfis(s) and Sp(s)).. ST0(s) =e= 0;

objectivefunction(i,n)$(ord(n)=card(n)).. Tf(i,n) =l= MS

model example2SF09MS /all/;

options optcr = 0.000001;
option mip = cplex;
option limrow = 100;
$onecho > cplex.opt
preind = 0
prepass = 0
preslvnd = -1
relaxpreind = 0
advind = 0
$offecho
option solvelink = 0;

solve example2SF09MS using mip minimizing MS;
