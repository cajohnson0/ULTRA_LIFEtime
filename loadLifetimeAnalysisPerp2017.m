function d = loadLifetimeAnalysisPerp2017(data_file_search_string)
d = construct2dPP;

path_name = fileparts(data_file_search_string);
files = dir(data_file_search_string);

for ii = 1:length(files)
    str = fullfile(path_name,files(ii).name);
    temp = load(str);
    
    d(ii).w1 = temp(1,2:end);
    d(ii).R  = temp(2:129,2:end);
    d(ii).w3 = temp(2:129,1);
%     d(ii).comment = sprintf(files.name);
    
    %try to infer t2 time from the file name
    string = regexp(files(ii).name,'[\w_]([-+]?\d*.\d*)ps[\w_]','tokens');  
    t2 = sscanf(string{1}{1},'%f');
%   t2 = sscanf(files(ii).name,'%i');
     d(ii).t2 = t2.*1000; %take only the first match?
end
