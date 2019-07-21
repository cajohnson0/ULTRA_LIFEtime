function varargout=my2dgif(data,range1,range3,filename,varargin)
for ii = 1:length(data)
 
DIR(ii).ind1 = find(data(ii).w1>range1(1) & data(ii).w1<range1(2));
DIR(ii).ind3 = find(data(ii).w3>range3(1) & data(ii).w3<range3(2)); %find the correct range

index1 = data(ii).w1(DIR(ii).ind1); 
index3 = data(ii).w3(DIR(ii).ind3);
DIR(ii).R = data(ii).R(DIR(ii).ind3,DIR(ii).ind1);%cut the matrix into small piecies
figure(101),clf
myonly2dPlot(index1,index3,DIR(ii).R);
title([sprintf('t2: %i fs',data(ii).t2)]);
      drawnow
      frame = getframe(101);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if ii == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1);
      end
    
end