  Sets
    i 'tasks' /t1*t5/
    j 'units'/j1*j4/
    n 'event points within time horizon' /n0*n4/
    s 'states' /s1*s9/
    
  Ij1(i) 'set of tasks performed by unit 1' /t1/
  Ij2(i) 'set of tasks performed by unit 2' /t2*t4/
  Ij3(i) 'set of tasks performed by unit 3' /t2*t4/
  Ij4(i) 'set of tasks performed by unit 4' /t5/
  
  Jt1(j) 'units that perform task 1' /j1/
  Jt2(j) 'units that perform task 2' /j2*j3/
  Jt3(j) 'units that perform task 3' /j2*j3/
  Jt4(j) 'units that perform task 4' /j2*j3/
  Jt5(j) 'units that perform task 5' /j4/
    alias(i,ip)
    alias(j,jp)
    alias(n,np);
    
*Please note
*s1 - FeedA, s2 - HotA, s3 - Product1, s4 - IntBC, s5 - FeedB, s6 - FeedC, s7 - IntAB, s8 - ImpureE, s9 - Product2
*t1 - heating, t2 -reaction1, t3 - reaction2, t4 - reaction 3, t5 - separation
*j1 - heater, j2 - reactor 1, j3 - reactor, j4 - purificator

Parameters

a(i,j) 'variable duration of task i'
/ t1. j1  0.667
  t2 .j2  1.334
  t2 .j3  1.334
  t3 .j2  1.334
  t3 .j3  1.334
  t4 .j2  0.667
  t4 .j3  0.667
  t5 .j4  1.3342      /

b(i,j) 'fixed duration of task i'
/ t1. j1  0.00667
  t2 .j2  0.02664
  t2 .j3  0.01665
  t3 .j2  0.02664
  t3 .j3  0.01665
  t4 .j2  0.01332
  t4 .j3  0.00833
  t5 .j4  0.00666      /

vmin(i,j) 'Lower bound on the batch size of task i'
/  t1 .(j1*j4)   0
   t2 .(j1*j4)   0
   t3 .(j1*j4)   0
   t4 .(j1*j4)   0     /

vmax(i,j) 'Upper bound on the batch size of task i'
/  t1 .j1   100
   t2 .j2   50
   t2 .j3   80
   t3 .j2   50
   t3 .j3   80
   t4 .j2   50
   t4 .j3   80
   t5 .j4   200   /
 
pc(i,s) 'mass balance coefficient for the consumption of state s in task i'
/ t1 .s1  1
  t2 .s2  0.4
  t2 .s4  0.6
  t3 .s5  0.5
  t3 .s6  0.5
  t4 .s6  0.2
  t4 .s7  0.8
  t5 .s8  1      /

pp(i,s) 'mass balance coefficient for the production of state s in task i'
/ t1  .s2 1
  t2  .s3 0.4
  t2  .s7 0.6
  t3  .s4 1
  t4  .s8 1
  t5  .s7 0.1
  t5  .s9 0.9    /

STmax(s) 'available max storage capacity for state s'
/s1    100000
 s2     100
 s3    100000
 s4     150
 s5    100000
 s6    100000
 s7     200
 s8     200
 s9    100000   /
 
ps(s)  'price of state s'
/   s1  0
    s2  0
    s3  10
    s4  0
    s5  0
    s6  0
    s7  0
    s8  0
    s9  10       /

stin(s) 'Initial conditions for states'
/   s1  100000
    s2   0
    s3   0
    s4   0
    s5  100000
    s6  100000
    s7   0
    s8   0
    s9   0        /

  h   'horizon time  (available time hrs)' /8/
*market requirements hav not been specified, text advises us not to utilise demand constraints, made an assumption here
*r 'market requirements for state s at end of time horizon' /900/
;

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
allocation2
allocation3
allocation4

capacity1 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
capacity2
capacity3
capacity4
capacity5

storage1

materialbalance1a
materialbalance1b
materialbalance1c
materialbalance1d
materialbalance1e
materialbalance1f
materialbalance1g
materialbalance1h
materialbalance1i

materialbalance2a
materialbalance2b
materialbalance2c
materialbalance2d
materialbalance2e
materialbalance2f
materialbalance2g
materialbalance2h
materialbalance2i

duration1
duration2
duration3
duration4
duration5

sequence1a
sequence1b
sequence1c
sequence2a
sequence2b
sequence2c
sequence3a
sequence3b
sequence3c
sequence4a
sequence4b
sequence4c
sequence5a
sequence5b
sequence5c

*sequence7
sequence6a
sequence6b
sequence6c
sequence6d

sequence7j1
sequence7j2a
sequence7j3a
sequence7j2b
sequence7j3b
sequence7j2c
sequence7j3c
*sequence7j4

*sequence8

$ontext
sequence7a
sequence7b
sequence7c
sequence7d
$offtext

sequence9aj1
sequence9bj2
sequence9cj3
sequence9dj4

sequence10aj1
sequence10bj2
sequence10cj3
sequence10dj4

sequence11aj1
sequence11bj2
sequence11cj3
sequence11dj4

sequence12aj1
sequence12bj2
sequence12cj3
sequence12dj4

sequence13aj1
sequence13bj2
sequence13cj3
sequence13dj4

*timehorizon1
timehorizon1a
timehorizon1b
timehorizon1c
timehorizon1d

*timehorizon2
timehorizon2a
timehorizon2b
timehorizon2c
timehorizon2d

objectivefunction
;

*ALLOCATION CONSTRAINTS
allocation1(j,n).. sum(i$(Ij1(i)), w(i,n)) =e= y('j1',n);
allocation2(j,n).. sum(i$(Ij2(i)), w(i,n)) =e= y('j2',n);
allocation3(j,n).. sum(i$(Ij3(i)), w(i,n)) =e= y('j3',n);
allocation4(j,n).. sum(i$(Ij4(i)), w(i,n)) =e= y('j4',n);

*CAPACITY CONSTRAINTS
capacity1(i,j,n)$(Jt1(j) and ord(i)=1).. bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity2(i,j,n)$(Jt2(j) and ord(i)=2).. bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity3(i,j,n)$(Jt3(j) and ord(i)=3).. bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity4(i,j,n)$(Jt4(j) and ord(i)=4).. bm(i,j,n) =l= vmax(i,j)*w(i,n);
capacity5(i,j,n)$(Jt5(j) and ord(i)=5).. bm(i,j,n) =l= vmax(i,j)*w(i,n);

  
*STORAGE CONSTRAINTS
storage1(s,n).. st(s,n) =l= STmax(s);
   
*MATERIAL BALANCE CONSTRAINTS
materialbalance1a.. st('s1','n0') =e= stin('s1') - sum(j$(Jt1(j)), pc('t1','s1')*bm('t1',j,'n0')) - d('s1','n0');
materialbalance1b.. st('s2','n0') =e= stin('s2') - sum(j$(Jt2(j)), pc('t2','s2')*bm('t2',j,'n0')) - d('s2','n0');
materialbalance1c.. st('s3','n0') =e= stin('s3') - d('s3','n0');
materialbalance1d.. st('s4','n0') =e= stin('s4') - sum(j$(Jt2(j)), pc('t2','s4')*bm('t2',j,'n0')) - d('s4','n0');
materialbalance1e.. st('s5','n0') =e= stin('s5') - sum(j$(Jt3(j)), pc('t3','s5')*bm('t3',j,'n0')) - d('s5','n0');
materialbalance1f.. st('s6','n0') =e= stin('s6') - sum(j$(Jt3(j)), pc('t3','s6')*bm('t3',j,'n0')) - sum(j$(Jt4(j)), pc('t4','s6')*bm('t4',j,'n0')) - d('s6','n0');
materialbalance1g.. st('s7','n0') =e= stin('s7') - sum(j$(Jt4(j)), pc('t4','s7')*bm('t4',j,'n0')) - d('s7','n0');
materialbalance1h.. st('s8','n0') =e= stin('s8') - sum(j$(Jt5(j)), pc('t5','s8')*bm('t5',j,'n0')) - d('s8','n0');
materialbalance1i.. st('s9','n0') =e= stin('s9') - d('s9','n0');

materialbalance2a(n)$(ord(n)>1).. st('s1',n) =e= st('s1',n-1) - sum(j$(Jt1(j)), pc('t1','s1')*bm('t1',j,n)) - d('s1',n);
materialbalance2b(n)$(ord(n)>1).. st('s2',n) =e= st('s2',n-1) - sum(j$(Jt2(j)), pc('t2','s2')*bm('t1',j,n)) + sum(j$(Jt1(j)), pp('t1','s2')*bm('t1',j,n-1)) - d('s2',n);
materialbalance2c(n)$(ord(n)>1).. st('s3',n) =e= st('s3',n-1) + sum(j$(Jt2(j)), pp('t2','s3')*bm('t2',j,n-1)) - d('s3',n);
materialbalance2d(n)$(ord(n)>1).. st('s4',n) =e= st('s4',n-1) - sum(j$(Jt2(j)), pc('t2','s4')*bm('t2',j,n)) + sum(j$(Jt3(j)), pp('t3','s4')*bm('t3',j,n-1)) - d('s4',n);
materialbalance2e(n)$(ord(n)>1).. st('s5',n) =e= st('s5',n-1) - sum(j$(Jt3(j)), pc('t3','s5')*bm('t3',j,n)) - d('s5',n);
materialbalance2f(n)$(ord(n)>1).. st('s6',n) =e= st('s6',n-1) - sum(j$(Jt3(j)), pc('t3','s6')*bm('t3',j,n)) - sum(j$(Jt4(j)), pc('t4','s6')*bm('t4',j,n-1)) - d('s6',n);
materialbalance2g(n)$(ord(n)>1).. st('s7',n) =e= st('s7',n-1) - sum(j$(Jt4(j)), pc('t4','s7')*bm('t4',j,n)) + sum(j$(Jt2(j)), pp('t2','s7')*bm('t2',j,n-1)) + sum(j$(Jt5(j)), pp('t5','s7')*bm('t5',j,n-1)) - d('s7',n);
materialbalance2h(n)$(ord(n)>1).. st('s8',n) =e= st('s8',n-1) - sum(j$(Jt5(j)), pc('t5','s8')*bm('t5',j,n)) + sum(j$(Jt4(j)), pp('t4','s8')*bm('t4',j,n-1)) - d('s8',n);
materialbalance2i(n)$(ord(n)>1).. st('s9',n) =e= st('s9',n-1) + sum(j$(Jt5(j)), pp('t5','s9')*bm('t5',j,n-1)) - d('s9',n);
 
*DURATION CONSTRAINTS
duration1(i,j,n)$(Jt1(j) and ord(i)=1).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration2(i,j,n)$(Jt2(j) and ord(i)=2).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration3(i,j,n)$(Jt3(j) and ord(i)=3).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration4(i,j,n)$(Jt4(j) and ord(i)=4).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));
duration5(i,j,n)$(Jt5(j) and ord(i)=5).. tf(i,j,n) =e= ts(i,j,n) + (a(i,j)*w(i,n)) + (b(i,j)*bm(i,j,n));

*DEMAND
*demand(s).. sum(n, d(s,n)) =g= r;
 
*SEQUENCE CONSTRAINTS
sequence1a(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts('t1',j,n+1) =g= tf('t1',j,n) - (h * (2 - w('t1',n) - y(j,n)));
sequence2a(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts('t2',j,n+1) =g= tf('t2',j,n) - (h * (2 - w('t2',n) - y(j,n)));
sequence3a(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts('t3',j,n+1) =g= tf('t3',j,n) - (h * (2 - w('t3',n) - y(j,n)));
sequence4a(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts('t4',j,n+1) =g= tf('t4',j,n) - (h * (2 - w('t4',n) - y(j,n)));
sequence5a(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts('t5',j,n+1) =g= tf('t5',j,n) - (h * (2 - w('t5',n) - y(j,n)));

sequence1b(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence2b(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence3b(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence4b(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);
sequence5b(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= ts(i,j,n);

sequence1c(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence2c(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence3c(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence4c(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
sequence5c(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. tf(i,j,n+1) =g= tf(i,j,n);
 
*sequence of differemt tasks in same units   
sequence6a(i,ip,j,n)$(Ij1(i) and Ij1(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j1',n+1) =g= tf(ip,'j1',n) - h*(2 - w(ip,n) - y('j1',n));
sequence6b(i,ip,j,n)$(Ij2(i) and Ij2(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j2',n+1) =g= tf(ip,'j2',n) - h*(2 - w(ip,n) - y('j2',n));
sequence6c(i,ip,j,n)$(Ij3(i) and Ij3(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j3',n+1) =g= tf(ip,'j3',n) - h*(2 - w(ip,n) - y('j3',n));
sequence6d(i,ip,j,n)$(Ij4(i) and Ij4(ip) and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,'j4',n+1) =g= tf(ip,'j4',n) - h*(2 - w(ip,n) - y('j4',n));

*sequence different tasks for different units
*sequence8(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));



sequence7j1(i,ip,j,jp,n)$(Jt3(j) and ord(i)=3 and ord(ip)=1 and ord(jp)=1 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7j2a(i,ip,j,jp,n)$(Jt2(j) and ord(i)=2 and ord(ip)=3 and ord(jp)=2 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7j3a(i,ip,j,jp,n)$(Jt2(j) and ord(i)=2 and ord(ip)=3 and ord(jp)=3 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7j2b(i,ip,j,jp,n)$(Jt4(j) and ord(i)=4 and ord(ip)=2 and ord(jp)=2 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7j3b(i,ip,j,jp,n)$(Jt4(j) and ord(i)=4 and ord(ip)=2 and ord(jp)=3 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7j2c(i,ip,j,jp,n)$(Jt5(j) and ord(i)=5 and ord(ip)=4 and ord(jp)=2 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7j3c(i,ip,j,jp,n)$(Jt5(j) and ord(i)=5 and ord(ip)=4 and ord(jp)=3 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
*sequence7j4(i,ip,j,jp,n)$(Jt4(j) and ord(i)=4 and ord(ip)=5 and ord(jp)=4 and ord(n)<>card(n) and ord(i)<>ord(ip)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));


$ontext
sequence7a(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Ij1(ip) and Ij1(i) and ord(j)=1).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7b(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Ij2(ip) and Ij2(i) and ord(j)=2).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7c(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Ij3(ip) and Ij3(i) and ord(j)=3).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
sequence7d(i,ip,j,jp,n)$(ord(n)<>card(n) and ord(i)<>ord(ip) and Ij4(ip) and Ij4(i) and ord(j)=4).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));
$offtext

*sequence9(i,j,n)$(ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip, tf(ip,j,np) - ts(ip,j,np)));
 
sequence9aj1(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence9bj2(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence9cj3(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence9dj4(i,j,n)$(Jt1(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence10aj1(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence10bj2(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence10cj3(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence10dj4(i,j,n)$(Jt2(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence11aj1(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence11bj2(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence11cj3(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence11dj4(i,j,n)$(Jt3(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence12aj1(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence12bj2(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence12cj3(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence12dj4(i,j,n)$(Jt4(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

sequence13aj1(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij1(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence13bj2(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij2(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence13cj3(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij3(i)), tf(ip,j,np) - ts(ip,j,np)));
sequence13dj4(i,j,n)$(Jt5(j) and ord(n)<>card(n)).. ts(i,j,n+1) =g= sum(np$(ord(np) le ord(n)), sum(ip$(Ij4(i)), tf(ip,j,np) - ts(ip,j,np)));

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

model kondiliEX1floudas / all /;
options optcr = 0.001;

solve kondiliEX1floudas using minlp maximizing NetP;
