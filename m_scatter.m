function han = m_scatter(varargin)

% M_SCATTER Plot objects on an M_MAP plot.   All of the normal
% Matlab plot options are available.  NOTE - this isn't exactly
% like plot as only the first two arguments are actually converted
% to map coords, i.e.:
%
% USAGE: M_SCATTER(LON,LAT,[OPTIONS])
%

% Duo CHAN, duochan@g.harvard.edu 17/05/18 (v1.1)
%
% This software is provided "as is" without warranty of any kind.

global MAP_PROJECTION

if isempty(MAP_PROJECTION),
    disp('No Map Projection initialized - call M_PROJ first!');
    return;
end;

if nargin < 2;
    help m_scatter
    return
end

[x,y] = m_ll2xy(varargin{1},varargin{2});
varargin = varargin(:);
s = size(varargin,1);
if numel(varargin)==5
    h = scatter(x,y,varargin{3},varargin{4},varargin{5});
elseif numel(varargin)==4
    h = scatter(x,y,varargin{3},varargin{4});
else
    h = scatter(x,y,varargin{3},varargin{4});
    if numel(varargin)>=5,
        set(h,varargin{5:s});
    end
end


if nargout == 1
    han = h;
end

return
