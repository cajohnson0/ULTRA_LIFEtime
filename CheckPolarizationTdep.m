function d = CheckPolarizationTdep(data_file,range1,range3,x)
para = sort2DIRdata(data_file.para);
perp = sort2DIRdata(data_file.perp); 

ind1_para = find(para(3).w1<range1(2) & para(3).w1>range1(1));
ind1_perp = find(perp(3).w1<range1(2) & perp(3).w1>range1(1));
ind3_para = find(para(3).w3<range3(2) & para(3).w3>range3(1));
ind3_perp = find(perp(3).w3<range3(2) & perp(3).w3>range3(1));
area_para = abs(sum(sum(para(3).R(ind3_para,ind1_para)))./(length(ind1_para)*length(ind3_para)));
area_perp = abs(sum(sum(perp(3).R(ind3_perp,ind1_perp)))./(length(ind1_perp)*length(ind3_perp)));
d.ratio = area_para./area_perp;
d.ref_x = (d.ratio.*x - 3);
d.trans_y = 1./x;

