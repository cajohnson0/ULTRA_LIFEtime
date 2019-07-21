function s = CalcAnisotropicArea(data_file,range1, range3);
s = ConstructAniso;

for ii = 1:length(data_file)
    ind1 = find(data_file(ii).w1<range1(2) & data_file(ii).w1>range1(1));
    ind3 = find(data_file(ii).w3<range3(2) & data_file(ii).w3>range3(1));
    s(ii).t2 = data_file(ii).t2;
    s(ii).area = sum(nansum(data_file(ii).R(ind3,ind1)))/(length(ind1)*length(ind3));
    A = data_file(ii).R(ind3,ind1);
    s(ii).area_std = nanstd(A(:));
    s(ii).T_K = data_file.T_K;
    s(ii).T_degC = data_file.T_degC;
end
end

