% PID controller design
%
% Parameters of the nominal closed-loop nonlinear 
% Cart-Pendulum system
%
theta_trim = 0.0;
%
% Parameter values
m = 0.104; % kg
M = ureal('M',0.768,'Percentage',10);  % kg
g = 9.81;   % m/s^2
l = 0.174;  % m
I = ureal('I',2.83*10^(-3),'Percentage',20);  % kg m^2
I_t = I + m*l^2;   % kg m^2
M_t = M + m;       % kg
f_c = ureal('f_c',0.5,'Percentage',20); % N s/m
f_p = ureal('f_p',6.65*10^(-5),'Percentage',20);% N m s/rad
den = M_t*I_t - m^2*l^2*cos(theta_trim);
k_F = 12.86;       % N
u_max = 0.5;
%Fd = 1.1975875;   % N dry friction
val_all = [];

global Kp Kp_theta Td Td_theta Ki_theta control err_position theta N_theta N
options = optimoptions('ga','Display','iter','UseVectorized',true,'PopulationSize',300);

 Par = [];
 for i = 1:15
    [par,fval] = ga(@err_fun,7,[],[],[],[],[-inf 0 0 -inf 0 2 2],[inf inf inf inf inf 30 30],[],options);
    Par = [Par;[par fval]];
    par = [];
    i
 end