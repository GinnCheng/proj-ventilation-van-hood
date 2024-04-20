clear all; close all; clc;
n = 12; % Number of vertices
theta = 2*pi*rand(n,1)-pi; % Random theta
phi = pi*rand(n,1) - pi/2; % Random phi
x = cos(phi).*cos(theta); % Create x values
y = cos(phi).*sin(theta); % Create y values
z = sin(phi); % Create z values

xyz = rand(3, 20); % Generate random points
tri = delaunayn([x y z]); % Generate delaunay triangulization
tn = tsearchn([x y z], tri, xyz'); % Determine which triangle point is within
IsInside = ~isnan(tn) % Convert to logical vector;