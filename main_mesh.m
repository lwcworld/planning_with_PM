clc;clear;close all
% param
param.dim = 2;
param.m = 2;
param.n = 2;
param.xi = 1;
param.umeta = 1;
param.rho0 = 0.5;

param.q_goal = [0;0];
param.q_obs = [1;0];

% set sinario
d = -3:0.1:3;
[xs, ys] = meshgrid(d);

%%
[U_mesh, ax_mesh, ay_mesh] = potential_path(xs, ys, param);
[ax, ay] = gradient(U_mesh, 0.001, 0.001);

%%
figure(1)
mesh(xs,ys,U_mesh)
grid on

figure(2)
contour(d, d, U_mesh)
hold on
scale = 0.1;
ax_mesh = ax_mesh./ sqrt((ax_mesh.^2 + ay_mesh.^2));
ay_mesh = ay_mesh./ sqrt((ax_mesh.^2 + ay_mesh.^2));
quiver(xs, ys, ax_mesh*scale, ay_mesh*scale, 'AutoScale', 'on')
grid on
legend('a', 'b')

% figure(3)
% mesh(xs, ys, ax_mesh)
% 
% figure(4)
% mesh(xs, ys, ay_mesh)
