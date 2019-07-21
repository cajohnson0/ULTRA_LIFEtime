function viewLifePP(data_file,range3,Pol)

if strcmp(Pol, 'para')
for ii = 1:length(data_file.iso)
    figure(ii),clf
plot(data_file.para(ii).w3,data_file.para(ii).PP)
xlim(range3)
ylim([min(data_file.para(1).PP) max(data_file.para(1).PP)])
xlabel('t_2 (ps)')
ylabel('\DeltaAbs (mOD)')
Figure_Settings(gca,gcf)
title(['Para t2 = ' num2str(data_file.para(ii).t2./1000) 'ps'],'FontSize',24)
pause(0.1)
end

elseif strcmp(Pol, 'perp')
   for ii = 1:length(data_file.iso)
figure(ii),clf
plot(data_file.perp(ii).w3,data_file.perp(ii).PP)
xlim(range3)
ylim([min(data_file.perp(1).PP) max(data_file.perp(1).PP)])
xlabel('t_2 (ps)')
ylabel('\DeltaAbs (mOD)')
Figure_Settings(gca,gcf)
title(['Perp t2 = ' num2str(data_file.perp(ii).t2./1000) 'ps'],'FontSize',24)
pause(0.1)
   end 

elseif strcmp(Pol, 'iso')    
    for ii = 1:length(data_file.iso)
figure(ii),clf
plot(data_file.iso(ii).w3,data_file.iso(ii).PP)
xlim(range3)
ylim([min(data_file.iso(1).PP) max(data_file.iso(1).PP)])
xlabel('t_2 (ps)')
ylabel('\DeltaAbs (mOD)')
Figure_Settings(gca,gcf)
title(['Iso t2 = ' num2str(data_file.iso(ii).t2./1000) 'ps'],'FontSize',24)
pause(0.1)
    end
end