function [CFFit] = TempDepDataFit(data_file,tc,tc_std,CFOptions,Type)
%Arr = 0
%VFT = Ts or Tg (glass transition temperature)
% CFoptions.flag_plot = flag_plot;
% flag_plot will later determine if we're going to plot our CLS fits
% against the data that generated them.
if Type == 0
     CFFit = ArghTempFit(data_file,tc,CFOptions);
    elseif Type == 1
     CFFit = ArghTempFit_wt(data_file,tc,tc_std,CFOptions);
    elseif Type == 2
     CFFit = MaxPowerTempFit_3(data_file,tc,CFOptions,Type);
    elseif Type > 4
     CFFit = MaxPowerTempFit(data_file,tc,tc_std,CFOptions,Type);
    elseif Type == 3 
     CFFit = EyringTempFit(data_file,tc,tc_std,CFOptions);
end
CFFit.fitresult
end