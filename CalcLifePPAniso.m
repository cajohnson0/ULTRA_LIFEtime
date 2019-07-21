function [CFFit] = CalcLifePPAniso(data_file,CFOptions)

t2_array = [data_file.para.t2]./1000;
area_para = [data_file.para.area];
area_para_std = [data_file.para.area_std];
area_perp = [data_file.perp.area];
area_perp_std = [data_file.perp.area_std];

% Calc Aniso std
for ii = 1:length(t2_array)
    CFFit.aniso(ii) = (area_para(ii) - area_perp(ii))./(area_para(ii)+2.*area_perp(ii));
    CFFit.t2(ii) = data_file.para(ii).t2;
    sub = area_para(ii) - area_perp(ii);
    add = area_para(ii)+2.*area_perp(ii);
    sub_std = sqrt(area_para_std(ii).^2 + area_perp_std(ii).^2);
    add_std = sqrt(area_para_std(ii).^2 + (2.*area_perp_std(ii)).^2);
    aniso_std = sqrt((sub_std.^2./add.^2)+(sub.^2*add_std.^2./add.^4));
    %CFFit.aniso_std(ii) = sqrt(left_top.^2+right_top.^2)
    CFFit.aniso_std(ii) = aniso_std;
end

%Do you want to plot it?
if isfield(CFOptions,'flag_plot')
    flag_plot = CFOptions.flag_plot;
else
    flag_plot = 0;
end
CFOptions.flag_plot = flag_plot;

std = [CFFit.aniso_std];
aniso = [CFFit.aniso];
%Calc weight of area
wt = 1./(std).^2;
wt_mean = mean(wt);
wt = wt./wt_mean;

[fitresult,gof,fitinfo] = fit(t2_array(:), aniso(:), CFOptions.FitFcn, 'StartPoint', CFOptions.startpoint,...
    'lower', CFOptions.lb,'upper',CFOptions.ub,'Weight',wt,'Robust','Bisquare');
CFFit.fitresult = fitresult;
CFFit.gof = gof;
CFFit.fitinfo = fitinfo;
CFFit.tau_total = abs(integrate(fitresult,0,Inf))./0.4;
CFFit.T_K = data_file.T_K;
CFFit.T_degC = data_file.T_degC;

figure(101),clf
hold on
errorbar(t2_array(:), aniso(:),std(:),'bo')
plot(t2_array(:),fitresult(t2_array(:)),'b')
ylim([-0.05 0.45])
xlabel('t_2 (ps)')
ylabel('\alpha (t_2)')
Figure_Settings(gca,gcf)
hold off