% Worst gain analysis for PID controller
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
i = 3;
Ts = 0.01;
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
systemnames       = ' DG_ulin pid_d Wn11d Wn22d';
inputvar          = '[ ref; noise{2}]';
outputvar         = '[ DG_ulin; pid_d; ref-DG_ulin(1)] ';
input_to_DG_ulin  = '[ pid_d ]';
input_to_pid_d    = '[ref-DG_ulin(1)-Wn11d;DG_ulin(2)+Wn22d]';
input_to_Wn11d    = '[noise(1)]' ;
input_to_Wn22d    = '[noise(2)]' ;
clp_pid           = sysic;
%
[maxgain,maxgainunc] = wcgain(clp_pid(1:2,1));
% maxgainunc = 
% 
%       I: 0.003396000000000
%       M: 0.691200000000000
%     f_c: 0.600000000000000
%     f_p: 5.320000000000000e-05
uvars_lin = ufind(clp_pid(1:4,1:3));
val = usample(uvars_lin,30);
Position = []; Theta = [];
for i = 1:30
    clp_pid_lin = usubs(clp_pid(1:2,1),val(i));
    Y = step(clp_pid_lin,20);
    Position = [Position Y(:,1)];
    Theta = [Theta Y(:,2)];
end
clp_pid_lin1 = usample(clp_pid(1:4,1:3),30);
figure(5)
clp_pid_wc = usubs(clp_pid(1:4,1:3),maxgainunc);
step(clp_pid_wc(1,1),'k--',clp_pid_lin1(1,1),'k'), grid
ylabel('p (m)')
title('Position step response')
legend('Worst-case gain','Random samples','Location','SouthEast')
%
figure(6)
step(clp_pid_wc(2,1)*180/pi,'k--',clp_pid_lin1(2,1)*180/pi,'k'),grid
ylabel('\theta (deg)')
title('Angle response')
legend('Worst-case gain','Random samples','Location','NorthEast')
omega = logspace(-2,log10(pi/Ts),200);
%
figure(7)
sigma(clp_pid_wc(1,1),'k--',clp_pid_lin1(1,1),'k',omega),grid
title('Magnitude plot of the uncertain closed-loop system')
legend('Worst case','Random samples','Location','NorthEast')
title('Magnitude plot of the uncertain closed-loop system')
legend('Worst case','Random samples','Location','NorthEast')