%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% to read the number of floating particles
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [U_fin,p_fin] = ofVelocityReading(folder_loc,case_loc)
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
U     = cell(length(num_of_processors));
p     = cell(length(num_of_processors));
for i = 1:length(num_of_processors)
    disp(['reading files from processor', num2str(i)])
    temp_loc    = [folder_loc,case_loc,'\',num_of_processors(i).name,'\',num2str(t(end)),'\'];
    %%% read active       
    fid         = fopen([temp_loc,'U']);
    temp_U      = textscan(fid,'(%f %f %f)','HeaderLine',23);
    fclose(fid); 
    U{i}        = cell2mat(temp_U);

    %%% read positions
    fid         = fopen([temp_loc,'p']);
    temp_p      = textscan(fid,'%f','HeaderLine',23); 
    p{i}        = cell2mat(temp_p);
    fclose(fid);
end
disp('finished loading the data')
U_fin  = cell2mat(U);
p_fin  = cell2mat(p);

end
