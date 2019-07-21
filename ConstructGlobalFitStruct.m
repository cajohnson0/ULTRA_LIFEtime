function s = ConstructGlobalFitStruct(varargin)
switch nargin
  case 0
    s = struct('dataMat',[],...
      'RESULTS',[])
  case 1
    if isa(varargin{1},'struct')
      s = varargin{1};
    else
      error('ConstructAniso wrong argument type');
    end
end
end