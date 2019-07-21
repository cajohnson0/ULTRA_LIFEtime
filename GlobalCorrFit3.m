function [output] = GlobalCorrFit3(t2,c2,c2_std,p0,Exp)
%same idea but with two independent rotational times and the same SSD time

t2 = sort([t2]);

t2x = [t2,zeros(size(t2))];
t2y = [zeros(size(t2)),t2];
t2n = [t2 t2];
%t2 = [t2 t2]
%syms C1(x) C2(x)  C3(x) R_para(x) R_perp(x)
C1 = @(tr,x)exp(-2.*(1./(6*tr))*x);
C2 = @(tr,x)exp(-6.*(1./(6*tr))*x);
C3 = @(tr,x)exp(-12.*(1./(6*tr))*x);
R_para = @(tr,x)(3/25)*((11.*C1(tr,x) + 4*C3(tr,x))./(1+0.8*C2(tr,x)));
R_perp = @(tr,x)(3/25)*((7.*C1(tr,x) - 2*C3(tr,x))./(1-0.4*C2(tr,x)));

if strcmp(Exp, 'single')
    CFOptions.fitfcn = fittype( @(a1,a2, tau1, tr1,tr2, t2x, t2y)...
        (t2x>0) .*(a1.*exp(-t2x./tau1).*R_para(tr1,t2x) + a2.*exp(-t2x./tau1).*R_para(tr2,t2x))...
        +(t2y>0).*(a1.*exp(-t2y./tau1).*R_perp(tr1,t2y) + a2.*exp(-t2y./tau1).*R_perp(tr2,t2y)),...
   'coeff', {'a1','a2','tau1','tr1','tr2'}, 'indep', {'t2x','t2y'});
%CFOptions.fitfcn = fittype( @(a1, tau1, x) a1.*exp(-x./tau1).*(double(R_para(x))+double(R_perp(x))),...
   %'coeff', {'a1','tau1'}, 'indep', {'x'});
output = CFOptions.fitfcn(p0(1),p0(2),p0(3),p0(4),p0(5),t2x,t2y);%t2n);

    
elseif  strcmp(Exp, 'double')
    CFOptions.fitfcn = fittype( @(a1,a2,a3,a4,tau1,tau2,tr1,tr2,t2x,t2y)... 
         (t2x>0).*(a1.*exp(-t2x./tau1).*R_para(tr1,t2x) + a2.*exp(-t2x./tau1).*R_para(tr2,t2x))...
        +(t2y>0).*(a1.*exp(-t2y./tau1).*R_perp(tr1,t2y) + a2.*exp(-t2y./tau1).*R_perp(tr2,t2y))...
        +(t2x>0).*(a3.*exp(-t2x./tau2).*R_para(tr1,t2x) + a4.*exp(-t2x./tau2).*R_para(tr2,t2x))...
        +(t2y>0).*(a3.*exp(-t2y./tau2).*R_perp(tr1,t2y) + a4.*exp(-t2y./tau2).*R_perp(tr2,t2y)),...
   'coeff', {'a1','a2','a3','a4','tau1','tau2','tr1','tr2'}, 'indep', {'t2x','t2y'});
output = CFOptions.fitfcn(p0(1),p0(2),p0(3),p0(4),p0(5),p0(6),p0(7),p0(8),t2x,t2y);

end