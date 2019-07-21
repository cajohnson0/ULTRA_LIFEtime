function TempDepDataPlot(data_file,t_c,fitresult,Type,crayola)
%Arr = 0
%VFT = Ts or Tg (glass transition temperature)
% CFoptions.flag_plot = flag_plot;
% flag_plot will later determine if we're going to plot our CLS fits
% against the data that generated them.
if Type == 0
     ArghTempPlot(data_file,t_c,fitresult,crayola);
    elseif Type == 1
     MaxPowerTempPlot_3(data_file,t_c,fitresult,Type,crayola);
    elseif Type > 1
     MaxPowerTempPlot(data_file,t_c,fitresult,Type,crayola);
end
end