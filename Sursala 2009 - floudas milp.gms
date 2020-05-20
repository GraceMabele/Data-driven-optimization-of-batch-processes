$Title Scheduling Multipurpose batch plants using unit-slots (BATCH, SEQ=1)

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
* K is unknown, assume 20 slots
  n 'time point' /n0*n4/
  s 'storage/states' /s1*s6/
  alias(i,ip)
  alias(j,jp)
  alias(n,np)
;

Table pc(i,s) 'mass balance coefficient for the consumption of state s in task i'
         s1    s2   s3   s4   s5   s6   
   t1    1     0    0    0    0    0    
   t2    0     1    0    0    0    0    
   t3    0     0    1    0    0    0    
   t4    0     0    0   0.5  0.5   0     ;
   
Table pp(i,s) 'mass balance coefficient for the consumption of state s in task i'
         s1    s2   s3   s4   s5   s6   
   t1    0    0.5  0.5   0    1    0    
   t2    0     0    0    1    0    0    
   t3    0     0    0    0    1    0    
   t4    0     0    0    0    0    1     ;


Parameters
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
   t2   5
   t3  20
   t4  40  /

  STmax(s) 'available max storage capacity for state s'
/  s1    100000 
   s2     10
   s3     15
   s4     10
   s5     15
   s6    100000 /
   
  ps(s)  'price of state s'
/ s1  0
  s2  0
  s3  0
  s4  0
  s5  0
  s6  10  /
    
  stin(s) 'Initial conditions for states'
/   s1   100000
    s2   0
    s3   0
    s4   0
    s5   0
    s6   0  /

   h   'horizon time  (available time hrs)' /10/
*market requirements hav not been specified, text advises us not to utilise demand constraints, made an assumption here
   r 'market requirements for state s at end of time horizon' /900/   
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
  allocation1 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation2 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation3 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation4
  capacity1 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  capacity2 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  capacity3 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  capacity4 
  storage1'represent the maximum available storage capacity for each state s at each event point n'
  storage2'represent the maximum available storage capacity for each state s at each event point n'
  storage3'represent the maximum available storage capacity for each state s at each event point n'
  storage4'represent the maximum available storage capacity for each state s at each event point n'
  storage5
  storage6
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
  sequence6
  sequence7
  sequence8
  timehorizon1
  timehorizon2
  objectivefunction
  
;

*ALLOCATION CONSTRAINTS
allocation1(n).. w('t1',n) =e= y('j1',n);
allocation2(n).. w('t2',n) =e= y('j2',n);
allocation3(n).. w('t3',n) =e= y('j3',n);
allocation4(n).. w('t4',n) =e= y('j4',n);

                  
*CAPACITY CONSTRAINTS
*vmin is zero
capacity1(n).. bm('t1','j1',n) =l= vmax('t1')*w('t1',n);
capacity2(n).. bm('t2','j2',n) =l= vmax('t2')*w('t2',n);
capacity3(n).. bm('t3','j3',n) =l= vmax('t3')*w('t3',n);
capacity4(n).. bm('t4','j4',n) =l= vmax('t4')*w('t4',n);

*STORAGE CONSTRAINTS
storage1(n).. st('s1',n) =l= STmax('s1');

storage2(n).. st('s2',n) =l= STmax('s2');

storage3(n).. st('s3',n) =l= STmax('s3');

storage4(n).. st('s4',n) =l= STmax('s4');

storage5(n).. st('s5',n) =l= STmax('s5');

storage6(n).. st('s6',n) =l= STmax('s6');

*MATERIAL BALANCES
materialbalance1a(j).. st('s1','n0') =e= stin('s1') - pc('t1','s1')*bm('t1',j,'n0');
materialbalance1b(j).. st('s2','n0') =e= stin('s2') - pc('t2','s2')*bm('t2',j,'n0');
materialbalance1c(j).. st('s3','n0') =e= stin('s3') - pc('t3','s3')*bm('t3',j,'n0');
materialbalance1d(j).. st('s4','n0') =e= stin('s4') - pc('t4','s4')*bm('t4',j,'n0');
materialbalance1e(j).. st('s5','n0') =e= stin('s5') - pc('t4','s5')*bm('t4',j,'n0');
materialbalance1f(j).. st('s6','n0') =e= stin('s6') - d('s6','n0');

materialbalance2a(j,n)$(ord(n)>1).. st('s1',n) =e= st('s1',n-1) - pc('t1','s1')*bm('t1',j,n);
materialbalance2b(j,n)$(ord(n)>1).. st('s2',n) =e= st('s2',n-1) - pc('t2','s2')*bm('t2',j,n) + pp('t1','s2')*bm('t1',j,n-1);
materialbalance2c(j,n)$(ord(n)>1).. st('s3',n) =e= st('s3',n-1) + pp('t1','s3')*bm('t1',j,n-1) - pc('t3','s3')*bm('t3',j,n);
materialbalance2d(j,n)$(ord(n)>1).. st('s4',n) =e= st('s4',n-1) + pp('t2','s4')*bm('t2',j,n-1) - pc('t4','s4')*bm('t4',j,n);
materialbalance2e(j,n)$(ord(n)>1).. st('s5',n) =e= st('s5',n-1) - pc('t4','s5')*bm('t4',j,n) + pp('t3','s5')*bm('t3',j,n-1);
materialbalance2f(j,n)$(ord(n)>1).. st('s6',n) =e= st('s6',n-1) + pp('t4','s6')*bm('t4',j,n-1) - d('s6',n);

*DURATION
duration1(j,n).. tf('t1',j,n) =e= ts('t1',j,n) + (a('t1')*w('t1',n)) + (b('t1')*bm('t1',j,n));
duration2(j,n).. tf('t2',j,n) =e= ts('t2',j,n) + (a('t2')*w('t2',n)) + (b('t2')*bm('t2',j,n));
duration3(j,n).. tf('t3',j,n) =e= ts('t3',j,n) + (a('t3')*w('t3',n)) + (b('t3')*bm('t3',j,n));
duration4(j,n).. tf('t4',j,n) =e= ts('t4',j,n) + (a('t4')*w('t4',n)) + (b('t4')*bm('t4',j,n));

*SEQUENCE CONSTRAINTS
sequence1a(j,n)$(ord(n)<card(n)).. ts('t1',j,n+1) =g= tf('t1',j,n) - (h * (2 - w('t1',n) - y(j,n)));
sequence1b(j,n)$(ord(n)<card(n)).. ts('t1',j,n+1) =g= ts('t1',j,n);
sequence1c(j,n)$(ord(n)<card(n)).. tf('t1',j,n+1) =g= tf('t1',j,n);

sequence2a(j,n)$(ord(n)<card(n)).. ts('t2',j,n+1) =g= tf('t2',j,n) - (h * (2 - w('t2',n) - y(j,n)));
sequence2b(j,n)$(ord(n)<card(n)).. ts('t2',j,n+1) =g= ts('t2',j,n);
sequence2c(j,n)$(ord(n)<card(n)).. tf('t2',j,n+1) =g= tf('t2',j,n);

sequence3a(j,n)$(ord(n)<card(n)).. ts('t3',j,n+1) =g= tf('t3',j,n) - (h * (2 - w('t3',n) - y(j,n)));
sequence3b(j,n)$(ord(n)<card(n)).. ts('t3',j,n+1) =g= ts('t3',j,n);
sequence3c(j,n)$(ord(n)<card(n)).. tf('t3',j,n+1) =g= tf('t3',j,n);

sequence4a(j,n)$(ord(n)<card(n)).. ts('t4',j,n+1) =g= tf('t4',j,n) - (h * (2 - w('t4',n) - y(j,n)));
sequence4b(j,n)$(ord(n)<card(n)).. ts('t4',j,n+1) =g= ts('t4',j,n);
sequence4c(j,n)$(ord(n)<card(n)).. tf('t4',j,n+1) =g= tf('t4',j,n);

*heating then reaction 2
sequence5a(j,n).. ts('t2',j,n+1) =g= tf('t1',j,n) - h * (2 - w('t1',n) - y(j,n));

*reaction 2 then reaction 1
sequence5b(j,n).. ts('t3',j,n+1) =g= tf('t2',j,n) - h * (2 - w('t2',n) - y(j,n));

*reaction 1 then reaction 3
sequence5c(j,n).. ts('t4',j,n+1) =g= tf('t3',j,n) - h * (2 - w('t3',n) - y(j,n));


sequence6(i,ip,j,n)$(ord(n)<card(n) and ord(i)<>ord(i)).. ts(i,j,n+1) =g= tf(ip,j,n) - h*(2 - w(ip,n) - y(j,n));

sequence7(i,ip,j,jp,n)$(ord(n)<card(n) and ord(i)<>ord(i)).. ts(i,j,n+1) =g= tf(ip,jp,n) - h*(2 - w(ip,n) - y(jp,n));

sequence8(i,j,n)$(ord(n)<card(n) and ord(i)<>ord(i)).. ts(i,j,n+1) =g= sum(np, sum(ip, tf(ip,j,np) - ts(ip,j,np)));

*TIME HORIZON CONSTRAINTS
timehorizon1(i,j,n).. tf(i,j,n) =l= h;
timehorizon2(i,j,n).. ts(i,j,n) =l= h;

objectivefunction.. NetP =e= sum(s, sum(n, ps(s)*d(s,n)));
                    
model grossmannEX1floudas / all /;

solve grossmannEX1floudas using minlp maximizing NetP;