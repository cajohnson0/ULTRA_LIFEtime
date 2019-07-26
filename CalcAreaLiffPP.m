function [CFFit] = CalcAreaLiffPP(data_file,CFOptions)

para = data_file.para;
perp = data_file.perp;
%iso = data_file.iso;

if isfield(CFOptions,'flag_plot')
    flag_plot = CFOptions.flag_plot;
else
    flag_plot = 0;
end
CFOptions.flag_plot = flag_plot;

for ii = 1:length(para)
[fitresult,gof,fitinfo] = fit(para(ii).w3,para(ii).PP,CFOptions.fitfcn, 'StartPoint',CFOptions.startpoint,...
            'lower',CFOptions.lb,'upper',CFOptions.ub);
CFFit.para(ii).t2 = data_file.para(ii).t2;
CFFit.para(ii).fitresult =fitresult;
CFFit.para(ii).gof = gof;
CFFit.para(ii).fitinfo = fitinfo;
CFFit.para(ii).area = CFFit.para(ii).fitresult.a.*CFFit.para(ii).fitresult.c.*sqrt(pi);
CFFit.para(ii).area_conf = confint(CFFit.para(ii).fitresult);
CFFit.para(ii).area_std = sqrt(((CFFit.para(ii).area_conf(2,1)-CFFit.para(ii).fitresult.a).*(CFFit.para(ii).fitresult.c)).^2+...
    ((CFFit.para(ii).area_conf(2,3)-CFFit.para(ii).fitresult.c).*CFFit.para(ii).fitresult.a).^2);
if flag_plot
figure(ii),clf
hold on
plot(para(ii).w3,para(ii).PP,'o')
plot(para(ii).w3,CFFit.para(ii).fitresult(para(ii).w3))
hold off
pause(0.1)
end
end


for ii = 1:length(perp)
[fitresult,gof,fitinfo] = fit(perp(ii).w3,perp(ii).PP,CFOptions.fitfcn, 'StartPoint',CFOptions.startpoint,...
            'lower',CFOptions.lb,'upper',CFOptions.ub);
CFFit.perp(ii).t2 = data_file.perp(ii).t2;
CFFit.perp(ii).fitresult =fitresult;
CFFit.perp(ii).gof = gof;
CFFit.perp(ii).fitinfo = fitinfo;
CFFit.perp(ii).area = CFFit.perp(ii).fitresult.a.*CFFit.perp(ii).fitresult.c.*sqrt(pi);
CFFit.perp(ii).area_conf = confint(CFFit.perp(ii).fitresult);
CFFit.perp(ii).area_std = sqrt(((CFFit.perp(ii).area_conf(2,1)-CFFit.perp(ii).fitresult.a).^2)./((CFFit.perp(ii).fitresult.a+...
    CFFit.perp(ii).area_conf(2,3)-CFFit.perp(ii).fitresult.c)./CFFit.perp(ii).fitresult.c).^2);
if flag_plot
figure(ii),clf
hold on
plot(perp(ii).w3,perp(ii).PP,'o')
plot(perp(ii).w3,CFFit.perp(ii).fitresult(perp(ii).w3))
hold off
pause(0.1)
end
end

% for ii = 1:length(iso)
% [fitresult,gof,fitinfo] = fit(iso(ii).w3,iso(ii).PP,CFOptions.fitfcn, 'StartPoint',CFOptions.startpoint,...
%             'lower',CFOptions.lb,'upper',CFOptions.ub);
% CFFit.iso(ii).t2 = data_file.iso(ii).t2;
% CFFit.iso(ii).fitresult =fitresult;
% CFFit.iso(ii).gof = gof;
% CFFit.iso(ii).fitinfo = fitinfo;
% CFFit.iso(ii).area = CFFit.iso(ii).fitresult.a.*CFFit.iso(ii).fitresult.c.*sqrt(pi);
% CFFit.iso(ii).area_conf = confint(CFFit.iso(ii).fitresult);
% CFFit.iso(ii).area_std = sqrt(((CFFit.iso(ii).area_conf(2,1)-CFFit.iso(ii).fitresult.a).^2)./((CFFit.iso(ii).fitresult.a+...
% CFFit.iso(ii).area_conf(2,3)-CFFit.iso(ii).fitresult.c)./CFFit.iso(ii).fitresult.c).^2);
% if flag_plot
% figure(ii),clf
% hold on
% plot(iso(ii).w3,iso(ii).PP,'o')
% plot(iso(ii).w3,CFFit.iso(ii).fitresult(iso(ii).w3))
% hold off
% pause(0.1)
% end
% end
% CFFit.T_K = data_file.T_K;
% CFFit.T_degC = data_file.T_degC;