$Ontext

This paper presents a novel mathematical formulation
for the short-term scheduling of batch plants. The proposed formulation is based on a continuous
time representation and results in a mixed integer linear programming (MILP) problem.

Ierapetritou and Floudas (1998) Effective Continuous-Time Formulation for Short-Term Scheduling.
1. Multipurpose Batch Processes. Independent Engineering Chemical Research 37 (4341-4359)

$Offtext

Sets
  i 'tasks' /t1*t3/
  j 'units'/j1*j3/
  n 'event points within time horizon' /n0*n4/
  s 'states' /s1*s4/
  
  
  Ij1(i) 'set of tasks performed by unit 1' /t1/
  Ij2(i) 'set of tasks performed by unit 2' /t2/
  Ij3(i) 'set of tasks performed by unit 3' /t3/
  
  Jt1(j) 'units that perform task 1' /j1/
  Jt2(j) 'units that perform task 2' /j2/
  Jt3(j) 'units that perform task 3' /j3/
  
 alias(i,ip)
 alias(j,jp)
 alias(n,np)
;
  
Parameter
  Vmin(i) 'minimum amount of mateial processed by task i required to start operating unit j'   
  / t1   0
    t2   0
    t3   0   /

  Vmax(i) 'maximum capacity of specific unit j when process task i'
/   t1   100
    t2   75
    t3   50   /

  STmax(s) 'available max storage capacity for state s'
*unlimited = 100 000
/   s1   +inf
    s2   100
    s3   100
    s4   +inf    /
 
  a(i) 'constant ter of processing time of task i at unit j'
/   t1  3.0
    t2  2.0
    t3  1.0  /
  
  b(i) 'varaible term of processing time of task i at unit j expressing time required by unit j to process one unit of materil performing task i'
/   t1  0.03
    t2  0.0266
    t3  0.02  /
  
  ps(s) 'price of state s'
/   s1  0
    s2  0
    s3  0
    s4  1  /
    
    stin(s) 'Initial conditions for states'
/   s1  10000
    s2   0
    s3   0
    s4   0   /
    

   h   'horizon time  (available time hrs)' /10/
*market requirements hav not been specified, text advises us not to utilise demand constraints, made an assumption here
   r 'market requirements for state s at end of time horizon' /100/;

Variables
   w(i,n) 'binary variable that assign the beginning of task i at event point n'
   y(j,n) 'binary variable that assign the utilization of unit j at event point n'
   bm(i,j,n) 'amount of material undertaking task i in  unit j at event point n'
   d(s,n) 'amount of state s being delivered to the market at event point n'
   st(s,n) 'amount of state s at event point n'
   ts(i,j,n) 'time that task i starts in unit j at event point n'
   tf(i,j,n) 'time that task i finishes in unit j while it starts at event point n'
   NetP 'netprofit';
   
Binary variables w,y;
Positive variable bm,d,st,ts,tf;

Equations

  allocation1 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation2 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation3 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  
  capacity1
  capacity2
  capacity3
  
  storage1

  materialbalance1a
  materialbalance1b
  materialbalance1c
  materialbalance1d
  
  materialbalance2a
  materialbalance2b
  materialbalance2c
  materialbalance2d
  
  duration1
  duration2
  duration3
  
  sequence1a
  sequence2a
  sequence3a
   
  sequence1b
  sequence2b
  sequence3b

  sequence1c
  sequence2c
  sequence3c
  
sequence4a
sequence4b
sequence4c

sequence5t1j1
sequence5t2j2

sequence6aj1
sequence6bj2
sequence6cj3

sequence7aj1
sequence7bj2
sequence7cj3

sequence8aj1
sequence8bj2
sequence8cj3

timehorizon1a
timehorizon1b
timehorizon1c

timehorizon2a
timehorizon2b
timehorizon2c

objectivefunction
;

*ALLOCATION CONSTRAINTS
allocation1(j,n).. sum(i$(Ij1(i)), w(i,n)) =e= y('j1',n);
allocation2(j,n).. sum(i$(Ij2(i)), w(i,n)) =e= y('j2',n);
allocation3(j,n).. sum(i$(Ij3(i)), w(i,n)) =e= y('j3',n);

*CAPACITY CONSTRAINTS
capacity1(i,j,n)$(Jt1(j))..bm(i,j,n) =l= vmax(i)*w(i,n);
capacity2(i,j,n)$(Jt2(j))..bm(i,j,n) =l= vmax(i)*w(i,n);
capacity3(i,j,n)$(Jt3(j))..bm(i,j,n) =l= vmax(i)*w(i,n);

*STORAGE CONSTRAINTS
storage1(s,n).. st(s,n) =l= STmax(s);

*MATERIAL BALANCE CONSTRAINTS
materialbalance1a.. st('s1','n0') =e= stin('s1') - sum(j$(Jt1(j)), bm('t1',j,'n0')) - d('s1','n0');
materialbalance1b.. st('s2','n0') =e= stin('s2') - sum(j$(Jt2(j)), bm('t2',j,'n0')) - d('s2','n0');
materialbalance1c.. st('s3','n0') =e= stin('s3') - sum(j$(Jt3(j)), bm('t3',j,'n0')) - d('s3','n0');
materialbalance1d.. st('s4','n0') =e= stin('s4') - d('s4','n0');

materialbalance2a(n)$(ord(n)>1).. st('s1',n) =e= st('s1',n-1) - sum(j$(Jt1(j)), bm('t1',j,n)) - d('s1',n);
materialbalance2b(n)$(ord(n)>1).. st('s2',n) =e= st('s2',n-1) - sum(j$(Jt2(j)), bm('t2',j,n)) + sum(j$(Jt1(j)), bm('t1',j,n-1)) - d('s2',n);
materialbalance2c(n)$(ord(n)>1).. st('s3',n) =e= st('s3',n-1) - sum(j$(Jt3(j)), bm('t3',j,n)) + sum(j$(Jt2(j)), bm('t2',j,n-1)) - d('s3',n);
materialbalance2d(n)$(ord(n)>1).. st('s4',n) =e= st('s4',n-1) + sum(j$(Jt3(j)), bm('t3',j,n-1)) - d('s4',n);

*DURATION CONSTRAINTS
duration1(i,j,n)$(Jt1(j) and ord(i)=1).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));
duration2(i,j,n)$(Jt2(j) and ord(i)=2).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));
duration3(i,j,n)$(Jt3(j) and ord(i)=3).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));

*SEQUENCE CONSTRAINTS
sequence1a(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts('t1',j,n+1) =g= tf('t1',j,n) - (h * (2 - w('t1',n) - y(j,n)));
sequence2a(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts('t2',j,n+1) =g= tf('t2',j,n) - (h * (2 - w('t2',n) - y(j,n)));
sequence3a(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts('t3',j,n+1) =g= tf('t3',j,n) - (h * (2 - w('t3',n) - y(j,n)));

sequence1b(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence2b(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence3b(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);

sequence1c(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence2c(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence3c(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);

sequence4a(i,ip,j,n)$(Ij1(i) and Ij1(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j1',n+1) =g= tf(ip,'j1',n) - h*(2 - w(ip,n) - y('j1',n));
sequence4b(i,ip,j,n)$(Ij2(i) and Ij2(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j2',n+1) =g= tf(ip,'j2',n) - h*(2 - w(ip,n) - y('j2',n));
sequence4c(i,ip,j,n)$(Ij3(i) and Ij3(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j3',n+1) =g= tf(ip,'j3',n) - h*(2 - w(ip,n) - y('j3',n));

sequence5t1j1(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt2(j) and ord(i)=2 and ord(ip)=1 and ord(jp)=1).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence5t2j2(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt3(j) and ord(i)=3 and ord(ip)=2 and ord(jp)=2).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));

sequence6aj1(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence6bj2(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence6cj3(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence7aj1(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence7bj2(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence7cj3(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence8aj1(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence8bj2(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence8cj3(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));

*TIME HORIZON CONSTRAINTS
*timehorizon1(i,j,n).. tf(i,j,n) =l= h;

timehorizon1a(i,j,n)$Jt1(j).. tf(i,j,n) =l= h;
timehorizon1b(i,j,n)$Jt2(j).. tf(i,j,n) =l= h;
timehorizon1c(i,j,n)$Jt3(j).. tf(i,j,n) =l= h;

*timehorizon2(i,j,n).. ts(i,j,n) =l= h;

timehorizon2a(i,j,n)$Jt1(j).. ts(i,j,n) =l= h;
timehorizon2b(i,j,n)$Jt2(j).. ts(i,j,n) =l= h;
timehorizon2c(i,j,n)$Jt3(j).. ts(i,j,n) =l= h;

objectivefunction.. NetP =e= sum(s, sum(n, ps(s)*d(s,n)));
                    
model floudasEX1 / all /;

options optcr = 0.0001;
options limrow = 100;

solve floudasEX1 using minlp maximizing NetP;
