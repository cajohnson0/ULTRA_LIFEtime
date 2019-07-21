function d = LoadIsotropicData(data_file,range_para,range_perp)
d = construct2dPP;

files_para = data_file.para;
files_perp = data_file.perp;
range1 = range_para
range3 = range_perp
% d = data_file.T_K;
% d = data_file.T_degC;
for ii = 1:length(files_para)
    indpar = logical(files_para(ii).w3<range1(2) & files_para(ii).w3>range1(1));
    indperp = logical(files_perp(ii).w3<range3(2) & files_perp(ii).w3>range3(1));
    d(ii).R = files_para(ii).R(indpar,:) + 2.*files_perp(ii).R(indperp,:)./3;
    d(ii).w3 = files_para(ii).w3(indpar);
    d(ii).w1 = files_para(ii).w1;
    d(ii).t2 = files_para(ii).t2;
end
end