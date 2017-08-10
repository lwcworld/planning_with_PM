function [U_mesh, ax_mesh, ay_mesh] = potential_path_mesh(xs, ys, param)
% param.dim = 2;
% param.m = 2;
% param.n = 2;
% param.xi = 1;
% param.umeta = 1;
% param.rho0 = 0.5;

dim = param.dim;
m = param.m;
n = param.n;
xi = param.xi;
umeta = param.umeta;
rho0 = param.rho0;
q_goal = param.q_goal;
q_obs = param.q_obs;

U_mesh = zeros(size(xs));
ax_mesh = zeros(size(xs));
ay_mesh = zeros(size(xs));

for i_obs = 1:size(q_obs,2)
    q_obs_i = q_obs(:,i_obs);
    for ix = 1:size(xs,1)
        for iy = 1:size(xs,2)
            q = [xs(ix,iy);ys(ix,iy)];
            
            rho_obs = norm(q-q_obs_i);
            rho_goal = norm(q-q_goal);
            
            U_att = 1/2*xi*rho_goal^m;
            F_att = 1/2*xi*m*(q_goal - q);
            
            F_rep1 = umeta*(1/rho_obs - 1/rho0)*rho_goal^n/rho_obs^2;
            F_rep2 = n/2*umeta*(1/rho_obs - 1/rho0)^2*rho_goal^(n-1);
            n_OR = (q-q_obs_i)/rho_obs; % unit vector (obstacle -> robot)
            n_RG = (q_goal-q)/rho_goal;% unit vector (robot -> goal)
            if rho_obs <= rho0
                U_rep = 1/2*umeta*(1/rho_obs - 1/rho0)^2*rho_goal^n;
                F_rep = F_rep1*n_OR + F_rep2*n_RG;
            else
                U_rep = 0;
                F_rep = zeros(dim,1);
            end
            
            U = U_att + U_rep;
            F = F_att + F_rep;
            
            U_mesh(ix, iy) = U_mesh(ix,iy) + U;
            ax_mesh(ix, iy) = ax_mesh(ix,iy) + F(1);
            ay_mesh(ix, iy) = ay_mesh(ix,iy) + F(2);
        end
    end
end
    
