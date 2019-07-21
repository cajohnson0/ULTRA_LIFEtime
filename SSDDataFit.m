function [CFFit] = SSDDataFit(data_file,t2,c2,c2_std,tau_rot,CFOptions,Type,Exp)
%Arr = 0
%VFT = Ts or Tg (glass transition temperature)
% CFoptions.flag_plot = flag_plot;
% flag_plot will later determine if we're going to plot our CLS fits
% against the data that generated them.
if strcmp(Type, 'para')
     CFFit = ParaSSDFit(data_file,t2,c2,c2_std,tau_rot,CFOptions,Exp);
    elseif  strcmp(Type, 'perp')
     CFFit = PerpSSDFit(data_file,t2,c2,c2_std,tau_rot,CFOptions,Exp);
    elseif  strcmp(Type, 'iso')
     CFFit = IsoSSDFit(data_file,t2,c2,c2_std,tau_rot,CFOptions,Exp);
    elseif  strcmp(Type, 'global')
     CFFit = GlobalSSDFit(data_file,t2,c2,c2_std,tau_rot,CFOptions,Exp);
end
CFFit.fitresult 
end