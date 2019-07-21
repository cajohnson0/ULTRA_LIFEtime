function output = FFCF_Arhfit_RISD(CFFit,PARAMS,CFOptions)
T_K = PARAMS.Temp_K
R = PARAMS.R

for ii = 1:length(CFFit)
    Rpara_tau_total(ii) = CFFit(ii).Rpara.tau.*1000; %ps to fs
    Rperp_tau_total(ii) = CFFit(ii).Rperp.tau.*1000; %ps to fs
%     Riso_tau_total(ii) = CFFit(ii).Riso.tau.*1000; %ps to fs
end 

%Para fit
[fitresult,gof,fitinfo] = fit(1./(R.*T_K)', log(1./Rpara_tau_total)', CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
Rpara.fitresult = fitresult;
Rpara.gof = gof;
Rpara.fitinfo = fitinfo;

%Perp fit
[fitresult,gof,fitinfo] = fit(1./(R.*T_K)', log(1./Rperp_tau_total)', CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
Rperp.fitresult = fitresult;
Rperp.gof = gof;
Rperp.fitinfo = fitinfo;

% %Iso fit
% [fitresult,gof,fitinfo] = fit(1./(R.*T_K)', log(1./Riso_tau_total)', CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
%     'lower', CFOptions.lb,'upper',CFOptions.ub);
% Riso.fitresult = fitresult;
% Riso.gof = gof;
% Riso.fitinfo = fitinfo;

output.Rpara = Rpara;
output.Rperp = Rperp;
% output.Riso = Riso;

figure(101),clf
hold on
plot(1./(R.*T_K)',log(1./Rperp_tau_total)','ro')
plot(1./(R.*T_K)',Rperp.fitresult(1./(R.*T_K)),'r')
plot(1./(R.*T_K)',log(1./Rpara_tau_total)','bo')
plot(1./(R.*T_K)',Rpara.fitresult(1./(R.*T_K)),'b')
xlabel('1/RT_K (kcal/mol)')
ylabel('log(1/\tau (fs))')
legend('perp','','para','')
Figure_Settings(gca,gcf)
hold off
end