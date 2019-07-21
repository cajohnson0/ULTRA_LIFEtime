function [CFFit] = CalcLifeLifetime(data_file,CFOptions)


t2_array = [data_file.para.t2]./1000;
area_para = [data_file.para.area];
area_para_std = [data_file.para.area_std];

wt = 1./(area_para_std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

[fitresult,gof,fitinfo] = fit(t2_array(:), area_para(:), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub,'Weight',wt,'Robust','Bisquare');
CFFit.para.fitresult = fitresult;
CFFit.para.gof = gof;
CFFit.para.fitinfo = fitinfo;

% Perp
t2_array = [data_file.perp.t2]./1000;
area_perp = [data_file.perp.area];
area_perp_std = [data_file.perp.area_std];

wt = 1./(area_perp_std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

[fitresult,gof,fitinfo] = fit(t2_array(:), area_perp(:), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub,'Weight',wt,'Robust','Bisquare');
CFFit.perp.fitresult = fitresult;
CFFit.perp.gof = gof;
CFFit.perp.fitinfo = fitinfo;

%Iso
t2_array = [data_file.iso.t2]./1000;
area_iso = [data_file.iso.area];
area_iso_std = [data_file.iso.area_std];

wt = 1./(area_iso_std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

[fitresult,gof,fitinfo] = fit(t2_array(:), area_iso(:), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub,'Weight',wt,'Robust','Bisquare');
CFFit.iso.fitresult = fitresult;
CFFit.iso.gof = gof;
CFFit.iso.fitinfo = fitinfo;
CFFit.T_K = data_file.T_K;
CFFit.T_degC = data_file.T_degC;