% Monte Carlo simulation for PID controller
%
% closed-loop interconnection
clear all
val_all = [];
Ts = 0.01;
global Kp Kp_theta Td Td_theta Ki_theta N_theta N
unc_lin_model
u_max = 0.5;
[M,Delta] = lftdata(G_ulin);
M_d = c2d(M,0.01);
DG_ulin = lft(Delta,M_d);
format long
%
load PID_parameters
%
% Selection of good optimization results
par_pid = Par([1,3,8,11,12],1:7);
%
z = tf('z',0.01);
Intd = 0.01/(z-1);
delay1 = z^-1;
k1 = (0.235/2^12)/sqrt(12);
k2 = (2*pi/2^12)/sqrt(12);
Wn11 = k1*tf([5   50],[0.01 1]); % 
Wn22 = k2*tf([0.5 10],[0.01 1]);  % 
Wn11d = c2d(Wn11,0.01);
Wn22d = c2d(Wn22,0.01);
Maxgainunc = [];
DG_ulin1 = DG_ulin.nominal   
%
Kp_theta = par_pid(3,1);
Ki_theta = par_pid(3,2);
Td_theta = par_pid(3,3);
Kp = par_pid(3,4);
Td = par_pid(3,5);
N_theta = par_pid(3,6);
N = par_pid(3,7);
uvars = ufind('clp_PID_pendulum');
val_all1 = usample(uvars,10);
val_all = [];
Position = []; Control = []; Theta = [];
for i = 1:10
    val_all = val_all1(i)
    sim('clp_PID_pendulum')
    Position = [Position position.signals.values];
    Control = [Control control.signals.values];
    Theta = [Theta theta.signals.values];
end
figure(2),
plot(reference.time,reference.signals.values,'k-.', position.time,Position,'k'),grid
ylabel('p (m)')
xlabel('Time [s]')
title('Cart position')
legend('Reference','Position')
%
figure(3),
plot(position.time,Control,'k'), grid
ylabel('u')
xlabel('Time [s]')
title('Control action')
%
figure(4),
plot(position.time,Theta,'k'), grid
ylabel('\theta (deg)')
xlabel('Time [s]')
title('Pendulum angle')