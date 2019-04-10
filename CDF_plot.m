function CDF_plot(x,y,font,col)

    if ~exist('font','var'); font = 16; end

    hold on;
    plot(x,y,'w.','markersize',1)
    for i = 1:numel(x)
        text(x(i),y(i),num2str(i),'fontsize',font,'fontweight','bold','color',col);
    end
    
    
end