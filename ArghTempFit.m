function [output] = ArghTempFit(data_file,tc,CFOptions)
tc_fs = tc.*1000;
%tc_fs = tc;
for ii = 1:length(data_file)
    temps(ii) = data_file(ii).T_K;
end

R = (1.9872036E-3);
temps_2 = 1./(R.*(temps));
tc_log = log(1./tc_fs);

ub = CFOptions.ub;
lb = CFOptions.lb;
startpoint = CFOptions.startpoint;
corrFcn = CFOptions.fitfcn;

[fitresult,gof,fitinfo] = fit(temps_2(:), tc_log, corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub);
output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;

    figure,clf
    hold on
    plot(temps_2,fitresult(temps_2),'b')
    plot(temps_2,tc_log,'bo')
    hold off
    xlabel('1/RT (mol/kcal)','Fontsize',16)
    ylabel('ln(1/t_{c})','Fontsize',16)
    title('Arrhenius Fit','Fontsize',16)

end