function CDF

    disp('CDF is a Figure toolbox developed by Duo CHAN at Harvard University')
    disp('To run this toolbox, m_map toolbox is suggested')
    disp(' ')
    disp('Last updated: 2018-08-09')
    disp(' ')
    disp('****************************************************************')
    disp('Functions include:')
    disp('****************************************************************')
    disp('Color Bars and Color Schemes:')
    disp('    CDF_generate_RGB')
    disp('    CDF_generate_HSB')
    disp('    CDF_distinct_colors         % Sepecially disgned for the nations')
    disp('    CDF_distinguishable_colors  % Return values are all candy coloes')
    disp('    CDF_colormap                % To substitute color_shuang')
    disp(' ')
    disp('Draw and generating plots:')
    disp('    Draw Dots:')  
    disp('        CDF_linest              % generate list of scatter plot styles % This is only internally called by CDF_scatter')
    disp('        CDF_scatter             % work with CDF_linest to plot colorful scatter plot')
    disp('        CDF_scatter_legend      % work with CDF_scatter to generate the legend') 
    disp(' ')
    disp('    Draw Lines:')    
    disp('        CDF_histplot            % Draw the histogram using a line') 
    disp('        CDF_patch               % Draw the confidence interval as shading')
    disp(' ')
    disp('    Draw Bars:')   
    disp('        CDF_bar_quantile        % To plot the distribution of individual time')
    disp('        CDF_bar_stuck           % Generate plots to stuck bars together [new]')
    disp(' ')
    disp('    Draw Maps:') 
    disp('        CDF_plot_map            % Draw a MAP') 
    disp('        CDF_boundaries          % Draw the coast lines')
    disp('        CDF_transfer_level      % Transfer into irregular interval of colorbar')   
    disp('        CDF_pcolor              % Now support irregular interval')
    disp(' ')
    disp('    Other Figures:') 
    disp('        CDF_flower_plot         % Plot the connection between groups')
    disp('        CDF_cloud               % Plot cloud using QN and Theta')
    disp(' ')
    disp('Set Figure properties: ')
    disp('    CDF_panel                   % Mostly widely used function')
    disp('    CDF_setgca                  % This is just for setting the x axis with years or seasons')
    disp('    CDF_layout                  % To layout the setting of the figure')
    disp('    CDF_cut_figure              % Cut out the white part of a figure')
    disp('    CDF_colorbar                % Plot colorbar')
    disp(' ')
    disp('Set Masks: ')
    disp('    CDF_land_mask               % Returns the landmask at a variety of resolution')
    disp('    CDF_region_mask             % Returns the subcontinental regions according to 2000 paper')
    disp('    CDF_region_ocean_mask       % Returns the subbasin regions according to Chan 2018')
    disp('    CDF_span_mask               % Returns the target mask and spans out for a grid')
    disp(' ' )
    disp('Tables:  ')
    disp('    CDF_Table_latex             % Returns a table that can be directly inserted into latex scripts')
    disp(' ')
    disp('File and Animation:')
    disp('    CDF_filenames               % List all the files in a specific directory')
    disp('    CDF_save                    % Print figures')
    disp('    CDF_avi                     % Combine all the png files in a directory into an avi movie')
    disp('    CDF_gif                     % Combine all the png files in a directory into a gif figure')
    disp('    CDF_figure_format_convert   ')
    disp('    CDF_num2str                 % fill missing potitions with 0')
    disp('    ')
    disp('From other people:')
    disp('    plot_gaussian_ellipsoid     % 2d guassian distribution')
    disp('    m_proj_nml                  % A costumized version')
    disp('    m_scatter                   % Expension of the m_plot')
    disp('    CDF_m_pcolor                % m_pcolor')
    disp(' ')
    disp('Math or Statistics')
    disp('    CDF_kurtosis                % trim the data and return kurtosis')
    disp('    CDF_conf_int                % high dimensional confidence interval')
    disp('    CDF_visual_fitting          % Compute likelihood for linear fit')
    disp(' ')
    disp(' ')
    disp('Some examples of colormap_CD.m:')
    disp('  This function is not in colormap_CD toolbox rather than the current one ')
    disp('  Following examples are listed here for quick reference ... ')
    disp(' ')
    disp('    b2r')
    disp('        col = colormap_CD([ 0.45 0.7; 0.08 0.95],[1 .35],[0 0],6);')
    disp(' ')
    disp('    jet')
    disp('        col = colormap_CD([0.45 0.70; 0.25 0.9],[0.7 0.35],[0 0],6);')
    disp(' ')
    disp('    gry2r')
    disp('        col = colormap_CD([ 0.45 0.7; 0.08  .95],[.95 .35],[1 0],8);')
    disp('        col = col([1:8 10:2:end],:);')
    disp(' ')
    disp('    detail')
    disp('        col = colormap_CD([0 1/6 1/3 2/3 5/6 1]'',[0.9 .35],[0 0 0 0 0 1],5);')

end