function myPlotTRMPSKinetics(time,freq,abs,range1,range2,range3)

ind1 = find(time >= range1(1) & time <= range1(2));

for ii = 1:size(range2,1)
    ind2 = find(freq >= range2(ii,1) & freq <= range2(ii,2));
    uh = mean(abs(ind2,ind1));
    %plot(time(ind1), abs(ind2,ind1),'o')
    plot(time(ind1), uh,'o')
end
figure(gcf)
set(gca,'Ylim',range3,'TickDir','out')
xlabel('time / ns ')
ylabel('\Delta A / O.D.')
