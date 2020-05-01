% Generates the uncertain model of the Pendulum-Cart Plant
%
% trim condition
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
k_F = 12.86;       % N
den = M_t*I_t - m^2*l^2*cos(theta_trim);
%
A = [0     0              1               0
     0     0              0               1
     0 m^2*l^2*g/den -f_c*I_t/den   -f_p*l*m/den
     0 M_t*m*g*l/den -f_c*m*l/den   -f_p*M_t/den];
%
B = [   0
        0
     I_t/den
     l*m/den]*k_F;
%
C = [1  0  0  0
     0  1  0  0];
%
D = [0
     0];
%
G_ulin = ss(A,B,C,D);