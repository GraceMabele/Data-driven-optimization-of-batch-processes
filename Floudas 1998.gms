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
  Ij(i,j) 'tasks i which can be performed in unit j' /t1.j1, t2.j2, t3.j3/
  Is(s,i) 'tasks i which process state s and either can be produced.consumed' /s1.t1, s2.t1, s2.t2, s3.t2, s3.t3, s4.t3/
  Ji(j,i) 'units j suitable for performing task i' /j1.t1, j2.t2, j3.t3/;
  
Alias(Ij, G) ;
Alias(Ji, P) ;
Alias(Is, L) ;

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
   pc(s,i) 'proportion of states s consumed from task i';
   
Binary variables w,y;
Positive variable pp;
Negative variable pc;

Equations
   allocation(j,n) 'express that at each unit j and at an event point n only one of the tasks that can be performed in this unit should take place'
   capacity(i,j,n) 'express the requirement for the of material in order for a unit j minimum amount Vminij to start operating task i and the maximum capacity of when performing task i'
   storage(s,n) 'represent the maximum available storage capacity for each state s at each event point n'
   materialbalance(s,n) 'the proportion of state s consumed and produced from task i'
   demand(s) 'the requirement to produce at least as much as required by the market'
   duration(i,j,n) 'express the dependence of the time duration of task i at unit j at event point n on the amount of material being processed'
   sequence1a(i,j,n) 'A Same Task in the Same Unit'
   sequence1b(i,j,n) 'B Same Task in the Same Unit'
   sequence1c(i,j,n) 'C Same Task in the Same Unit'
   sequence2(i,j,n) 'Different Tasks in the Same Unit'
   sequence3(i,j,n) 'Different Tasks in Different Units'
   sequence4(i,j,n) 'Completion of Previous Tasks'
   timehorizon1(i,j,n) 'represent the requirement of every task i to end within the time horizon H'
   timehorizon2(i,j,n) 'represent the requirement of every task i to start within the time horizon H'
   objectivefunction 'maximization of profit';

*first two lines have errors and I don't understand why
allocation(j,n)..      sum(Ij(i,j), w(i,n)) =e= y(j,n);

capacity(i,j,n)..       Vmin(i) * w(i,n) =l= bm(i,j,n) =l= Vmax(i);  

storage(s,n)..         st(s,n) =l= STmax(s);

*materialbalance(s,n).. st(s,n) =e= st(s,n-1) - d(s,n) + (sum(Is(s,i), pp(s,i)))*(sum(Ji(j,i), bm(i,j,n-1))) + (sum(Is(s,i), pc(s,i)))*(sum(Ji(j,i), bm(i,j,n)));
materialbalance(s,n).. st(s,n) =e= st(s,n-1) + (sum(Is, pp(s,i)))*(sum(Ji, bm(i,j,n-1))) + (sum(Is, pc(s,i)))*(sum(Ji, bm(i,j,n)))
demand(s)..            sum(n, d(s,n)) =g= r;

duration(i,j,n)..      tf(i,j,n) =e= ts(i,j,n) + a(i) * w(i,n) + b(i)*bm(i,j,n);

sequence1a(i,j,n)..    ts(i,j,n+1) =g= tf(i,j,n) - h * (2 - w(i,n) - y(j,n));

sequence1b(i,j,n)..    ts(i,j,n+1) =g= ts(i,j,n);

sequence1c(i,j,n)..    tf(i,j,n+1) =g= tf(i,j,n);

sequence2(i,j,n)..     ts(i,j,n+1) =g= tf(Ij(i,j),j,n) - h * (2 - w(Ij(i,j),n) - y(j,n));

sequence3(i,j,n)..     ts(i,j,n+1) =g= tf(Ij(i,j),Ji(j,i),n) - h * (2 - w(Ij(i,j),n) - y(Ji(i,j),n));

sequence4(i,j,n)..     ts(i,j,n+1) =g= sum(n,G,(tf(G,j,n) - ts(G,j,n)));

timehorizon1(i,j,n)..  tf(i,j,n) =l= h;

timehorizon2(i,j,n)..  ts(i,j,n) =l= h;

objectivefunction..    NP =e= sum(s,n,ps*d);

model floudas98 / all /;

solve floudas98 using minlp maximizing NP;

