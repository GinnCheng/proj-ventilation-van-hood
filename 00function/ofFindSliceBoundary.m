function [bound_smooth, k_smooth, logic_in] = ofFindSliceBoundary(old_coord,cut_loc,N_cutDir,tol_cut_loc,X_smooth,Y_smooth)
if N_cutDir ~= 1 && N_cutDir ~= 2 && N_cutDir ~= 3
    error('para N_cutDir must be 1, 2 or 3, which denotes x, y and z-dir of the cutting plane normal')
end
if N_cutDir == 1
    x_bound = 2;
    y_bound = 3;
%     X_smooth = y_coord;
%     Y_smooth = z_coord;
elseif N_cutDir == 2
    x_bound = 1;
    y_bound = 3;
%     X_smooth = x_coord;
%     Y_smooth = z_coord;
else
    x_bound = 1;
    y_bound = 2;
%     X_smooth = x_coord;
%     Y_smooth = y_coord;
end
%%% tol_cut_loc is the tolerance of the cutting plane

%% This is to find the boudnary of a assigned cut slice using the orginal coord
%%% give a tolerance for the cut
indx_cut = abs(old_coord(:,N_cutDir) - cut_loc) <= tol_cut_loc;
%%% get the slice coord
bound_slice = old_coord(indx_cut == 1,[x_bound,y_bound]);
%%% looking for the boudnary of the selected part
k_bound        = boundary(bound_slice,0.8);

%% now we try to smooth the boundary by inploygon
% X_smooth = unique([linspace(xylims(1),2.16,2),linspace(2.16,xylims(2),10)]);
% Y_smooth = linspace(xylims(3),xylims(4),250);
[XX,YY]  = meshgrid(X_smooth,Y_smooth);
logic_in = inpolygon(XX,YY,bound_slice(k_bound,1),bound_slice(k_bound,2));
%% reshape the mesh into Nx2 array
XX_re    = reshape(XX,[length(X_smooth)*length(Y_smooth),1]);
YY_re    = reshape(YY,[length(X_smooth)*length(Y_smooth),1]);
points_in_re = reshape(logic_in,[length(X_smooth)*length(Y_smooth),1]);
%% remove outside points
bound_smooth = [XX_re,YY_re];
bound_smooth(points_in_re == 0,:) = [];
%% find the boundary
k_smooth     = boundary(bound_smooth,0.9);
end