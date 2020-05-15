Sets
  i 'tasks' /t1*t5/
  j 'units'/j1*j4/
  n 'event points within time horizon' /n0*n4/
  s 'states' /s1*s9/
  alias(i,ip)
  alias(j,jp)
  alias(n,np);

*Please note
*s1 - FeedA, s2 - HotA, s3 - Product1, s4 - IntBC, s5 - FeedB, s6 - FeedC, s7 - IntAB, s8 - ImpureE, s9 - Product2
*t1 - heating, t2 -reaction1, t3 - reaction2, t4 - reaction 3, t5 - separation
*j1 - heater, j2 - reactor 1, j3 - reactor, j4 - purificator   

Table b(i,j) 'variable duration of task i'
          j1        j2        j3        j4
   t1  0.00667      0         0         0
   t2     0      0.02664   0.01665      0
   t3     0      0.02664   0.01665      0
   t4     0      0.01332   0.00833      0
   t5     0         0         0      0.00666;

Table a(i,j) 'fixed duration of task i'
          j1        j2        j3        j4
   t1   0.667       0         0         0
   t2     0       1.334     1.334       0
   t3     0       1.334     1.334       0
   t4     0       0.667     0.667       0
   t5     0         0         0       1.3342;

Table vmax(i,j) 'Upper bound on the batch size of task i'
          j1    j2    j3     j4
   t1    100     0     0      0
   t2     0     50    80      0
   t3     0     50    80      0
   t4     0     50    80      0
   t5     0      0     0     200;

Table vmin(i,j) 'Lower bound on the batch size of task i'
          j1    j2    j3     j4
   t1     0      0     0      0
   t2     0      0     0      0
   t3     0      0     0      0
   t4     0      0     0      0
   t5     0      0     0      0;
   
Table pc(i,s) 'mass balance coefficient for the consumption of state s in task i'
        s1    s2   s3   s4   s5   s6   s7   s8   s9
   t1    1     0    0    0    0    0    0    0    0
   t2    0   0.4    0   0.6   0    0    0    0    0
   t3    0     0    0    0   0.5  0.5   0    0    0
   t4    0     0    0    0    0   0.2  0.8   0    0
   t5    0     0    0    0    0    0    0    1    0;

Table pp(i,s) 'mass balance coefficient for the production of state s in task i'
        s1    s2   s3   s4   s5   s6   s7   s8   s9
   t1    0     1    0    0    0    0    0    0    0
   t2    0     0   0.4   0    0    0   0.6   0    0
   t3    0     0    0    1    0    0    0    0    0
   t4    0     0    0    0    0    0    0    1    0
   t5    0     0    0    0    0    0   0.1   0   0.9;
Parameters

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
   NetP 'netprofit';
   
Binary variables w,y;
Positive variable bm,d,st,ts,tf;

Equations
  allocation1 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation2 
  allocation3
  allocation4
  allocation5
  allocation6
  allocation7
  allocation8
  capacity1 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  capacity2 
  capacity3
  capacity4
  capacity5
  capacity6
  capacity7
  capacity8
  storage1
  storage2
  storage3
  storage4
  storage5
  storage6
  storage7
  storage8
  storage9
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
*demand
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
  sequence6a
  sequence6b
  sequence6c
  sequence6d
  sequence7
  sequence8
  sequence9
  timehorizon1
  timehorizon2
  objectivefunction
;

*ALLOCATION CONSTRAINTS
allocation1(n).. w('t1',n) =e= y('j1',n);
allocation2(n).. w('t2',n) =e= y('j2',n);
allocation3(n).. w('t2',n) =e= y('j3',n);
allocation4(n).. w('t3',n) =e= y('j2',n);
allocation5(n).. w('t3',n) =e= y('j3',n);
allocation6(n).. w('t4',n) =e= y('j2',n);
allocation7(n).. w('t4',n) =e= y('j3',n);
allocation8(n).. w('t5',n) =e= y('j4',n);

*CAPACITY CONSTRAINTS
capacity1(n).. bm('t1','j1',n) =l= vmax('t1','j1')*w('t1',n);
capacity2(n).. bm('t2','j2',n) =l= vmax('t2','j2')*w('t2',n);
capacity3(n).. bm('t2','j3',n) =l= vmax('t2','j3')*w('t2',n);
capacity4(n).. bm('t3','j2',n) =l= vmax('t3','j2')*w('t3',n);
capacity5(n).. bm('t3','j3',n) =l= vmax('t3','j3')*w('t3',n);
capacity6(n).. bm('t4','j2',n) =l= vmax('t4','j2')*w('t4',n);
capacity7(n).. bm('t4','j3',n) =l= vmax('t4','j3')*w('t4',n);
capacity8(n).. bm('t4','j4',n) =l= vmax('t5','j4')*w('t5',n);

*STORAGE CONSTRAINTS
storage1(n).. st('s1',n) =l= STmax('s1');
storage2(n).. st('s2',n) =l= STmax('s2');
storage3(n).. st('s3',n) =l= STmax('s3');
storage4(n).. st('s4',n) =l= STmax('s4');
storage5(n).. st('s5',n) =l= STmax('s5');
storage6(n).. st('s6',n) =l= STmax('s6');
storage7(n).. st('s7',n) =l= STmax('s7');
storage8(n).. st('s8',n) =l= STmax('s8');
storage9(n).. st('s9',n) =l= STmax('s9');

*MATERIAL BALANCE CONSTRAINTS
materialbalance1a(j).. st('s1','n0') =e= stin('s1') - pc('t1','s1')*bm('t1',j,'n0');
materialbalance1b(j).. st('s2','n0') =e= stin('s2') - pc('t2','s2')*bm('t2',j,'n0');
materialbalance1c(j).. st('s3','n0') =e= stin('s3') - d('s3','n0');
materialbalance1d(j).. st('s4','n0') =e= stin('s4') - pc('t2','s4')*bm('t2',j,'n0');
materialbalance1e(j).. st('s5','n0') =e= stin('s5') - pc('t3','s5')*bm('t3',j,'n0');
materialbalance1f(j).. st('s6','n0') =e= stin('s6') - pc('t3','s6')*bm('t3',j,'n0') - pc('t4','s6')*bm('t4',j,'n0');
materialbalance1g(j).. st('s7','n0') =e= stin('s7') - pc('t4','s7')*bm('t4',j,'n0');
materialbalance1h(j).. st('s8','n0') =e= stin('s8') - pc('t5','s8')*bm('t5',j,'n0');
materialbalance1i(j).. st('s9','n0') =e= stin('s9') - d('s9','n0');

materialbalance2a(j,n)$(ord(n)>1).. st('s1',n) =e= st('s1',n-1) - pc('t1','s1')*bm('t1',j,n);
materialbalance2b(j,n)$(ord(n)>1).. st('s2',n) =e= st('s2',n-1) - pc('t2','s2')*bm('t2',j,n) + pp('t1','s2')*bm('t1',j,n-1);
materialbalance2c(j,n)$(ord(n)>1).. st('s3',n) =e= st('s3',n-1) + pp('t3','s3')*bm('t1',j,n-1) - d('s3',n);
materialbalance2d(j,n)$(ord(n)>1).. st('s4',n) =e= st('s4',n-1) - pc('t2','s4')*bm('t2',j,n) + pp('t3','s4')*bm('t3',j,n-1);
materialbalance2e(j,n)$(ord(n)>1).. st('s5',n) =e= st('s5',n-1) - pc('t3','s5')*bm('t2',j,n) + pp('t3','s5')*bm('t3',j,n-1);
materialbalance2f(j,n)$(ord(n)>1).. st('s6',n) =e= st('s6',n-1) - pc('t3','s6')*bm('t3',j,n) - pc('t4','s6')*bm('t4',j,n-1);
materialbalance2g(j,n)$(ord(n)>1).. st('s7',n) =e= st('s7',n-1) - pc('t4','s7')*bm('t4',j,n) + pp('t2','s7')*bm('t2',j,n-1) + pp('t5','s7')*bm('t5',j,n-1);
materialbalance2h(j,n)$(ord(n)>1).. st('s8',n) =e= st('s8',n-1) - pc('t5','s8')*bm('t5',j,n) + pp('t4','s8')*bm('t4',j,n-1);
materialbalance2i(j,n)$(ord(n)>1).. st('s9',n) =e= st('s9',n-1) + pp('t5','s9')*bm('t5',j,n-1) - d('s9',n);

*DURATION CONSTRAINTS
duration1(j,n).. tf('t1',j,n) =e= ts('t1',j,n) + (a('t1',j)*w('t1',n)) + (b('t1',j)*bm('t1',j,n));
duration2(j,n).. tf('t2',j,n) =e= ts('t2',j,n) + (a('t2',j)*w('t2',n)) + (b('t2',j)*bm('t2',j,n));
duration3(j,n).. tf('t3',j,n) =e= ts('t3',j,n) + (a('t3',j)*w('t3',n)) + (b('t3',j)*bm('t3',j,n));
duration4(j,n).. tf('t4',j,n) =e= ts('t4',j,n) + (a('t4',j)*w('t4',n)) + (b('t4',j)*bm('t4',j,n));
duration5(j,n).. tf('t5',j,n) =e= ts('t5',j,n) + (a('t5',j)*w('t5',n)) + (b('t5',j)*bm('t5',j,n));

*DEMAND
*demand(s).. sum(n, d(s,n)) =g= r;

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

sequence5a(j,n)$(ord(n)<card(n)).. ts('t5',j,n+1) =g= tf('t5',j,n) - (h * (2 - w('t5',n) - y(j,n)));
sequence5b(j,n)$(ord(n)<card(n)).. ts('t5',j,n+1) =g= ts('t5',j,n);
sequence5c(j,n)$(ord(n)<card(n)).. tf('t5',j,n+1) =g= tf('t5',j,n);

*heating then reaction 2
sequence6a(j,n).. ts('t2',j,n+1) =g= tf('t1',j,n) - h * (2 - w('t1',n) - y(j,n));

*reaction 2 then reaction 1
sequence6b(j,n).. ts('t3',j,n+1) =g= tf('t2',j,n) - h * (2 - w('t2',n) - y(j,n));

*reaction 1 then reaction 3
sequence6c(j,n).. ts('t4',j,n+1) =g= tf('t3',j,n) - h * (2 - w('t3',n) - y(j,n));

*reaction 3 then separation
sequence6d(j,n).. ts('t5',j,n+1) =g= tf('t4',j,n) - h * (2 - w('t1',n) - y(j,n));

sequence7(i,j,n)$(ord(n)<card(n)).. ts(i,j,n+1) =g= tf(i,j,n) - h*(2 - w(i,n) - y(j,n));

sequence8(i,j,n)$(ord(n)<card(n)).. ts(i,j,n+1) =g= tf(i,j,n) - h*(2 - w(i,n) - y(j,n));

sequence9(i,j,n)$(ord(n)<card(n) and ord(i)<>ord(i)).. ts(i,j,n+1) =g= sum(np, sum(ip, tf(ip,j,np) - ts(ip,j,np)));

*TIME HORIZON CONSTRAINTS
timehorizon1(i,j,n).. tf(i,j,n) =l= h;
timehorizon2(i,j,n).. ts(i,j,n) =l= h;

objectivefunction.. NetP =e= sum(s, sum(n, ps(s)*d(s,n)));
                    
model grossmannEX1floudas / all /;

solve grossmannEX1floudas using minlp maximizing NetP;
