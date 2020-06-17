$Title Scheduling Multipurpose batch plants using unit-slots (BATCH)

$Ontext
This article presents a novel approach to scheduling multipurpose
batch plants, which uses unit-slots instead of process-slots to manage shared resources
such as material storage

This formulations is found in more detail:
Susarla et al. (2009)A Novel Approach to Scheduling Multipurpose
Batch Plants Using Unit-Slots: MILP Example 1. AIChe Wiley InterScience Process Systems Engineering (1862 - 1866).

Keywords:scheduling, multipurpose plants, batch processes, slot-based formulations,
unit-slots, continuous-time
$Offtext

Sets
  i 'tasks' /t1*t4/
  j 'unit' /j1*j4/
  n 'time point' /n0*n6/
  s 'storage/states' /s1*s6/
  
  Ij1(i) 'set of tasks that can be performed in unit 1' /t1/
  Ij2(i) 'set of tasks that can be performed in unit 2' /t2/
  Ij3(i) 'set of tasks that can be performed in unit 3' /t3/
  Ij4(i) 'set of tasks that can be performed in unit 4' /t4/
  
  Jt1(j) 'units that perform task 1' /j1/
  Jt2(j) 'units that perform task 2' /j2/
  Jt3(j) 'units that perform task 3' /j3/
  Jt4(j) 'units that perform task 4' /j4/
  
  alias(i,ip)
  alias(j,jp)
  alias(n,np)
;

Parameters
 pc(i,s) 'mass balance coefficient for the consumption of state s in task i'
 / t1 .s1 1
   t2 .s2 1
   t3 .s3 1
   t4 .s4 0.5
   t4 .s5 0.5 /

 pp(i,s) 'mass balance coefficient for the consumption of state s in task i'
 / t1 .s2 0.5
   t1 .s3 0.5
   t2 .s4 1
   t3 .s5 1
   t4 .s6 1   /

 a(i) 'constant term of processing time of task i'
 / t1 1.666
   t2 2.333
   t3 0.667
   t4 2.667 /
   
 b(i) 'coefficient of variable term of processing time of task i'
 / t1 0.03335
   t2 0.08335
   t3 0.0666
   t4 0.00833 /
   
 vmin(i) 'minimum batch size'
 / t1  0
   t2  0
   t3  0
   t4  0  /
   
 vmax(i) 'maximum batch size'
 / t1  40
   t2  20
   t3   5
   t4  40  /

  STmax(s) 'available max storage capacity for state s'
/  s1    +inf 
   s2     10
   s3     15
   s4     10
   s5     15
   s6    +inf /
   
  ps(s)  'price of state s'
/ s1  0
  s2  0
  s3  0
  s4  0
  s5  0
  s6  10  /
    
  stin(s) 'Initial conditions for states'
/   s1   10000
    s2   0
    s3   0
    s4   0
    s5   0
    s6   0  /

   h   'horizon time  (available time hrs)' /10/  
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
;
   
Binary variables w,y;
Positive variable bm,d,st,ts,tf;

Equations
allocation1
allocation2
allocation3
allocation4

capacity1
capacity2
capacity3
capacity4

storage1

materialbalance1a
materialbalance1b
materialbalance1c
materialbalance1d
materialbalance1e
materialbalance1f

materialbalance2a
materialbalance2b
materialbalance2c
materialbalance2d
materialbalance2e
materialbalance2f

duration1
duration2
duration3
duration4

sequence1a
sequence2a
sequence3a
sequence4a

sequence1b
sequence2b
sequence3b
sequence4b

sequence1c
sequence2c
sequence3c
sequence4c

sequence5a
sequence5b
sequence5c
sequence5d

sequence6t1j1
sequence6t2j2
sequence6t3j3

sequence7aj1
sequence7bj2
sequence7cj3
sequence7dj4

sequence8aj1
sequence8bj2
sequence8cj3
sequence8dj4

sequence9aj1
sequence9bj2
sequence9cj3
sequence9dj4

sequence10aj1
sequence10bj2
sequence10cj3
sequence10dj4

timehorizon1a
timehorizon1b
timehorizon1c
timehorizon1d

timehorizon2a
timehorizon2b
timehorizon2c
timehorizon2d

objectivefunction
;

allocation1(j,n).. sum(i$(Ij1(i)), w(i,n)) =e= y('j1',n);
allocation2(j,n).. sum(i$(Ij2(i)), w(i,n)) =e= y('j2',n);
allocation3(j,n).. sum(i$(Ij3(i)), w(i,n)) =e= y('j3',n);
allocation4(j,n).. sum(i$(Ij4(i)), w(i,n)) =e= y('j4',n);

capacity1(i,j,n)$(Jt1(j))..bm(i,j,n) =l= vmax(i)*w(i,n);
capacity2(i,j,n)$(Ij2(i))..bm(i,j,n) =l= vmax(i)*w(i,n);
capacity3(i,j,n)$(Ij3(i))..bm(i,j,n) =l= vmax(i)*w(i,n);
capacity4(i,j,n)$(Ij4(i))..bm(i,j,n) =l= vmax(i)*w(i,n);

*STORAGE CONSTRAINTS
storage1(s,n).. st(s,n) =l= STmax(s);

*MATERIAL BALANCE CONSTRAINTS
materialbalance1a.. st('s1','n0') =e= stin('s1') - sum(j$(Jt1(j)), pc('t1','s1')*bm('t1',j,'n0')) - d('s1','n0');
materialbalance1b.. st('s2','n0') =e= stin('s2') - sum(j$(Jt2(j)), pc('t2','s2')*bm('t2',j,'n0')) - d('s2','n0');
materialbalance1c.. st('s3','n0') =e= stin('s3') - sum(j$(Jt3(j)), pc('t3','s3')*bm('t3',j,'n0')) - d('s3','n0');
materialbalance1d.. st('s4','n0') =e= stin('s4') - sum(j$(Jt3(j)), pc('t4','s4')*bm('t4',j,'n0')) - d('s4','n0');
materialbalance1e.. st('s5','n0') =e= stin('s5') - sum(j$(Jt4(j)), pc('t4','s5')*bm('t4',j,'n0')) - d('s5','n0');
materialbalance1f.. st('s6','n0') =e= stin('s6') - d('s6','n0');

materialbalance2a(n)$(ord(n)>1).. st('s1',n) =e= st('s1',n-1) - sum(j$(Jt1(j)), pc('t1','s1')*bm('t1',j,n)) - d('s1',n);
materialbalance2b(n)$(ord(n)>1).. st('s2',n) =e= st('s2',n-1) - sum(j$(Jt2(j)), pc('t2','s2')*bm('t2',j,n)) + sum(j$(Jt1(j)), pp('t1','s2')*bm('t1',j,n-1)) - d('s2',n);
materialbalance2c(n)$(ord(n)>1).. st('s3',n) =e= st('s3',n-1) - sum(j$(Jt3(j)), pc('t3','s3')*bm('t3',j,n)) + sum(j$(Jt1(j)), pp('t1','s3')*bm('t1',j,n-1)) - d('s3',n);
materialbalance2d(n)$(ord(n)>1).. st('s4',n) =e= st('s4',n-1) - sum(j$(Jt3(j)), pc('t4','s4')*bm('t3',j,n)) + sum(j$(Jt2(j)), pp('t2','s4')*bm('t2',j,n-1)) - d('s4',n);
materialbalance2e(n)$(ord(n)>1).. st('s5',n) =e= st('s5',n-1) - sum(j$(Jt4(j)), pc('t4','s5')*bm('t4',j,n)) + sum(j$(Jt3(j)), pp('t3','s5')*bm('t3',j,n-1)) - d('s5',n);
materialbalance2f(n)$(ord(n)>1).. st('s6',n) =e= st('s6',n-1) + sum(j$(Jt4(j)), pp('t4','s6')*bm('t4',j,n-1)) - d('s6',n);

*DURATION CONSTRAINTS
duration1(i,j,n)$(Jt1(j) and ord(i)=1).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));
duration2(i,j,n)$(Jt2(j) and ord(i)=2).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));
duration3(i,j,n)$(Jt3(j) and ord(i)=3).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));
duration4(i,j,n)$(Jt4(j) and ord(i)=4).. tf(i,j,n) =e= ts(i,j,n) + (a(i)*w(i,n)) + (b(i)*bm(i,j,n));

*SEQUENCE CONSTRAINTS
sequence1a(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts('t1',j,n+1) =g= tf('t1',j,n) - (h * (2 - w('t1',n) - y(j,n)));
sequence2a(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts('t2',j,n+1) =g= tf('t2',j,n) - (h * (2 - w('t2',n) - y(j,n)));
sequence3a(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts('t3',j,n+1) =g= tf('t3',j,n) - (h * (2 - w('t3',n) - y(j,n)));
sequence4a(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts('t4',j,n+1) =g= tf('t4',j,n) - (h * (2 - w('t4',n) - y(j,n)));

sequence1b(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence2b(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence3b(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence4b(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);

sequence1c(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence2c(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence3c(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence4c(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);

*different task in same unit
*sequence9(i,ip,j,n)$(ord(n)<card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));
sequence5a(i,ip,j,n)$(Ij1(i) and Ij1(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j1',n+1) =g= tf(ip,'j1',n) - h*(2 - w(ip,n) - y('j1',n));
sequence5b(i,ip,j,n)$(Ij2(i) and Ij2(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j2',n+1) =g= tf(ip,'j2',n) - h*(2 - w(ip,n) - y('j2',n));
sequence5c(i,ip,j,n)$(Ij3(i) and Ij3(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j3',n+1) =g= tf(ip,'j3',n) - h*(2 - w(ip,n) - y('j3',n));
sequence5d(i,ip,j,n)$(Ij4(i) and Ij4(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j4',n+1) =g= tf(ip,'j4',n) - h*(2 - w(ip,n) - y('j4',n));

sequence6t1j1(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt2(j) and ord(i)=2 and ord(ip)=1 and ord(jp)=1).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence6t2j2(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt3(j) and ord(i)=3 and ord(ip)=2 and ord(jp)=2).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence6t3j3(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Jt4(j) and ord(i)=4 and ord(ip)=3 and ord(jp)=3).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));

sequence7aj1(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence7bj2(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence7cj3(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence7dj4(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence8aj1(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence8bj2(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence8cj3(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence8dj4(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence9aj1(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence9bj2(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence9cj3(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence9dj4(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence10aj1(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence10bj2(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence10cj3(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence10dj4(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));



*TIME HORIZON CONSTRAINTS
*timehorizon1(i,j,n).. tf(i,j,n) =l= h;

timehorizon1a(i,j,n)$Jt1(j).. tf(i,j,n) =l= h;
timehorizon1b(i,j,n)$Jt2(j).. tf(i,j,n) =l= h;
timehorizon1c(i,j,n)$Jt3(j).. tf(i,j,n) =l= h;
timehorizon1d(i,j,n)$Jt4(j).. tf(i,j,n) =l= h;

*timehorizon2(i,j,n).. ts(i,j,n) =l= h;

timehorizon2a(i,j,n)$Jt1(j).. ts(i,j,n) =l= h;
timehorizon2b(i,j,n)$Jt2(j).. ts(i,j,n) =l= h;
timehorizon2c(i,j,n)$Jt3(j).. ts(i,j,n) =l= h;
timehorizon2d(i,j,n)$Jt4(j).. ts(i,j,n) =l= h;

objectivefunction.. NetP =e= sum(s, sum(n, ps(s)*d(s,n)));
                    
model sursalaEX1floudasedited / all /;

options optcr = 0.001;
options limrow = 100;

solve sursalaEX1floudasedited using minlp maximizing NetP;
