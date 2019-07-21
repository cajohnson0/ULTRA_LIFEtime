function out = DSC(temp, heat, range1, range2)
ind = find(temp<=range1(2) & temp>=range1(1),1000); % ind to fit baseline before rise
ind2 = find(temp<=range2(2) & temp>=range2(1),1000); % ind for fit of rise
indnew = find(temp<=range2(2) & temp>=range1(1),1000); % ind to graph intersecion of lines

linear = fittype( @(m, b, x) m.*x+b, 'coeff', {'m',  'b'}, 'indep', {'x'}); 

out.Fit_baseline = fit(temp(ind),heat(ind), linear,'StartPoint', [0 17]);
out.Fit_slope = fit(temp(ind2),heat(ind2), linear,'StartPoint', [-1 17]);
syms x % turns x into a symbol so we can use vpasolve
eqn1 = out.Fit_baseline.m .*x + out.Fit_baseline.b;
eqn2 =  out.Fit_slope.m .*x + out.Fit_slope.b;

eqns = eqn1==eqn2; % set equations to be equal to each other
T = vpasolve(eqns,x); % solves numerically for the temperature, result is a symbol
out.T = double(T); % converts sym x back to precision number

figure(101),clf
hold on
plot(temp(indnew),heat(indnew))
plot(temp(indnew),out.Fit_baseline(temp(indnew)),'r')
plot(temp(indnew),out.Fit_slope(temp(indnew)),'k')
hold off
xlim([range1(1) range2(2)])
%Figure_Settings(gca,gcf)
xlabel('Temp (^{\circ}C)')
ylabel('Heat Flow (mW)')