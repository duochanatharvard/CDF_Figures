% CDF_figure_format_convert(dir_load,type1,type2)
function CDF_figure_format_convert(dir_load,type1,type2,reso)
    %%
    % dir_load = '/Users/zen/Desktop/Code_uniform_warming/Figures/';
    file_name = CDF_filenames(dir_load);
    
    if strcmp(type1,'fig'),
        for i = 1:numel(file_name)
            if strcmp(file_name{i}(end-2:end),type1);
                open(file_name{i})
                file_save = [file_name{i}(1:end-3),type2];
                if strcmp(type2,'png')
                    CDF_save(1,type2,reso,file_save);
                else
                    CDF_save(1,type2,[],file_save);
                end
                close all;
            end
        end
    end
end