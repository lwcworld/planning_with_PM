clc;clear;close all
% param
dim = 2;
m = 2;
n = 2;
xi = 1;
umeta = 1;
rho0 = 0.5;

% set sinario
xs = [-10:0.1:10];
ys = [-10:0.1:10];

q_goal = [0;0];
q_obs = [1;0];
q = [0;0];

rho_obs = norm(q-q_obs);
rho_goal = norm(q-q_goal);

U_att =1/2*xi*rho_goal^m;
F_att = 1/2*xi*m*(q_goal - q);

F_rep1 = umeta*(1/rho_obs - 1/rho0)*rho_goal^n/rho_obs^2;
F_rep2 = n/2*umeta*(1/rho_obs - 1/rho0)^2*rho_goal^(n-1);
n_OR = (q-q_obs)/rho_obs; % unit vector (obstacle -> robot)
n_RG = (q_goal-q)/rho_goal;% unit vector (robot -> goal)
if rho_obs <= rho0
    U_rep = 1/2*umeta*(1/rho_obs - 1/rho0)^2*rho_goal^n;
    F_rep = F_rep1*n_OR + F_rep2*n_RG;
else
    U_rep = zeros(dim,1);
    F_rep = zeros(dim,1);
end

U = U_att + U_rep;
F = F_att + F_rep;

