$Ontext

This paper presents a novel mathematical formulation
for the short-term scheduling of batch plants. The proposed formulation is based on a continuous
time representation and results in a mixed integer linear programming (MILP) problem.

Ierapetritou and Floudas (1998) Effective Continuous-Time Formulation for Short-Term Scheduling.
1. Multipurpose Batch Processes. Independent Engineering Chemical Research 37 (4341-4359)

$Offtext

Sets
  i 'tasks' /t1*t5/
  j 'units'/j1*j5/
  n 'event points within time horizon' /n0*n22/
  s 'states' /s1*s4/
  
  Ij1(i) 'set of tasks performed by unit 1' /t1/
  Ij2(i) 'set of tasks performed by unit 2' /t2/
  Ij3(i) 'set of tasks performed by unit 3' /t3/
  Ij4(i) 'set of tasks performed by unit 4' /t4/
  Ij5(i) 'set of tasks performed by unit 5' /t5/
  
  Jt1(j) 'units that perform task 1' /j1/
  Jt2(j) 'units that perform task 2' /j2/
  Jt3(j) 'units that perform task 3' /j3/
  Jt4(j) 'units that perform task 2' /j4/
  Jt5(j) 'units that perform task 3' /j5/
  
 alias(i,ip)
 alias(j,jp)
 alias(n,np)
;

Scalar
   h   'horizon time (available time hrs)' /100/
;

Parameter
 tau(i,j) 'mean processing time'
/  t1.j1  2 
   t2.j2  2
   t3.j3  1.5
   t4.j4  1
   t5.j5  1      /;

 
Parameter
  a(i,j) 'constant term of processing time of task i at unit j';
  a(i,j) = (2/3)*tau(i,j);


Parameter

  vmax(i,j) 'maximum capacity of specific unit j when process task i'
/  t1 .j1   100 
   t2 .j2   150
   t3 .j3   200
   t4 .j4   150
   t5 .j5   150   /
                    
*beta formula is dividing by zero, had to calulate manually and use as many decimal   
   
Table   b(i,j) 'variable term of processing time'
            j1      j2       j3        j4        j5
    t1     0.01333
    t2             0.01333
    t3                     0.00500
    t4                               0.00445
    t5                                         0.00445
;
Parameter 

  STmax(s) 'available max storage capacity for state s'

/   s1   +inf
    s2   200
    s3   250
    s4   +inf    /
  
  ps(s) 'price of state s'
/   s1  0
    s2  0
    s3  0
    s4  5  /
    
    stin(s) 'Initial conditions for states'
/   s1  10000
    s2   0
    s3   0
    s4   0   /
    
  rm(s) 'market requirements for state s at end of time horizon'
/   s1   0
    s2   0
    s3   0
    s4   4000   /

;

Variables
   w(i,n) 'binary variable that assign the beginning of task i at event point n'
   y(j,n) 'binary variable that assign the utilization of unit j at event point n'
   bm(i,j,n) 'amount of material undertaking task i in  unit j at event point n'
   d(s,n) 'amount of state s being delivered to the market at event point n'
   st(s,n) 'amount of state s at event point n'
   ts(i,j,n) 'time that task i starts in unit j at event point n'
   tf(i,j,n) 'time that task i finishes in unit j while it starts at event point n'
   NetP 'netprofit'
   MS 'makespan';
   
Binary variables w,y;
Positive variable bm,d,st,ts,tf;

Equations
  allocation1 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation2 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation3 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation4
  allocation5
  
  
  capacity1
  capacity2
  capacity3
  capacity4
  capacity5
  
  storage1

  materialbalance1a
  materialbalance1b
  materialbalance1c
  materialbalance1d
  
  materialbalance2a
  materialbalance2b
  materialbalance2c
  materialbalance2d
  
  demand
  
  duration1
  duration2
  duration3
  duration4
  duration5
 
  sequence1a
  sequence2a
  sequence3a
  sequence4a
  sequence5a
  
  sequence1b
  sequence2b
  sequence3b
  sequence4b
  sequence5b

  sequence1c
  sequence2c
  sequence3c
  sequence4c
  sequence5c
  
sequence4aa
sequence4bb
sequence4cc
sequence4dd
sequence4ee

sequence5t1j1a
sequence5t1j1b
sequence5t2j2a
sequence5t2j2b
sequence5t3j3a
sequence5t3j3b

sequence6aj1
sequence6bj2
sequence6cj3
sequence6dj4
sequence6ej5

sequence7aj1
sequence7bj2
sequence7cj3
sequence7dj4
sequence7ej5

sequence8aj1
sequence8bj2
sequence8cj3
sequence8dj4
sequence8ej5

sequence9aj1
sequence9bj2
sequence9cj3
sequence9dj4
sequence9ej5

sequence10aj1
sequence10bj2
sequence10cj3
sequence10dj4
sequence10ej5

timehorizon1a
timehorizon1b
timehorizon1c
timehorizon1d
timehorizon1e

timehorizon2a
timehorizon2b
timehorizon2c
timehorizon2d
timehorizon2e

objectivefunction
;

*ALLOCATION CONSTRAINTS
allocation1(j,n)$(ord(j)=1).. sum(i$(Ij1(i)), w(i,n)) =e= y(j,n);
allocation2(j,n)$(ord(j)=2).. sum(i$(Ij2(i)), w(i,n)) =e= y(j,n);
allocation3(j,n)$(ord(j)=3).. sum(i$(Ij3(i)), w(i,n)) =e= y(j,n);
allocation4(j,n)$(ord(j)=4).. sum(i$(Ij4(i)), w(i,n)) =e= y(j,n);
allocation5(j,n)$(ord(j)=5).. sum(i$(Ij5(i)), w(i,n)) =e= y(j,n);

*CAPACITY CONSTRAINTS
capacity1(i,j,n)$(Jt1(j) and ord(i)=1)..bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity2(i,j,n)$(Jt2(j) and ord(i)=2)..bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity3(i,j,n)$(Jt3(j) and ord(i)=3)..bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity4(i,j,n)$(Jt4(j) and ord(i)=4)..bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity5(i,j,n)$(Jt5(j) and ord(i)=5)..bm(i,j,n) =l= vmax(i,j)*w(i,n);

*STORAGE CONSTRAINTS
storage1(s,n).. st(s,n) =l= STmax(s);

*MATERIAL BALANCE CONSTRAINTS
materialbalance1a.. st('s1','n0') =e= stin('s1') - sum(j$(Jt1(j)), bm('t1',j,'n0')) - sum(j$(Jt2(j)), bm('t2',j,'n0')) - d('s1','n0');
materialbalance1b.. st('s2','n0') =e= stin('s2') - sum(j$(Jt3(j)), bm('t3',j,'n0')) - d('s2','n0');
materialbalance1c.. st('s3','n0') =e= stin('s3') - sum(j$(Jt4(j)), bm('t4',j,'n0')) - sum(j$(Jt5(j)), bm('t5',j,'n0')) - d('s3','n0');
materialbalance1d.. st('s4','n0') =e= stin('s4') - d('s4','n0');

materialbalance2a(n)$(ord(n)>1).. st('s1',n) =e= st('s1',n-1) - sum(j$(Jt1(j)), bm('t1',j,n)) - sum(j$(Jt2(j)), bm('t2',j,n)) - d('s1',n);
materialbalance2b(n)$(ord(n)>1).. st('s2',n) =e= st('s2',n-1) - sum(j$(Jt3(j)), bm('t3',j,n)) + sum(j$(Jt1(j)), bm('t1',j,n-1)) + sum(j$(Jt2(j)), bm('t2',j,n-1)) - d('s2',n);
materialbalance2c(n)$(ord(n)>1).. st('s3',n) =e= st('s3',n-1) - sum(j$(Jt4(j)), bm('t4',j,n)) - sum(j$(Jt5(j)), bm('t5',j,n)) + sum(j$(Jt3(j)), bm('t3',j,n-1)) - d('s3',n);
materialbalance2d(n)$(ord(n)>1).. st('s4',n) =e= st('s4',n-1) + sum(j$(Jt4(j)), bm('t4',j,n-1)) + sum(j$(Jt5(j)), bm('t5',j,n-1)) - d('s4',n);

*DEMAND CONSTRAINTS
demand(s).. sum(n$(ord(n)=card(n)), d(s,n)) =g= rm(s);

*DURATION CONSTRAINTS
duration1(i,j,n)$(Jt1(j) and ord(i)=1).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration2(i,j,n)$(Jt2(j) and ord(i)=2).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration3(i,j,n)$(Jt3(j) and ord(i)=3).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration4(i,j,n)$(Jt4(j) and ord(i)=4).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration5(i,j,n)$(Jt5(j) and ord(i)=5).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));

*SEQUENCE CONSTRAINTS
sequence1a(i,j,n)$(Jt1(j) and ord(n)<>card(n) and ord(i)=1).. ts(i,j,n+1) =g= tf(i,j,n) - (h * (2 - w(i,n) - y(j,n)));
sequence2a(i,j,n)$(Jt2(j) and ord(n)<>card(n) and ord(i)=2).. ts(i,j,n+1) =g= tf(i,j,n) - (h * (2 - w(i,n) - y(j,n)));
sequence3a(i,j,n)$(Jt3(j) and ord(n)<>card(n) and ord(i)=3).. ts(i,j,n+1) =g= tf(i,j,n) - (h * (2 - w(i,n) - y(j,n)));
sequence4a(i,j,n)$(Jt4(j) and ord(n)<>card(n) and ord(i)=4).. ts(i,j,n+1) =g= tf(i,j,n) - (h * (2 - w(i,n) - y(j,n)));
sequence5a(i,j,n)$(Jt5(j) and ord(n)<>card(n) and ord(i)=5).. ts(i,j,n+1) =g= tf(i,j,n) - (h * (2 - w(i,n) - y(j,n)));


sequence1b(i,j,n)$(Jt1(j) and ord(n)<>card(n) and ord(i)=1).. ts(i,j,n+1) =g= ts(i,j,n);
sequence2b(i,j,n)$(Jt2(j) and ord(n)<>card(n) and ord(i)=2).. ts(i,j,n+1) =g= ts(i,j,n);
sequence3b(i,j,n)$(Jt3(j) and ord(n)<>card(n) and ord(i)=3).. ts(i,j,n+1) =g= ts(i,j,n);
sequence4b(i,j,n)$(Jt4(j) and ord(n)<>card(n) and ord(i)=4).. ts(i,j,n+1) =g= ts(i,j,n);
sequence5b(i,j,n)$(Jt5(j) and ord(n)<>card(n) and ord(i)=5).. ts(i,j,n+1) =g= ts(i,j,n);

sequence1c(i,j,n)$(Jt1(j) and ord(n)<>card(n) and ord(i)=1).. tf(i,j,n+1) =g= tf(i,j,n);
sequence2c(i,j,n)$(Jt2(j) and ord(n)<>card(n) and ord(i)=2).. tf(i,j,n+1) =g= tf(i,j,n);
sequence3c(i,j,n)$(Jt3(j) and ord(n)<>card(n) and ord(i)=3).. tf(i,j,n+1) =g= tf(i,j,n);
sequence4c(i,j,n)$(Jt4(j) and ord(n)<>card(n) and ord(i)=4).. tf(i,j,n+1) =g= tf(i,j,n);
sequence5c(i,j,n)$(Jt5(j) and ord(n)<>card(n) and ord(i)=5).. tf(i,j,n+1) =g= tf(i,j,n);


sequence4aa(i,ip,j,n)$(Ij1(i) and Ij1(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));
sequence4bb(i,ip,j,n)$(Ij2(i) and Ij2(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));
sequence4cc(i,ip,j,n)$(Ij3(i) and Ij3(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));
sequence4dd(i,ip,j,n)$(Ij4(i) and Ij4(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));
sequence4ee(i,ip,j,n)$(Ij5(i) and Ij5(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));

sequence5t1j1a(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt3(j) and ord(i)=3 and ord(ip)=1 and ord(jp)=1).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence5t1j1b(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt3(j) and ord(i)=3 and ord(ip)=2 and ord(jp)=2).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence5t2j2a(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt4(j) and ord(i)=4 and ord(ip)=3 and ord(jp)=3).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence5t2j2b(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt5(j) and ord(i)=5 and ord(ip)=3 and ord(jp)=3).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence5t3j3a(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt3(j) and ord(i)=3 and ord(ip)=4 and ord(jp)=4).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence5t3j3b(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt3(j) and ord(i)=3 and ord(ip)=5 and ord(jp)=5).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));

sequence6aj1(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij1(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence6bj2(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij2(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence6cj3(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij3(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence6dj4(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij4(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence6ej5(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij5(ip)), tf(ip,j,np) - ts(ip,j,np)));

sequence7aj1(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij1(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence7bj2(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij2(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence7cj3(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij3(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence7dj4(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij4(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence7ej5(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij5(ip)), tf(ip,j,np) - ts(ip,j,np)));

sequence8aj1(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij1(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence8bj2(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij2(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence8cj3(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij3(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence8dj4(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij4(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence8ej5(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij5(ip)), tf(ip,j,np) - ts(ip,j,np)));

sequence9aj1(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij1(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence9bj2(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij2(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence9cj3(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij3(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence9dj4(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij4(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence9ej5(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij5(ip)), tf(ip,j,np) - ts(ip,j,np)));

sequence10aj1(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij1(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence10bj2(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij2(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence10cj3(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij3(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence10dj4(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij4(ip)), tf(ip,j,np) - ts(ip,j,np)));
sequence10ej5(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) <= ord(n)), sum(ip$(Ij5(ip)), tf(ip,j,np) - ts(ip,j,np)));

*TIME HORIZON CONSTRAINTS
*timehorizon1(i,j,n).. tf(i,j,n) =l= h;

timehorizon1a(i,j,n)$Jt1(j).. tf(i,j,n) =l= h;
timehorizon1b(i,j,n)$Jt2(j).. tf(i,j,n) =l= h;
timehorizon1c(i,j,n)$Jt3(j).. tf(i,j,n) =l= h;
timehorizon1d(i,j,n)$Jt4(j).. tf(i,j,n) =l= h;
timehorizon1e(i,j,n)$Jt5(j).. tf(i,j,n) =l= h;

*timehorizon2(i,j,n).. ts(i,j,n) =l= h;

timehorizon2a(i,j,n)$Jt1(j).. ts(i,j,n) =l= h;
timehorizon2b(i,j,n)$Jt2(j).. ts(i,j,n) =l= h;
timehorizon2c(i,j,n)$Jt3(j).. ts(i,j,n) =l= h;
timehorizon2d(i,j,n)$Jt4(j).. ts(i,j,n) =l= h;
timehorizon2e(i,j,n)$Jt5(j).. ts(i,j,n) =l= h;

*objectivefunction.. NetP =e= sum(s, sum(n, ps(s)*d(s,n)));
objectivefunction(i,j,n)$(ord(n)=card(n)).. tf(i,j,n) =l= MS;              
model sursalaEX3floudasediteda / all /;

options optcr = 0.000001;
sursalaEX3floudasediteda.optfile = 1
option mip = cplex;
option limrow = 100;
$onecho > cplex.opt
preind = 0
prepass = 0
preslvnd = -1
relaxpreind = 0
advind = 0
$offecho
sursalaEX3floudasediteda.threads = 1;
option solvelink = 0;

solve sursalaEX3floudasediteda using mip minimizing MS;