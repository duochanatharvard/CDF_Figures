% CDF_box(x,y,varargin)
%
% linewi
% color
% barwi
 
function CDF_box(x,y,varargin)

    % *********************************************************************
    % Parse input argument
    % ********************************************************************* 
    if numel(varargin) == 1
        varargin = varargin{1};
    end
    para = reshape(varargin(:),2,numel(varargin)/2)';
    for ct = 1 : size(para,1)
        temp = para{ct,1};
        temp = lower(temp);
        temp(temp == '_') = [];
        para{ct,1} = temp;
    end

    % *********************************************************************
    % Assign parameters
    % ********************************************************************* 
    if nnz(ismember(para(:,1),'linewi')) == 0
        line_wi = 1.5;
    else
        line_wi = para{ismember(para(:,1),'linewi'),2};
    end

    if nnz(ismember(para(:,1),'color')) == 0
        color = [0 0 0];
    else
        color = para{ismember(para(:,1),'color'),2};
    end

    if nnz(ismember(para(:,1),'barwi')) == 0
        barwi = .3;
    else
        barwi = para{ismember(para(:,1),'barwi'),2};
    end
    
    % *********************************************************************
    % Compute quantiles
    % ********************************************************************* 
    E   = [min(y)  max(y)];
    Q   = quantile(y,[.25 .5 .75]);
    IQR = Q(3) - Q(1);
    M   = nanmean(y);
    O   = [];
    Rng = [Q(1)-1.5*IQR,  Q(3)+1.5*IQR];
    % Rng = quantile(y,[.025 .975]);
    if E(1) > Rng(1) 
        Rng(1) = E(1);
    else
        O = [O; y(y < Rng(1))];
    end

    if E(2) < Rng(2) 
        Rng(2) = E(2);
    else
        O = [O; y(y > Rng(2))];
    end
    
    % *********************************************************************
    % Generate the plot
    % ********************************************************************* 
    hold on;
    col_mid   = color * .75 + .25;
    col_light = color * .5 + .5;
    col_dark  = color * .7;
    plot([-1 1] * barwi + x,[1 1] * Rng(1),'color',col_mid,'linewi',line_wi);
    plot([-1 1] * barwi + x,[1 1] * Rng(2),'color',col_mid,'linewi',line_wi);
    plot([0 0]  * barwi + x,[Rng(1) Q(1)],'color',col_mid,'linewi',line_wi);
    plot([0 0]  * barwi + x,[Rng(2) Q(3)],'color',col_mid,'linewi',line_wi);
    a = patch([-1 1 1 -1] * barwi + x,Q([1 1 3 3]),col_light,'linewi',line_wi,'edgecolor',col_mid);
    alpha(a,.5);
    plot([-1 1] * barwi + x,[1 1] * Q(2),'color',col_dark,'linewi',line_wi+1);
    plot([-1 1] * barwi + x,[1 1] * M,':','color',col_dark,'linewi',line_wi+1);
    if ~isempty(O)
        plot(0+x,O,'+','color',col_light,'linewi',line_wi); 
    end
end