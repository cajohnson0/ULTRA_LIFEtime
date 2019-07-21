function [Output] = CompressLife(data_file,range1,range3,t2_range)

range_para = [range3(1)+4 range3(2)]
range_perp = [range3(1) range3(2)-4]
para = data_file.para;
para = sort2DIRdata(para);
para = para([t2_range]);
para = cropData(para,range1,range3);
perp = data_file.perp;
perp = sort2DIRdata(perp);
perp = perp([t2_range]);
perp = cropData(perp,range1,range3);
iso = LoadIsotropicData(data_file,range_para,range3); %range_perp,range_perp)
iso = sort2DIRdata(iso);
iso = iso([t2_range]);
iso = cropData(iso,range1,range3);

for ii = 1:length(para)
Output.para(ii).PP = sum(para(ii).R')';
Output.perp(ii).PP = sum(perp(ii).R')';
Output.para(ii).w3 = para(ii).w3;
Output.perp(ii).w3 = perp(ii).w3;
Output.para(ii).t2 = para(ii).t2;
Output.perp(ii).t2 = perp(ii).t2;
Output.iso(ii).PP = sum(iso(ii).R')';
Output.iso(ii).w3 = iso(ii).w3;
Output.iso(ii).t2 = iso(ii).t2;
end
Output.T_K = data_file.T_K;
Output.T_degC = data_file.T_degC;