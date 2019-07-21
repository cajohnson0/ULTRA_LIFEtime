function data = myLoadTRMPS(options)

expt_calib_dir = [options.base_dir,options.calibration_date_str,'/',options.calibration_directory];
expt_data_dir = [options.base_dir,options.experiment_date_str,'/',options.experiment_dir_str];

owd = pwd;

cd(expt_calib_dir);
%calib_in = csvread('calib.csv'); %what is this?
probe1_in = csvread(options.calibration_probe1_name);
probe2_in = csvread(options.calibration_probe2_name);

freq = [probe1_in(:,2)' probe2_in(:,2)'];

%figure(1),plot(freq,calib_in(:,2))

% load data
cd(expt_data_dir);


% skip the first column ('TRMPS' causes an error) with the row offset=0,
% column offset = 1 optional arguments
data_in = csvread(options.experiment_file_str,0,1);
time = data_in(1,:);
probe = data_in(2:257,:);
ref = data_in(258:end,:);

abs = probe-ref; %these are supposed to be in OD already...

[time,ind1] = sort(time);
abs = abs(:,ind1);

[freq,ind2] = sort(freq);
abs = abs(ind2,:);

data.abs = abs;
data.time = time;
data.freq = freq;
data.tag = '';
data.peaks = struct('abs','','time','','freq','','range1','','range2','',...
    'baseline','','fitresult','','fitoptions','','assignment','');
cd(owd);