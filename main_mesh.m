clc;clear;close all
% param setting
param.dim = 2;
param.m = 2;
param.n = 2;
param.xi = 1;
param.umeta = 1;
param.rho0 = 0.5;
param.q_goal = [0;0];
param.q_obs = [1,0;0,1;-2,0]';

% set sinario
space = -4:0.1:4;
[xs, ys] = meshgrid(space);

%%
[U_mesh, ax_mesh, ay_mesh] = potential_path(xs, ys, param);
% [ax, ay] = gradient(U_mesh, 0.001, 0.001);

%% plot
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
grid on
legend('a', 'b')
