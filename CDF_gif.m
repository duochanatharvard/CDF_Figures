% CDF_gif(dir_name,file_save,dt)
% 
% CDF_gif output an gif figure using all the png files in a given folder
% 
% Last update: 2018-09-08

function CDF_gif(dir_name,file_save,dt)

    cd(dir_name)
    file_name = CDF_filenames(dir_name,'png');

    for t = 1:numel(file_name)
        clear('pic')
        pic = imread(file_name{t});

        Img = pic;
        [I,map] = rgb2ind(Img,256);
        if t==1;
            imwrite(I,map,file_save,'gif','Loopcount',inf,'DelayTime',dt); 
        else
            imwrite(I,map,file_save,'gif','WriteMode','append','DelayTime',dt);
        end
    end
end