function myPlotTRMPS(data,range1,range2,range3)
n_levels = 101;

time = data.time;
freq = data.freq;
abs = data.abs;

%have to get rid of duplicate times
[plot_x,ind] = unique(time);
plot_y = freq;
plot_z = abs(:,ind);

ind1 = find(plot_x >= range1(1) & plot_x <= range1(2));
ind2 = find(plot_y >= range2(1) & plot_y <= range2(2));
figure(gcf)
surf(plot_y(ind2),plot_x(ind1),plot_z(ind2,ind1)');
shading flat
view(2)
myCaxis2(range3,n_levels);
map = myMapRGB(n_levels);
colormap(map)

xlabel('\omega / 2\pic')
ylabel('time / ns')
axis tight
