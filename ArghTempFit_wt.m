function [output] = ArghTempFit_wt(data_file,tc,tc_std,CFOptions)
tc_fs = tc.*1000;
tc_std_fs = tc_std.*1000;
for ii = 1:length(data_file)
    temps(ii) = data_file(ii).T_K;
end

R = (1.9872036E-3);
temps_2 = 1./(R.*temps);
tc_log = log(1./tc_fs);
%tau_fs_in = 1./tc_fs;
ub = CFOptions.ub;
lb = CFOptions.lb;
startpoint = CFOptions.startpoint;
corrFcn = CFOptions.fitfcn;

% tc_std_2 = tau_fs_in.* (tc_std_fs./tc_fs)
%c2_std = 0.434.*(tc_std_2./tau_fs_in);
c2_std = 0.434.*(tc_std_fs./tc_fs);
wt = 1./(c2_std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

% do the fitting
[fitresult,gof,fitinfo] = fit(temps_2(:), tc_log(:), corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub,'Weight',wt,'Robust','Bisquare');

output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;

    figure,clf
    hold on
    errorbar(temps_2,tc_log,c2_std,'bo')
    plot(temps_2,fitresult(temps_2),'b')
    hold off
    xlabel('1/RT (mol/kcal)','Fontsize',16)
    ylabel('ln(1/t_{c})','Fontsize',16)
    title('Arrhenius Fit','Fontsize',16)

end