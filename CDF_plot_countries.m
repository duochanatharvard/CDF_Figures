function CDF_plot_countries(values,countries,color_axis,color_map)

    if ~exist('color_axis','var'), color_axis = [-1 1]; end
    if ~exist('color_map','var'),  color_map = 'b2rCD(10,0);'; end
    color_map = ['col_list = ', color_map];
    
    patch([-360 720 720 -360],[-90 -90 90 90],[1 1 1]*.8);
    CDF_boundaries('color','w');
    
    eval(color_map);
    edges = linspace(color_axis(1),color_axis(end),size(col_list,1)+1);
    for ct = 1:numel(countries)
        if ~isnan(values(ct))
            try
                if values(ct) > color_axis(2)
                    id = size(col_list,1);
                elseif values(ct) < color_axis(1)
                    id = 1;
                else
                    id = discretize(values(ct),edges);
                end
                col = col_list(id,:);
                borders(countries{ct},'edgecolor','k','facecolor',col,'linewi',0.1); 
            catch
                disp('I am here');
            end
        end
    end
    caxis(color_axis);
    colorbar;
end