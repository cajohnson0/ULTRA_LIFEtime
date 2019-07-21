function myTRMPSFlipbook(data,range1,range2,range3)


ind1 = find(data.time >= range1(1) & data.time <= range1(2));
ind2 = find(data.freq >= range2(1) & data.freq <= range2(2));

abs = data(1).abs(ind2,ind1);
time = data(1).time(ind1);
freq = data(1).freq(ind2);

for ii = 1:length(time)
    plot(freq,abs(:,ii))
    figure(gcf)
    set(gca,'Ylim',range3,'TickDir','out')
    title(sprintf('%16.8f ns ',time(ii)))
    xlabel('\Delta A / O.D.')
    pause
end