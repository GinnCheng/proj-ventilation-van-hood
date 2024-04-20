function [sub_DelaunayMatrix,sub_weightCoeff,nanIndx] = ofDelaunayInterpolation(sub_old_coord,sub_new_coord)
%% firstly we need to get Delaunay coeff matrix for old_coord
% create Delaunay transfer matrix
sub_DelaunayMatrix = delaunayTriangulation(sub_old_coord);
% secondly we need to use DelaunayMatrix to create surroundPoints and weightCoeff
[surroundPoints,sub_weightCoeff]   = pointLocation(sub_DelaunayMatrix,sub_new_coord);       
% now we need to remove the NaN points
[nanIndx, ~]  = find(isnan(surroundPoints));
% reshaper all matrix
surroundPoints(nanIndx,:)           = [];
sub_weightCoeff(nanIndx,:)          = [];
if sum(sum(isnan(sub_weightCoeff))) ~= 0
    error('convex hull happened in the interpolation')
end      
% squeeze Delaunay Matrix so that the storage size is minimal
sub_DelaunayMatrix                  =  sub_DelaunayMatrix.ConnectivityList(surroundPoints,:);
end