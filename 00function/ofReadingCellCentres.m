%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% post-processing code to read the cell centres
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function coord = ofReadingCellCentres(folder_loc,case_loc)
%% read the folders
%%% get the number of processors that I decomposed
num_of_processors = dir([folder_loc,case_loc,'\processor*']);
disp('start to load the data')
%% now read the particles
C  = cell(length(num_of_processors),1);
for i = 1:length(num_of_processors)
    disp(['reading C = (Cx Cy Cz) from processor', num2str(i)])
    temp_loc    = [folder_loc,case_loc,'\',num_of_processors(i).name,'\0\'];
    %%% read active       
    fid         = fopen([temp_loc,'C']);
    temp_C      = textscan(fid,'(%f %f %f)','HeaderLine',23);
    fclose(fid); 
    %%% remove the stuck particles and their positions
    C{i} = cell2mat(temp_C);
end
coord = cell2mat(C);
end
