function output = RISD_fits(RISD,PARAMS,CFOptions)
t2 = PARAMS.t2
Rpara = RISD.Rpara;
Rperp = RISD.Rperp;
Riso = RISD.Riso;

for ii = 1:length(PARAMS.Temp_K)
%Rpara fit
[fitresult,gof,fitinfo] = fit(t2(:), Rpara(:,ii), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
RISD_Rpara(ii).fitresult = fitresult;
RISD_Rpara(ii).gof = gof;
RISD_Rpara(ii).fitinfo = fitinfo;
RISD_Rpara(ii).tau_total = integrate(fitresult,Inf,0);
RISD_Rpara(ii).tau = fitresult.t1;

%Rperp fit
[fitresult,gof,fitinfo] = fit(t2(:), Rperp(:,ii), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
RISD_Rperp(ii).fitresult = fitresult;
RISD_Rperp(ii).gof = gof;
RISD_Rperp(ii).fitinfo = fitinfo;
RISD_Rperp(ii).tau_total = integrate(fitresult,Inf,0);
RISD_Rperp(ii).tau = fitresult.t1;

%Riso fit
[fitresult,gof,fitinfo] = fit(t2(:), Riso(:,ii), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
RISD_Riso(ii).fitresult = fitresult;
RISD_Riso(ii).gof = gof;
RISD_Riso(ii).fitinfo = fitinfo;
RISD_Riso(ii).tau_total = integrate(fitresult,Inf,0);
RISD_Riso(ii).tau = fitresult.t1;

output(ii).Rpara = RISD_Rpara(ii);
output(ii).Rperp = RISD_Rperp(ii);
output(ii).Riso = RISD_Riso(ii);
end
