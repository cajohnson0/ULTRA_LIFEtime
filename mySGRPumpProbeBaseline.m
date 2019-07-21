function d = mySGRPumpProbeBaseline(d)
% this shoudl be split so the peak roi creation happens in a different
% function. sorry...

for kk = 1:length(d)
    
        
        r = d(kk).range2;
        rr = [r(1) r(1);r(2) r(2)];
        
%         range1 = d(kk).range1;
%         ind1 = find(d(kk).t2 >= range1(1) & d(kk).t2 <= range1(2));
%         nt = length(ind1);
%         
        ind2 = find(d(kk).freq >= r(1) & d(kk).freq <= r(2));
        nf = length(ind2);
        
        d(kk).data = zeros(nf);%,nt);
%         d(kk).t2 = d(kk).t2(ind1);
        d(kk).freq = d(kk).freq(ind2);
        
 
            
            
            ind2 = find(d(kk).freq >= rr(1,1) & d(kk).freq <= rr(1,2));
            ep1 = mean(d(kk).data(ind2));
            w1 = mean(d(kk).freq(ind2));
            
            ind2 = find(d(kk).freq >= rr(2,1) & d(kk).freq <= rr(2,2));
            ep2 = mean(d(kk).data(ind2));
            w2 = mean(d(kk).freq(ind2));
            
            origin = w1;
            slope = (ep2-ep1)/(w2-w1); %rise over run
            baseline = slope*(d(kk).freq-origin)+ep1;%m*(x-x0)+b form
            
            
            ind2 = find(d(kk).freq >= r(1) & d(kk).freq <= r(2));
            d(kk).data(:) =  d(kk).data(ind2) - baseline(ind2)';
            
 
        
        
    end
end
