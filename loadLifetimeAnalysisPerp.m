function d = loadLifetimeAnalysisPerp(data_file_search_string)
d = construct2dPP;

path_name = fileparts(data_file_search_string);
files = dir(data_file_search_string);

for ii = 1:length(files)
    str = fullfile(path_name,files(ii).name);
    temp = load(str);
    
    d(ii).w1 = temp(1,2:end);
    d(ii).R  = temp(130:257,2:end);
    d(ii).w3 = temp(130:257,1);
%     d(ii).comment = sprintf(files.name);
    
    %try to infer t2 time from the file name
    t2 = sscanf(files(ii).name,'%i');
    d(ii).t2 = t2; %take only the first match?
end
