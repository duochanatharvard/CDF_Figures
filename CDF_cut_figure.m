% CDF_cut_figure(file_load,file_save,all_color_bar)
% SUM figure first, and then call this function to cut out part you do not
% want ......
function CDF_cut_figure(file_load,file_save,all_color_bar)

    a = imread(file_load);

    if ~exist('file_save','var'),
        file_save = file_load;
    elseif isempty(file_save),
        file_save = file_load;
    end
    
    if ~exist('all_color_bar','var'),
        all_color_bar = 1;
    end

    b = nanmean(a,3);

    % For longitude perfect! 
    c = nanmean(b,1) ~= 255;
    point_list = find((c(1:end-1) == 0 & c(2:end) == 1) | (c(1:end-1) == 1 & c(2:end) == 0));
    figure_list = find(diff(point_list)>900);

    if all_color_bar == 1,
        use_lon = [];
        if numel(figure_list) ~= 1,
            use_lon = point_list(figure_list(1)-2)-50:point_list(figure_list(2)-3)+10;
            for i = 2:numel(figure_list)-1
                use_lon = [use_lon point_list(figure_list(i))-1:point_list(figure_list(i+1)-3)+10];
            end
            use_lon = [use_lon point_list(figure_list(end))-1:point_list(end)+50];
        else
            use_lon = point_list(1)-50:point_list(end)+50;
        end
    else
        use_lon = [];
        use_lon = point_list(figure_list(1)-2)-50:point_list(figure_list(1)+1)+10;
        use_lon = [use_lon point_list(figure_list(2)-2)+[-50:-10]];
        for i = 2:numel(figure_list)-1
            use_lon = [use_lon point_list(figure_list(i))-1:point_list(figure_list(i))+10];
            use_lon = [use_lon point_list(figure_list(i+1)-2)+[-50:-10]];
        end
        use_lon = [use_lon point_list(figure_list(end))-1:point_list(end)+50];
    end
    
    % For latitude perfect!
    c = nanmean(b,2) ~= 255;
    point_list = find((c(1:end-1) == 0 & c(2:end) == 1) | (c(1:end-1) == 1 & c(2:end) == 0));
    figure_list = find(diff(point_list)>200);
    use_lat = [];
    for i = 1:numel(figure_list)
        if i ~= numel(figure_list);
            use_lat = [use_lat point_list(figure_list(i))-20:point_list(figure_list(i)+1)+10];
        else
            use_lat = [use_lat point_list(figure_list(i))-20:point_list(end)+10];
        end
    end
    
    use_lon(use_lon <= 0) = [];
    use_lat(use_lat <= 0) = [];
    pic = a(use_lat,use_lon,:);
    imwrite(pic,file_save);
    
end