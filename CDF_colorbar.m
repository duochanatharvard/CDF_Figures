% CDF_colorbar(colors,xtick,xtickname,xlabel,direction,fs)
% >> direction : 1 - horizonal
%                else - vertical

function CDF_colorbar(col,xtick,xtickname,xname,direction,fs)

    if ~exist('fs','var'),
        fs = 18;
    end

    hold on;
    if direction == 1 || strcmp(direction,'h'),
        for i = 1:size(col,1)
            patch([0 1 1 0]+i,[0 0 1 1],col(i,:));
        end
        plot([0 i+1 i+1 0],[0 0 1 1],'k-','linewi',2);
        set(gca,'xtick',xtick,'xticklabel',xtickname,'ytick',[],'fontsize',fs,'fontweight','bold')
        xlabel(gca,xname,'fontsize',fs,'fontweight','bold')
        axis([1 i+1.000001 0 1])
        set(gcf,'position',[3 3 12 1.1],'unit','inches')
        set(gcf,'position',[3 3 12 1.1],'unit','inches')
    else
        for i = 1:size(col,1)
            patch([0 1 1 0],[0 0 1 1]+i,col(i,:));
        end
        plot([0 1 1 0],[0 0 i+1 i+1],'k-','linewi',2);
        set(gca,'ytick',xtick,'yticklabel',xtickname,'xtick',[],'fontsize',fs,'fontweight','bold')
        ylabel(gca,xname,'fontsize',fs,'fontweight','bold')
        axis([0 1 1 i+1.0000001])
        ax = gca;
        ax.YAxisLocation = 'right';
        set(gcf,'position',[3 3 1.2 10],'unit','inches')
        set(gcf,'position',[3 3 1.2 10],'unit','inches')
    end

    set(gcf, 'PaperPositionMode','auto');
    set(gcf,'color','w');
end 