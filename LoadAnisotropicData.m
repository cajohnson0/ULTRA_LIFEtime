function d = LoadAnisotropicDataSGR(data_file,range_w1,range_w3)
d = ConstructAniso;

files_para = data_file.para;
files_perp = data_file.perp;
% d = data_file.para.T_K;
% d = data_file.para.T_degC;
range1 = range_w1;
range3 = range_w3;
for ii = 1:length(files_para)
    indpar = find(files_para(ii).w3<range1(2) & files_para(ii).w3>range1(1));
    indperp = find(files_perp(ii).w3<range3(2) & files_perp(ii).w3>range3(1));
    d(ii).R = ((files_para(ii).R(indpar,:) - (files_perp(ii).R(indperp,:)))./...
        (files_para(ii).R(indpar,:) + (2.*files_perp(ii).R(indperp,:))));
    d(ii).w3 = files_para(ii).w3(indpar);
    d(ii).w1 = files_para(ii).w1;
    d(ii).t2 = files_para(ii).t2;
     d(ii).T_K = data_file.T_K;
     d(ii).T_degC = data_file.T_degC;
end
end