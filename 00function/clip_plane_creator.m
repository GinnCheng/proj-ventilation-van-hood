%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% function to create clip of the velocity field
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [new_coord,mesh_indx] = clip_plane_creator(x_coord,y_coord,z_coord)
%% create the Nx3 coord for interplation, this is actually a 2D mesh
new_coord = zeros(length(x_coord)*length(y_coord)*length(z_coord),3);
%% create the (Nx,Ny) 2d mesh grid and indx is needed to link the coord and mesh
mesh_indx = zeros(length(x_coord),length(y_coord),length(z_coord));
%% create the coord and mesh and the linking indx
i_coord = 1;
for i = 1:length(x_coord)
    for j = 1:length(y_coord)
        for k = 1:length(z_coord)
            new_coord(i_coord,:) = [x_coord(i), y_coord(j), z_coord(k)];
            mesh_indx(i,j,k)    = i_coord;
            i_coord = i_coord + 1;
        end
    end
end
mesh_indx = squeeze(mesh_indx);
end