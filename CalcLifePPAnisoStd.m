function [Output] = CalcLifePPAnisoStd(data_file,Exp)

if strcmp(Exp,'exp')
    conf = confint(data_file.fitresult);
    a = data_file.fitresult.a1;
    tau = data_file.fitresult.t1;
    a_std = conf(2,1) - a;
    tau_std = conf(2,2) - tau;
    tau_total_std = sqrt(tau.^2.*a_std^2+a.^2.*tau_std^2)./2;
    
elseif strcmp(Exp,'biexp')
    conf = confint(data_file.fitresult);
    a1 = data_file.fitresult.a1;
    tau1 = data_file.fitresult.t1;
    a2 = data_file.fitresult.a2;
    tau2 = data_file.fitresult.t2;
    a1_std = conf(2,1) - a2;
    tau1_std = conf(2,2) - tau2;
    a2_std = conf(2,3) - a2;
    tau2_std = conf(2,4) - tau2;
    t1_std = sqrt(tau1.^2.*a1_std^2+a1.^2.*tau1_std^2);
    t2_std = sqrt(tau2.^2.*a2_std^2+a2.^2.*tau2_std^2);
    tau_total_std = sqrt(t1_std.^2 + t2_std.^2)./0.4;
end

Output = tau_total_std;