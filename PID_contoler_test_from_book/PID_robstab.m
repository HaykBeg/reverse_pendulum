% Robust stability analysis for PID controller
%
clear all
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
% Selection of "good" optimization results
par_pid = Par([1,3,8,11,12],1:7);
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
i = 3;
%
Kp_theta = par_pid(i,1);
Ki_theta = par_pid(i,2);
Td_theta = par_pid(i,3);
Kp = par_pid(i,4);
Td = par_pid(i,5);
N_theta = par_pid(i,6);
N = par_pid(i,7);
[pa,pb,pc,pd] = dlinmod('PID_controller',0.01);
pid_d = ss(pa,pb,pc,pd,0.01);
%
systemnames      = ' DG_ulin pid_d Wn11d Wn22d';
inputvar         = '[ ref; noise{2}]';
outputvar        = '[ DG_ulin; pid_d; ref-DG_ulin(1)] ';
input_to_DG_ulin = '[ pid_d ]';
input_to_pid_d   = '[ref-DG_ulin(1)-Wn11d;DG_ulin(2)+Wn22d]';
input_to_Wn11d   = '[noise(1)]' ;
input_to_Wn22d   = '[noise(2)]' ;
clp_pid          = sysic;
%
[STABMARG,DESTABUNC,REPORT,INFO] = robuststab(clp_pid(1:2,1))
%
figure(1)
plot(INFO.MussvBnds(1),'k',INFO.MussvBnds(2),'k--'), grid
legend('\mu -upper bound','\mu -lower bound')
ylabel('\mu')
xlabel('Frequency [rad/sec]')
title('Robust stability')