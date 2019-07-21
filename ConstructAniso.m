function s = ConstructAniso(varargin)
switch nargin
  case 0
    s = struct('t2',[],...
      'area',[],...
      'area_std',[],...
      'T_K',[],...
      'T_degC',[]);
  case 1
    if isa(varargin{1},'struct')
      s = varargin{1};
    else
      error('ConstructAniso wrong argument type');
    end
end
end