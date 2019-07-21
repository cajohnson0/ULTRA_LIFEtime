function output = Global_RISD_fits(tr_array,PARAMS,CFOptions)
t2 = PARAMS.t2
C1 = @(tr,x)exp(-2.*(1./(6*tr))*x);
C2 = @(tr,x)exp(-6.*(1./(6*tr))*x);
C3 = @(tr,x)exp(-12.*(1./(6*tr))*x);
R_para = @(tr,x)(3/25)*((11.*C1(tr,x) + 4*C3(tr,x))./(1+0.8*C2(tr,x)));
R_perp = @(tr,x)(3/25)*((7.*C1(tr,x) - 2*C3(tr,x))./(1-0.4*C2(tr,x)));

for ii = 1:length(PARAMS.Temp_K)
  Rpara(:,ii) = R_para(tr_array(ii),t2) 
  Rperp(:,ii) = R_perp(tr_array(ii),t2) 
end

for ii = 1:length(PARAMS.Temp_K)
%Rpara fit
[fitresult,gof,fitinfo] = fit(t2(:), Rpara(:,ii), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
RISD_Rpara(ii).fitresult = fitresult;
RISD_Rpara(ii).gof = gof;
RISD_Rpara(ii).fitinfo = fitinfo;
RISD_Rpara(ii).tau_total = integrate(fitresult,Inf,0);
RISD_Rpara(ii).tau = fitresult.t1;
ci = confint(RISD_Rpara(ii).fitresult)
a_ci(ii) = ci(2,1) - RISD_Rpara(ii).fitresult.a1;
t_ci(ii) = ci(2,2) - RISD_Rpara(ii).fitresult.t1;
RISD_Rpara(ii).tau_std = sqrt(a_ci(ii).^2 + t_ci(ii).^2)

figure(ii),clf
hold on
plot(t2(:), Rpara(:,ii),'bo')
plot(t2(:), fitresult(t2),'r')
hold off
pause(0.1)

%Rperp fit
[fitresult,gof,fitinfo] = fit(t2(:), Rperp(:,ii), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub);
RISD_Rperp(ii).fitresult = fitresult;
RISD_Rperp(ii).gof = gof;
RISD_Rperp(ii).fitinfo = fitinfo;
RISD_Rperp(ii).tau_total = integrate(fitresult,Inf,0);
RISD_Rperp(ii).tau = fitresult.t1;
ci = confint(RISD_Rperp(ii).fitresult)
a_ci(ii) = ci(2,1) - RISD_Rperp(ii).fitresult.a1;
t_ci(ii) = ci(2,2) - RISD_Rperp(ii).fitresult.t1;
RISD_Rperp(ii).tau_std = sqrt(a_ci(ii).^2 + t_ci(ii).^2)

output(ii).Rpara = RISD_Rpara(ii);
output(ii).Rperp = RISD_Rperp(ii);
end
