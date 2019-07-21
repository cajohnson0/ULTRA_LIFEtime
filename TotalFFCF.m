function [output] = TotalFFCF(datafile,CFFit,Type)

if strcmp(Type, 'single')
    a1 = CFFit.fitresult.a1;
    t1 = CFFit.fitresult.t1;
    ci = confint(CFFit.fitresult);
    a1_std = CFFit.fitresult.a1 - ci(1,1);
    t1_std = CFFit.fitresult.t1 - ci(1,2);
    tau = t1;
    tau_std = t1_std;
 
    elseif  strcmp(Type, 'double')
    a1 = CFFit.fitresult.a1;
    t1 = CFFit.fitresult.t1;
    a2 = CFFit.fitresult.a2;
    t2 = CFFit.fitresult.t2;
    ci = confint(CFFit.fitresult);
    a1_std = CFFit.fitresult.a1 - ci(1,1);
    t1_std = CFFit.fitresult.t1 - ci(1,2);
    a2_std = CFFit.fitresult.a2 - ci(1,3);
    t2_std = CFFit.fitresult.t2 - ci(1,4);
    tau = integrate(CFFit.fitresult,Inf,0);
    tau_std = sqrt((a1_std./a1).^2 + (t1_std./t1).^2 + (a2_std./a1).^2 + (t2_std./t1).^2);
end

output.tau = tau;
output.tau_std = tau_std;
output.T_K = datafile.T_K
output.T_degC = datafile.T_degC
end
