function [output] = GlobalCorrFit6(t2,~,~,p0,~)
%same idea but with two independent rotational times and the same SSD time

t2 = sort([t2]);

t2x = [t2,zeros(size(t2))];
t2y = [zeros(size(t2)),t2];
t2n = [t2 t2];

a = p0(1);
tr = p0(2);
theta_deg = p0(3);

%t2 = [t2 t2]
%syms C1(x) C2(x)  C3(x) R_para(x) R_perp(x)
% C1 = @(tr,x)exp(-2.*(1./(6*tr))*x);
% C2 = @(tr,x)exp(-6.*(1./(6*tr))*x);
% C3 = @(tr,x)exp(-12.*(1./(6*tr))*x);
% R_para = @(tr,x)(3/25)*((11.*C1(tr,x) + 4*C3(tr,x))./(1+0.8*C2(tr,x)));
% R_perp = @(tr,x)(3/25)*((7.*C1(tr,x) - 2*C3(tr,x))./(1-0.4*C2(tr,x)));

CFOptions.fitfcn = fittype('RISDFitWobbling(a,tr,theta_deg,t2x,t2y)',...
    'coeff', {'a','tr','theta_deg'}, 'indep', {'t2x','t2y'});
output = CFOptions.fitfcn(a,tr,theta_deg,t2x,t2y);%t2n);

end

