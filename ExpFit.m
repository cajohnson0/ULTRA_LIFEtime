
function [output] = ExpFit(t2,area,CFOptions)

   area = area;
   t2 = t2;
   
% CFoptions.flag_plot = flag_plot;
% flag_plot will later determine if we're going to plot our CLS fits
% against the data that generated them.
%CFFit = corrFcnFitAniso(t2,area,CFoptions);
% c2_std = std;
% wt = 1./(c2_std).^2;
% wt_mean = mean(wt);
% wt = wt./wt_mean;

ub = CFOptions.ub;
lb = CFOptions.lb;
startpoint = CFOptions.startpoint;
corrFcn = CFOptions.fitfcn;
% do the fitting
[fitresult,gof,fitinfo] = fit(t2', area', corrFcn, 'StartPoint', startpoint,...
    'lower', lb,'upper',ub);%,'Weight',wt,'Robust','Bisquare');

output.fitresult = fitresult;
output.gof = gof;
output.fitinfo = fitinfo;
output.area = area;
output.t2 = t2;
%output.std = std;

%Exp = CFFit.fitresult.a1 .* exp(-t2./CFFit.fitresult.t1);
figure(101),clf
hold on
plot(t2,fitresult(t2),'b')
plot(t2,area,'bo')
%errorbar(t2,area,std,'bo')
hold off
xlabel('t_2 (ps)','Fontsize',16)
ylabel('area (arb.)','Fontsize',16)
ylim([0 0.45])
%title([num2str(data_file(1).T_degC),' ^oC'],'Fontsize',24)