function d = myBaselineTRMPS(d)
% this shoudl be split so the peak roi creation happens in a different
% function. sorry...

for kk = 1:length(d)
    
    
    np = length(d(kk).peaks);
    for jj = 1:np
        
        r = d(kk).peaks(jj).range2;
        rr = [r(1)-10 r(1);r(2) r(2)+10];
        
        range1 = d(kk).peaks(jj).range1;
        ind1 = find(d(kk).time >= range1(1) & d(kk).time <= range1(2));
        nt = length(ind1);
        
        ind2 = find(d(kk).freq >= r(1) & d(kk).freq <= r(2));
        nf = length(ind2);
        
        d(kk).peaks(jj).abs = zeros(nf,nt);
        d(kk).peaks(jj).time = d(kk).time(ind1);
        d(kk).peaks(jj).freq = d(kk).freq(ind2);
        
        
        for i_loop = 1:nt
            ii = ind1(i_loop);
            
            
            ind2 = find(d(kk).freq >= rr(1,1) & d(kk).freq <= rr(1,2));
            ep1 = mean(d(kk).abs(ind2,ii));
            w1 = mean(d(kk).freq(ind2));
            
            ind2 = find(d(kk).freq >= rr(2,1) & d(kk).freq <= rr(2,2));
            ep2 = mean(d(kk).abs(ind2,ii));
            w2 = mean(d(kk).freq(ind2));
            
            origin = w1;
            slope = (ep2-ep1)/(w2-w1); %rise over run
            baseline = slope*(d(kk).freq-origin)+ep1;%m*(x-x0)+b form
            
            
            ind2 = find(d(kk).freq >= r(1) & d(kk).freq <= r(2));
            d(kk).peaks(jj).abs(:,i_loop) =  d(kk).abs(ind2,ii) - baseline(ind2)';
            
        end
        
        
    end
    
end
