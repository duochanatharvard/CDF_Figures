% CDF_cloud(qn,theta,tit)
% 
% CDF_cloud generate a figure for cloud
% 
% Last update: 2018-09-08

function CDF_cloud(qn,theta,tit)

    x = 1:size(qn,1);
    y = 1:size(qn,2);
    z = 1:size(qn,3);

    p_n=patch(isosurface(y,x,z,qn,0.01));
    isonormals(y,x,z,qn,p_n)
    p_n.LineStyle = 'none';
    p_n.FaceColor=[1 1 1]*.7;
    p_n.EdgeColor=[1 1 1]*.7;
    p_n.FaceAlpha=.4;
    
    CDF_pcolor(y,x,theta');
    b2rCD(12);
    caxis([-1 1]*2);
    h1=colorbar('Southoutside');
    ylabel(h1,'theta_\rho (K)')
    set(h1,'color','k','fontsize',15,'fontweight','bold');
    daspect([1 1 2])
    
    axis off;
    plot([0 max(y) max(y) 0 0],[0 0 max(x) max(x) 0],'k-','linewi',2)
    xlim([0 max(y)])
    ylim([0 max(x)])
    zlim([0 96]);

    set(gcf,'color','w')
    set(gcf, 'PaperPositionMode','auto');
    set(gcf,'position',[-3 0 24 14],'unit','inches');
    set(gcf,'position',[-3 0 24 14],'unit','inches');
    title(tit,'color','k','fontsize',18,'fontweight','bold');
    
    view([5 2 2]);

end