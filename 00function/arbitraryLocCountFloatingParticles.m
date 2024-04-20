%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% to read the number of floating particles
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t,tot_floating,tot_particles,num_par_region] = arbitraryLocCountFloatingParticles(folder_loc,case_loc,xlim,ylim,zlim)
%% xlim,ylim,zlim should be an 1x2 array that covers a certain region or section
%% read the folders
%%% get the number of processors that I decomposed
num_of_processors = dir([folder_loc,case_loc,'\processor*']);
%%% get the number of time series
%%% firstly find the folders that contains the positions and actives files
t = [];
for i = 1:length(num_of_processors)
    num_of_pos    = dir([folder_loc,case_loc,'\processor',num2str(i-1),'\*\lagrangian\kinematicCloud\positions']);
    num_of_act    = dir([folder_loc,case_loc,'\processor',num2str(i-1),'\*\lagrangian\kinematicCloud\active']);
    if length(num_of_pos) >= length(num_of_act)
        num_of_ptc = num_of_act;
    else
        num_of_ptc = num_of_pos;
    end
    %%% extract the time from the path of num_of_ptc
    tmp_t    = zeros(size(num_of_ptc));
    for ii = 1:length(tmp_t)
        tmp_time  = regexp(num_of_ptc(ii).folder, '\d+','match');
        tmp_t(ii) = str2double(cell2mat(tmp_time(2)));        
    end
    %%% compare to find the interaction of the available t in each folder
    t = union(t,tmp_t);
end
% listName          = {num_of_time.name};
% matchC            = regexp(listName, '[0-9]', 'start');
% match             = ~cellfun('isempty', matchC);
% list_t            = num_of_time(match);
% %%% get all time for future use
% t                 = zeros();
% for i = 1:length(list_t)
%     t(i) = str2num(list_t(i).name);
% end
disp('start to load the data')
%% now read the particles
tot_num_float = zeros(length(num_of_processors),length(t));
tot_num_all   = zeros(length(num_of_processors),length(t));
num_par_region = zeros(length(num_of_processors),length(t));
for i = 1:length(num_of_processors)
    disp(['reading files from processor', num2str(i-1)])
    for j = 1:length(t)
        temp_loc    = [folder_loc,case_loc,'\',num_of_processors(i).name,'\',num2str(t(j)),'\lagrangian\kinematicCloud\'];
        %%% check whether there is a file
        is_there_active    = dir([temp_loc,'active']);
        is_there_positions  = dir([temp_loc,'positions']);
        if (size(is_there_active,1)*size(is_there_positions,1)) ~= 0
        %%% read active       
        fid         = fopen([temp_loc,'active']);
        temp_active = textscan(fid,'%f','HeaderLine',20);
        fclose(fid); 
        % make them be array
        temp_active = double(temp_active{1} == 1);

        %%% read positions
        fid         = fopen([temp_loc,'positions']);
        temp_temp   = textscan(fid,'(%f %f %f) %f','HeaderLine',19); 
        temp_positions = cell2mat(temp_temp(1:3));
        fclose(fid);

        %%% remove the stuck particles and their positions
        tot_num_all(i,j)   = size(temp_positions,1);
        temp_positions(temp_active == 0,:) = []; 
        tot_num_float(i,j) = size(temp_positions,1);

        %%% remove the particles in the assigned region
        real_out_par_loc_x = find(temp_positions(:,1) >= xlim(1) & temp_positions(:,1) <= xlim(2));
        real_out_par_loc_y = find(temp_positions(:,2) >= ylim(1) & temp_positions(:,2) <= ylim(2));
        real_out_par_loc_z = find(temp_positions(:,3) >= zlim(1) & temp_positions(:,3) <= zlim(2));
        real_out_par_loc   = intersect(intersect(real_out_par_loc_x,real_out_par_loc_y),real_out_par_loc_z);

            %%% check if there is no active particles in that processor
            if isempty(real_out_par_loc) == 0         
                %%% store the number of particles
                num_par_region(i,j) = length(real_out_par_loc); 
            else
                %%% store the number of particles
                num_par_region(i,j) = 0;
            end

        else
            disp(['Particle properties are not in processor ',num2str(i - 1),' at time folder ',num2str(t(j))])
            disp('Number of particles in the above is 0')

            tot_num_float(i,j)  = 0;
            tot_num_all(i,j)    = 0;
            num_par_region(i,j) = 0;
        end

    end
end
disp('finished loading the data')
tot_floating   = sum(tot_num_float,1);
tot_particles  = sum(tot_num_all,1);
num_par_region = sum(num_par_region,1);
%%% sort the order
[t,indx]       = sort(t,'ascend');
tot_floating   = tot_floating(indx);
tot_particles  = tot_particles(indx);
num_par_region = num_par_region(indx);
end
