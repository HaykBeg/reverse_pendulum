clear all
global Kp Kp_theta Td Td_theta Ki_theta N_theta N
unc_lin_model
u_max=0.5
[M,Delta] = lftdata(G_ulin);
M_d = c2d(M,0.01);
DG_ulin = lft(Delta,M_d);
format long

load PID_parameters
%selection of good optimization results
par_pid=Par([1,3,8,11,12],1:7);
Ts=0.01;



val_all=[];
 Position_nom=[];
 Theta_nom=[];
 Control_nom=[];
  Kp_theta=par_pid(3,1);
Ki_theta=par_pid(3,2);
Td_theta=par_pid(3,3);
Kp=par_pid(3,4);
Td=par_pid(3,5);
N_theta=par_pid(3,6);
N=par_pid(3,7);
sim('clp_PID_pendulum',50) 
Position_nom=[Position_nom position.signals.values];
Theta_nom=[Theta_nom theta.signals.values];
Control_nom=[Control_nom control.signals.values];


figure(1)
plot(position.time, Position_nom(:,1),'k'),grid
 ylabel('p (m)')
title('Cart position')
%legend('PID first run','PID eigth run','Location','NorthEast')
 figure(2)
plot(theta.time, Theta_nom(:,1),'k'),grid
 ylabel('/theta (deg)')
title('Pendulum angle')
%legend('PID first run','PID eigth run','Location','NorthEast')

 figure(3)
plot(control.time, Control_nom(:,1),'k'),grid
 ylabel('duty cycle')
title('Control action')

%calculating classical and disk margins

[pa,pb,pc,pd]=dlinmod('PID_controller_open_loop',0.01);
pid_do=ss(pa,pb,pc,pd,0.01);

 Li=pid_do*DG_ulin.nominal
[cm,dm] = loopmargin(Li)
wcmarg = wcmargin(Li)



