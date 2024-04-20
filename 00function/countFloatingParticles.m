%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% to read the number of floating particles
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t,tot_injections,tot_actives,tot_suction] = countFloatingParticles(folder_loc,case_loc)
%% read the folders
%%% get the number of processors that I decomposed
num_of_processors = dir([folder_loc,case_loc,'\processor*']);
%%% get the number of time series
num_of_time       = dir([folder_loc,case_loc,'\',num_of_processors(1).name]);
listName          = {num_of_time.name};
matchC            = regexp(listName, '[0-9]', 'start');
match             = ~cellfun('isempty', matchC);
list_t            = num_of_time(match);
%%% get all time for future use
t                 = zeros();
for i = 1:length(list_t)
    t(i) = str2num(list_t(i).name);
end
disp('start to load the data')
%% now read the particles
activeField = cell(length(num_of_processors),length(t));
positions   = cell(length(num_of_processors),length(t));
tot_num_par = zeros(length(num_of_processors),length(t));
tot_num_act = zeros(length(num_of_processors),length(t));
tot_num_out = zeros(length(num_of_processors),length(t));
for i = 1:length(num_of_processors)
    disp(['reading files from processor', num2str(i)])
    for j = 1:length(list_t)
        temp_loc    = [folder_loc,case_loc,'\',num_of_processors(i).name,'\',num2str(t(j)),'\lagrangian\kinematicCloud\'];
        %%% read active       
        fid         = fopen([temp_loc,'active']);
        temp_active = textscan(fid,'%f','HeaderLine',20);
        fclose(fid); 
        activeField{i,j} = temp_active{1};
        % make them be array
        temp_active = double(temp_active{1} == 1);

        %%% read positions
        fid         = fopen([temp_loc,'positions']);
        temp_temp   = textscan(fid,'(%f %f %f) %f','HeaderLine',19); 
        temp_positions = cell2mat(temp_temp(1:3));
        fclose(fid);
        
        %%% remove the stuck particles and their positions
        temp_positions(temp_active == 0) = [];
        temp_active(temp_active == 0) = [];

        positions{i,j} = temp_positions;

        % count the total number of floating particles at this time
%         temp_active      = temp_active{1};
%         temp_tot_num_par = length(temp_active);
        temp_tot_num_par = length(temp_active);

        %%% remove the particles that has already been sucked
        %%% the outlet can x0 = 0.427161 y0 = 2.065 r = 0.2
        tmp_active_pos_r   = (temp_positions(:,1) - 0.427161).^2 + (temp_positions(:,2) - 2.065).^2;
        real_out_par_loc_r = find(tmp_active_pos_r <= 0.2.^2);
%         tmp_active_pos_y = temp_active.*temp_positions(:,2);
%         real_out_par_loc_y = find(tmp_active_pos_y >= 1.6);
        tmp_active_pos_z   = temp_positions(:,3);
        real_out_par_loc_z = find(tmp_active_pos_z < 2.18);
        real_out_par_loc   = intersect(real_out_par_loc_r,real_out_par_loc_z);
        %%% how many particles in the hood that has already been sucked
        temp_outlet        = temp_active(real_out_par_loc);
        %%% how many floating particles remain
        temp_active(real_out_par_loc) = [];       
%         temp_positions(real_out_par_loc) = [];
        temp_num_active    = length(temp_active);
        %%% store the number of particles
        tot_num_par(i,j)   = temp_tot_num_par;
        tot_num_act(i,j)   = temp_num_active;
        tot_num_out(i,j)   = length(temp_outlet);
    end
end
disp('finished loading the data')
tot_injections = sum(tot_num_par,1);
tot_actives    = sum(tot_num_act,1);
tot_suction    = sum(tot_num_out,1);
%%% sort the order
[t,indx]       = sort(t,'ascend');
tot_actives    = tot_actives(indx);
tot_injections = tot_injections(indx);
tot_suction    = tot_suction(indx);
end
