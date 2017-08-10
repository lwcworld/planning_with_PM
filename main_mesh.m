clc;clear;close all
% param setting
param.dim = 2;
param.m = 2;
param.n = 2;
param.xi = 1;
param.umeta = 1;
param.rho0 = 0.5;
param.q_goal = [0;0];
param.q_obs = [1,0;0,1;-2,0;-1,0.5]';
param.q = [-0.5;3.5]; % initial robot position
param.mass = 1; % mass of robot

% set sinario
space = -4:0.1:4;
[xs, ys] = meshgrid(space);

%%
[U_mesh, ax_mesh, ay_mesh] = potential_path_mesh(xs, ys, param);

dt = 0.1;
t = 0:dt:1000;
q = param.q;
q_log = nan(2, param.dim);
q_log(:,1) = q;
for i_t = 1:length(t)
    q_log(:,i_t) = q;
    [U, Fx, Fy] = potential_path_mesh(q(1), q(2), param);
    q = q + 1/2*[Fx;Fy]/param.mass*dt^2;
end

%% plot
close all; 
figure(1)
mesh(xs,ys,U_mesh)
grid on

figure(2)
contour(space, space, U_mesh)
hold on
scale = 0.1;
ax_mesh = ax_mesh./ sqrt((ax_mesh.^2 + ay_mesh.^2));
ay_mesh = ay_mesh./ sqrt((ax_mesh.^2 + ay_mesh.^2));
quiver(xs, ys, ax_mesh*scale, ay_mesh*scale, 'AutoScale', 'on')
plot(q_log(1,1),q_log(2,1), 'ro','LineWidth', 3)
plot(q_log(1,:), q_log(2,:), 'r', 'LineWidth', 2)
grid on
legend('a', 'b')
