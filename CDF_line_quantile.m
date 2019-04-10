function CDF_line_quantile(x,y,col,q_list)

    for i = 1:size(y,2)
        Tab(:,i) = quantile(y(:,i),q_list);
    end
    
    pic = nanmean(y,1);
    
    hold on;
    plot(x,pic,'-','linewi',2,'color',col);
    plot(x,pic,'.','markersize',15,'color',col);  
    
    itv = mode(diff(x)) / 5;
    for i = 1:size(y,2)
        % plot([1 1]*x(i),[Tab(1,i) Tab(2,i)],'-','linewi',1,'color',col);
        % plot([1 1]*x(i) + [-1 1]*itv,[Tab(1,i) Tab(1,i)],'-','linewi',1,'color',col);
        % plot([1 1]*x(i) + [-1 1]*itv,[Tab(2,i) Tab(2,i)],'-','linewi',1,'color',col);
    end
    
    plot(x,Tab(1,:),'-','linewi',1,'color',col);
    plot(x,Tab(2,:),'-','linewi',1,'color',col);
end