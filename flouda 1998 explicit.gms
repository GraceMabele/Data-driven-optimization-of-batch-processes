$title STN Mathematical model of a simple batch plant (FLOUDAS, SEQ=1)

$Ontext

This paper presents a novel mathematical formulation
for the short-term scheduling of batch plants. The proposed formulation is based on a continuous
time representation and results in a mixed integer linear programming (MILP) problem.

Ierapetritou and Floudas (1998) Effective Continuous-Time Formulation for Short-Term Scheduling.
1. Multipurpose Batch Processes. Independent Engineering Chemical Research 37 (4341-4359)

$Offtext

Sets
  i 'tasks' /t1,t2,t3/
  j 'units'/j1,j2,j3/
  n 'event points within time horizon' /n0, n1, n2, n3, n4/
  s 'states' /s1, s2, s3, s4/
  Ij1(i) 'tasks i which can be performed in unit 1' /t1/
  Ij2(i) 'tasks i which can be performed in unit 2' /t2/
  Ij3(i) 'tasks i which can be performed in unit 3' /t3/
  Is1(i) 'tasks i which process state 1 and either can be produced.consumed' /t1/
  Is2(i) 'tasks i which process state 2 and either can be produced.consumed' /t1, t2/
  Is3(i) 'tasks i which process state 3 and either can be produced.consumed' /t2, t3/
  Is4(i) 'tasks i which process state s and either can be produced.consumed' /t3/
  Ji1(j) 'units j suitable for performing task 1' /j1/
  Ji2(j) 'units j suitable for performing task 2' /j2/
  Ji3(j) 'units j suitable for performing task 3' /j3/;
  
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
*unlimited = 10 000
/   s1   10000
    s2   100
    s3   100
    s4   10000    /
 
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
    s4  1.0  /;
  
Scalar
   h   'horizon time  (available time hrs)' /12. /
*market requirements hav not been specified, text advises us not to utilise demand constraints, made an assumption here
   r 'market requirements for state s at end of time horizon' /4./;

Variables
   w(i,n) 'binary variable that assign the beginning of task i at event point n'
   y(j,n) 'binary variable that assign the utilization of unit j at event point n'
   bm(i,j,n) 'amount of material undertaking task i in  unit j at event point n'
   d(s,n) 'amount of state s being delivered to the market at event point n'
   st(s,n) 'amount of state s at event point n'
   ts(i,j,n) 'time that task i starts in unit j at event point n'
   tf(i,j,n) 'time that task i finishes in unit j while it starts at event point n'
   pp(s,i) 'proportion of states s produced from task i'
   pc(s,i) 'proportion of states s consumed from task i'
   NP 'netprofit';
   
Binary variables w,y;
Positive variable pp;
Negative variable pc;

Equations
  allocation1 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation2 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  allocation3 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
  capacity1 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  capacity2 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  capacity3 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
  storage1'represent the maximum available storage capacity for each state s at each event point n'
  storage2'represent the maximum available storage capacity for each state s at each event point n'
  storage3'represent the maximum available storage capacity for each state s at each event point n'
  storage4'represent the maximum available storage capacity for each state s at each event point n'
  storage5'represent the maximum available storage capacity for each state s at each event point n'
  storage6'represent the maximum available storage capacity for each state s at each event point n'
  storage7'represent the maximum available storage capacity for each state s at each event point n'
  storage8'represent the maximum available storage capacity for each state s at each event point n'
  storage9'represent the maximum available storage capacity for each state s at each event point n'
  storage10'represent the maximum available storage capacity for each state s at each event point n'
  storage11'represent the maximum available storage capacity for each state s at each event point n'
  storage12'represent the maximum available storage capacity for each state s at each event point n'
  storage13'represent the maximum available storage capacity for each state s at each event point n'
  storage14'represent the maximum available storage capacity for each state s at each event point n'
  storage15'represent the maximum available storage capacity for each state s at each event point n'
  storage16'represent the maximum available storage capacity for each state s at each event point n'
  storage17'represent the maximum available storage capacity for each state s at each event point n'
  storage18'represent the maximum available storage capacity for each state s at each event point n'
  storage19'represent the maximum available storage capacity for each state s at each event point n'
  storage20'represent the maximum available storage capacity for each state s at each event point n'
  materialbalance1 'the proportion of state s consumed and produced from task i'
  materialbalance2 'the proportion of state s consumed and produced from task i'
  materialbalance3 'the proportion of state s consumed and produced from task i'
  materialbalance4 'the proportion of state s consumed and produced from task i'
  duration1 'express the dependence of the time duration of task i at unit j at event point n on the amount of material being processed'
  duration2 'express the dependence of the time duration of task i at unit j at event point n on the amount of material being processed'
  duration3 'express the dependence of the time duration of task i at unit j at event point n on the amount of material being processed'
  sequence1a 'A Same Task in the Same Unit'
  sequence1b
  sequence1c
  sequence2a 'A Same Task in the Same Unit'
  sequence2b 
  sequence2c 
  sequence3a 'A Same Task in the Same Unit'
  sequence3b 
  sequence3c 
  sequence4a 'Different Tasks in the Same Unit'
  sequence4b 'Different Tasks in the Same Unit'
  sequence5a 'Completion of Previous Tasks'
  sequence5b 
  sequence5c 
  sequence5d 
  sequence6a 'Completion of Previous Tasks'
  sequence6b 
  sequence6c 
  sequence6d 
  sequence7a 'Completion of Previous Tasks'
  sequence7b 
  sequence7c 
  sequence7d
  timehorizon1a 'represent the requirement of every task i to end within the time horizon H'
  timehorizon1b 
  timehorizon1c 
  timehorizon2a 'represent the requirement of every task i to start within the time horizon H'
  timehorizon2b
  timehorizon2c
  objectivefunction 'maximization of profit';

*ALLOCATION CONSTRAINTS
allocation1(n).. w('t1',n) =e= y('j1',n);
allocation2(n).. w('t2',n) =e= y('j2',n);
allocation3(n).. w('t3',n) =e= y('j3',n);

                  
*CAPACITY CONSTRAINTS
capacity1(n).. bm('t1','j1',n) =l= 100*w('t1',n);
capacity2(n).. bm('t2','j2',n) =l= 100*w('t2',n);
capacity3(n).. bm('t3','j3',n) =l= 100*w('t3',n);

*STORAGE CONSTRAINTS
*state 1 unlimited storage(set to 10 000)
storage1.. st('s1','n0') =l= 10000;
storage2.. st('s1','n1') =l= 10000;
storage3.. st('s1','n2') =l= 10000;
storage4.. st('s1','n3') =l= 10000;
storage5.. st('s1','n4') =l= 10000;

*state 2 limited stored (100)
storage6.. st('s2','n0') =l= 100;
storage7.. st('s2','n1') =l= 100;
storage8.. st('s2','n2') =l= 100;
storage9.. st('s2','n3') =l= 100;
storage10.. st('s2','n4') =l= 100;

*state 3 limited stored (100)
storage11.. st('s3','n0') =l= 100;
storage12.. st('s3','n1') =l= 100;
storage13.. st('s3','n2') =l= 100;
storage14.. st('s3','n3') =l= 100;
storage15.. st('s3','n4') =l= 100;

*state 4 unlimited storage(set to 10 000)
storage16.. st('s4','n0') =l= 10000;
storage17.. st('s4','n1') =l= 10000;
storage18.. st('s4','n2') =l= 10000;
storage19.. st('s4','n3') =l= 10000;
storage20.. st('s4','n4') =l= 10000;

*MATERIAL BALANCES
materialbalance1(n).. st('s1',n) =e= st('s1',n-1) - bm('t1','j1',n);
materialbalance2(n).. st('s2',n) =e= st('s2',n-1) - bm('t2','j2',n) + bm('t1','j1',n);
materialbalance3(n).. st('s3',n) =e= st('s3',n-1) - bm('t3','j3',n) + bm('t2','j2',n);
materialbalance4(n).. st('s4',n) =e= st('s4',n-1) + bm('t3','j3',n) - d('s4',n);
                      
*The product corresponds to state s4, for which the objective is to maximize the production over the time horizon
*No market requirements are specified, and consequently no demand constraints are posed.

*DURATION CONSTRAINTS
duration1(n).. tf('t1','j1',n) =e= ts('t1','j1',n) + 3.0* w('t1',n) + 0.03*bm('t1','j1',n);
duration2(n).. tf('t2','j2',n) =e= ts('t2','j2',n) + 2.0* w('t2',n) + 0.0266*bm('t2','j2',n);
duration3(n).. tf('t3','j3',n) =e= ts('t3','j3',n) + 1.0* w('t3',n) + 0.02*bm('t3','j3',n);
                    

*SEQUENCE CONSTRAINTS
sequence1a(n)..    ts('t1','j1',n+1) =g= tf('t1','j1',n) - h * (2 - w('t1',n) - y('j1',n));
sequence1b(n)..    ts('t1','j1',n+1) =g= ts('t1','j1',n);
sequence1c(n)..    tf('t1','j1',n+1) =g= tf('t1','j1',n);

sequence2a(n)..    ts('t2','j2',n+1) =g= tf('t2','j2',n) - h * (2 - w('t2',n) - y('j2',n));
sequence2b(n)..    ts('t2','j2',n+1) =g= ts('t2','j2',n);
sequence2c(n)..    tf('t2','j2',n+1) =g= tf('t2','j2',n);

                
sequence3a(n)..    ts('t3','j3',n+1) =g= tf('t3','j3',n) - h * (2 - w('t3',n) - y('j3',n));
sequence3b(n)..    ts('t3','j3',n+1) =g= ts('t3','j3',n);
sequence3c(n)..    tf('t3','j3',n+1) =g= tf('t3','j3',n);
                         
*the constraint sequence2(i,j,n) 'Different Tasks in the Same Unit' will not apply as each unit has only one task it can perform.

*mixing then reaction                        
sequence4a(n)..       ts('t2','j2',n+1) =g= tf('t1','j1',n) - h * (2 - w('t1',n) - y('j1',n));
                         
*reaction to separation
sequence4b(n)..       ts('t3','j3',n+1) =g= tf('t2','j2',n) - h * (2 - w('t2',n) - y('j2',n));
                         

sequence5a..     ts('t1','j1','n1') =g= (tf('t1','j1','n0') - ts('t1','j1','n0'));
sequence5b..     ts('t1','j1','n2') =g= (tf('t1','j1','n0') - ts('t1','j1','n0')) + (tf('t1','j1','n1') - ts('t1','j1','n1'));
sequence5c..     ts('t1','j1','n3') =g= (tf('t1','j1','n0') - ts('t1','j1','n0')) + (tf('t1','j1','n1') - ts('t1','j1','n1')) + (tf('t1','j1','n2') - ts('t1','j1','n2'));
sequence5d..     ts('t1','j1','n4') =g= (tf('t1','j1','n0') - ts('t1','j1','n0')) + (tf('t1','j1','n1') - ts('t1','j1','n1')) + (tf('t1','j1','n2') - ts('t1','j1','n2')) + (tf('t1','j1','n3') - ts('t1','j1','n3'));

sequence6a..     ts('t2','j2','n1') =g= (tf('t2','j2','n0') - ts('t2','j2','n0'));
sequence6b..     ts('t2','j2','n2') =g= (tf('t2','j2','n0') - ts('t2','j2','n0')) + (tf('t2','j2','n1') - ts('t2','j2','n1'));
sequence6c..     ts('t2','j2','n3') =g= (tf('t2','j2','n0') - ts('t2','j2','n0')) + (tf('t2','j2','n1') - ts('t2','j2','n1')) + (tf('t2','j2','n2') - ts('t2','j2','n2'));
sequence6d..     ts('t2','j2','n4') =g= (tf('t2','j2','n0') - ts('t2','j2','n0')) + (tf('t2','j2','n1') - ts('t2','j2','n1')) + (tf('t2','j2','n2') - ts('t2','j2','n2')) + (tf('t2','j2','n3') - ts('t2','j2','n3'));
                       
sequence7a..     ts('t3','j3','n1') =g= (tf('t3','j3','n0') - ts('t3','j3','n0'));
sequence7b..     ts('t3','j3','n2') =g= (tf('t3','j3','n0') - ts('t3','j3','n0')) + (tf('t3','j3','n1') - ts('t3','j3','n1'));
sequence7c..     ts('t3','j3','n3') =g= (tf('t3','j3','n0') - ts('t1','j3','n0')) + (tf('t3','j3','n1') - ts('t3','j3','n1')) + (tf('t3','j3','n2') - ts('t3','j3','n2'));
sequence7d..     ts('t3','j3','n4') =g= (tf('t3','j3','n0') - ts('t1','j3','n0')) + (tf('t3','j3','n1') - ts('t3','j3','n1')) + (tf('t3','j3','n2') - ts('t3','j3','n2')) + (tf('t3','j3','n3') - ts('t3','j3','n3'));

timehorizon1a(n)..  tf('t1','j1',n) =l= h;
timehorizon1b(n)..  tf('t2','j2',n) =l= h;
timehorizon1c(n)..  tf('t3','j3',n) =l= h;

timehorizon2a(n)..  ts('t1','j1',n) =l= h;
timehorizon2b(n)..  ts('t2','j2',n) =l= h;
timehorizon2c(n)..  ts('t3','j3',n) =l= h;
                       
objectivefunction..    NP =e= d('s4','n0') + d('s4','n1') + d('s4','n2') + d('s4','n3') + d('s4','n2') + st('s4','n4') ;
                    
model floudasEXPLICIT98 / all /;

solve floudasEXPLICIT98 using minlp maximizing NP;

*OPTIMAL DESIGN
display NP.m;