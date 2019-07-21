function [output] = MaxPowerTempFit_3(data_file,tc,CFOptions,Type)
tc_fs = tc.*1000;
for ii = 1:length(data_file)
    x(ii) = data_file(ii).T_K;
%     x(ii) = data_file(ii).T_K - Ts;
end

ub = CFOptions.ub;
lb = CFOptions.lb;
startpoint = CFOptions.startpoint;
corrFcn = CFOptions.fitfcn;

[fitresult,gof,fitinfo] = fit(x(:), tc_fs(:), corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub);
output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;

    figure,clf
    hold on
    plot(log(x),log(fitresult(x)),'r')
    plot(log(x),log(tc_fs),'ro')
    hold off
    xlabel('ln(T-T_s)','Fontsize',16)
    ylabel('ln(\tau_c)','Fontsize',16)
    title('Power Law Fit (VFT)','Fontsize',16)
end