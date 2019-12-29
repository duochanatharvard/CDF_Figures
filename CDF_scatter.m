% [out_st,out_col] = CDF_scatter(x,y,n2)
% n2: how many stype of points do you want?
% 
% Customizable input argument:
%  - "edgecol":  color of edge                         default: 'k'
%  - "linewi":   width of width                        default: 2
%  - "mksize":   markersize                            default: 10
% 
%
% Last update: 2018-08-20 

function [out_st,out_col] = CDF_scatter(x,y,n2,varargin)

    % *********************************************************************
    % Parse input argument
    % ********************************************************************* 
    if numel(varargin) == 1,
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
    % Assign Parameters
    % *********************************************************************    
    if nnz(ismember(para(:,1),'edgecol')) == 0,
        edgecol = 'k';
    else
        edgecol = para{ismember(para(:,1),'edgecol'),2};
    end

    if nnz(ismember(para(:,1),'linewi')) == 0,
        linewi = 2;
    else
        linewi = para{ismember(para(:,1),'linewi'),2};
    end

    if nnz(ismember(para(:,1),'mksize')) == 0,
        mksize = 10;  mk_flag = 1;
    else
        mksize = para{ismember(para(:,1),'mksize'),2};  mk_flag = 2;
    end
 

    % *********************************************************************
    % Generate figures
    % *********************************************************************

    n1 = max(size(x));
    if n2 ~= 1,
        [out_st,out_col] = CDF_linest(n1,n2);
    else
        out_st  = repmat('o',1,numel(x));
        out_col = distinguishable_colors(numel(x));
    end
    
    hold on;
    for i = 1:n1
        if numel(mksize) == 1,
            plot(x(i),y(i),out_st(i),'color',edgecol,...
                'markerfacecolor',out_col(i,:),...
                'markersize',mksize,'linewi',linewi);
        else
            plot(x(i),y(i),out_st(i),'color',edgecol,...
                'markerfacecolor',out_col(i,:),...
                'markersize',mksize(i,:),'linewi',linewi);
        end
    end
end
