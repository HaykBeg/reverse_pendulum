% Error function for PID controler optimization
%
function err = err_fun( par)
%
global Kp Kp_theta Td Ki_theta Td_theta control err_position theta N_theta N
%
Kp_theta = par(:,1);
Ki_theta = par(:,2);
Td_theta = par(:,3);
Kp = par(:,4);
Td = par(:,5);
N_theta = par(:,6);
N = par(:,7);
sim('discrete_PID_pendulum')
%
err = sum(err_position.^2) + sum(theta.^2);
end
