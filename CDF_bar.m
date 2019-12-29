function CDF_bar(x,y,ref,col)

    d = mode(x(2:end)-x(1:end-1));
    
    if ~exist('ref','var'),
        ref = 0;
    end
    
    if ~exist('col','var'),
        col = flipud(lines(2));
    end

    hold on;
    for ct = 1:numel(x)
        if y(ct)>0,
            patch([0 1 1 0]*d+x(ct)-d/2,...
                [0 0 1 1]*y(ct)+ref,col(1,:),'linest','none');
        else
            patch([0 1 1 0]*d+x(ct)-d/2,...
                [0 0 1 1]*y(ct)+ref,col(2,:),'linest','none');
        end
    end
    
    plot(x,y*0+ref,'k-','linewi',1)

end