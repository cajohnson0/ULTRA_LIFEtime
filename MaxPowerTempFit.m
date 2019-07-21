function [output] = MaxPowerTempFit(data_file,tc,tc_std,CFOptions,Type)
Ts = Type;
tc_fs = tc.*1000;
tc_std_fs = tc_std.*1000;

for ii = 1:length(data_file)
    temps(ii) = data_file(ii).T_K;
    x(ii) = data_file(ii).T_K - Ts;
end

% ub = CFOptions.ub;
% lb = CFOptions.lb;
% startpoint = CFOptions.startpoint;
% corrFcn = CFOptions.fitfcn;
% 
% [fitresult,gof,fitinfo] = fit(x(:), tc_fs(:), corrFcn, 'StartPoint', startpoint,...
%     'lower', lb,'upper',ub);
ub = CFOptions.ub;
lb = CFOptions.lb;
startpoint = CFOptions.startpoint;
corrFcn = CFOptions.fitfcn;

% tc_std_2 = tau_fs_in.* (tc_std_fs./tc_fs)
%c2_std = 0.434.*(tc_std_2./tau_fs_in);
c2_std_log = 0.434.*(tc_std_fs./tc_fs);
c2_std = tc_std_fs;
wt = 1./(c2_std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

% do the fitting
[fitresult,gof,fitinfo] = fit(x(:), tc_fs(:), corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub,'Weight',wt,'Robust','Bisquare');

output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;

    figure,clf
    hold on
    plot(log(x),log(1./fitresult(x)),'r')
    errorbar(log(x),log(1./tc_fs),c2_std_log,'ro')
    hold off
    xlabel('ln(T-T_s)','Fontsize',16)
    ylabel('ln(fs/\tau_c)','Fontsize',16)
    title('Power Law Fit (VFT)','Fontsize',16)
end