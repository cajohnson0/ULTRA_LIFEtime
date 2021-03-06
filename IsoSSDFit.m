function [output] = IsoSSDFit(data_file,c2,c2_std,tau_rot,CFOptions,Exp)
t2 = sort([data_file(1).para.t2]);
t2 = t2(7:35)./1000
Dm = (1./tau_rot)./6;
syms C1(x) C2(x)  C3(x) R_para(x) R_perp(x) R_iso(x) A(x) B(x) C(x) D(x)
C1(x) = exp(-2.*Dm*x);
C2(x) = exp(-6.*Dm*x);
C3(x) = exp(-12.*Dm*x);
R_iso(x) = C1(x);

ub = CFOptions.ub;
lb = CFOptions.lb;
startpoint = CFOptions.startpoint;
wt = 1./(c2_std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

if strcmp(Exp, 'single')
CFOptions.fitfcn = fittype( @(a1, tau1, x) a1.*exp(-x./tau1).*double(R_iso(x)),...
   'coeff', {'a1','tau1'}, 'indep', {'x'});
corrFcn = CFOptions.fitfcn;
[fitresult, gof, fitinfo] = fit(t2(:), c2(:), corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub,'Weight',wt,'Robust','Bisquare');
output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;

    figure,clf
    hold on
    plot(t2',fitresult(t2'),'b')
    errorbar(t2',c2',c2_std','bo')
    hold off
    xlabel('t_2 (ps)','Fontsize',16)
    ylabel('c_@','Fontsize',16)
    title('SSD','Fontsize',16)
    
elseif  strcmp(Exp, 'double')
CFOptions.fitfcn = fittype( @(a1, tau1,a2,tau2, x) (a1.*exp(-x./tau1).*a2.*exp(-x./tau2)).*double(R_para(x)),...
   'coeff', {'a1','tau1','a2','tau2'}, 'indep', {'x'});

corrFcn = CFOptions.fitfcn;
[fitresult, gof, fitinfo] = fit(t2(:), c2(:), corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub,'Weight',wt,'Robust','Bisquare');

output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;

    figure,clf
    hold on
    plot(t2',fitresult(t2'),'b')
    errorbar(t2',c2',c2_std','bo')
    hold off
    xlabel('t_2 (ps)','Fontsize',16)
    ylabel('c_@','Fontsize',16)
    title('SSD','Fontsize',16)
end