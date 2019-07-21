function [CFFit] = TRMPSKineticsExpFit(time,freq,abs,range1,range2,range3,CFoptions)

ind1 = find(time >= range1(1) & time <= range1(2))

for ii = 1:size(range2,1)
    ind2 = find(freq >= range2(ii,1) & freq <= range2(ii,2));
    uh = mean(abs(ind2,ind1));
    %plot(time(ind1), abs(ind2,ind1),'o')
end
% CFoptions.flag_plot = flag_plot;
% flag_plot will later determine if we're going to plot our CLS fits
% against the data that generated them.
CFFit = FcnFitAnisoTRMPSKinetics(time(ind1),uh,CFoptions);
Exp = CFFit.fitresult.a1 .* exp(-time./CFFit.fitresult.t1);
for ii = 1:size(range2,1)
figure(101),clf
plot(time(ind1), uh,'o')
plot(time, Exp)
end
figure(gcf)
set(gca,'Ylim',range3,'TickDir','out')
xlabel('time / ns ')
ylabel('\Delta A / O.D.')
title('blah','Fontsize',24)