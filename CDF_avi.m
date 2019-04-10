% CDF_avi(dir_name,file_name)
% 
% CDF_avi output an avi movie using all the png files in a given folder
% 
% Last update: 2018-09-08

function CDF_avi(dir_name,file_save)
    
    file_name = CDF_filenames(dir_name,'png');
    
    a = imread([dir_name,file_name{1}]);
    try
        data = zeros([size(a),numel(file_name)],'uint8');
        interval = 1;
    catch
        try
            disp('Requires too much memory, swith to lower resolution');
            a = a(1:2:end,1:2:end,:);
            interval = 2;
            data = zeros([size(a),numel(file_name)],'uint8');
        catch
            disp('Requires too much memory, failed ...');
        end
    end
    
    
    for i = 1:numel(file_name)
        if rem(i,100) == 0,
            disp(['Loading the ',num2str(i),'th frame'])
        end
        a = imread([dir_name,file_name{i}]);
        data(:,:,:,i) = a(1:interval:end,1:interval:end,:);
    end
    
    v = VideoWriter(file_save);
    open(v);
    writeVideo(v,data);
    close(v);
end