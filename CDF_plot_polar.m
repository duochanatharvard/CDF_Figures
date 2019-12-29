% CDF_plot_polar(varagin)
% 
% Inputs:
% 1. amp_list   2.ang_list

function CDF_plot_polar(do_circle,varargin)

    if do_circle == 1,
        x = 0:0.001:2*pi;
    else
        x = pi:0.001:(1.5*pi);
    end
    xx = cos(x);
    yy = sin(x);

    if isempty(varargin)
        amp_list = 1:10;
        ang_list = 0:30:360;
    else
        amp_list = varargin{1}; 
        ang_list = varargin{2}; 
    end
    
    ftsz = 16;
    
    hold on;
    for amp = amp_list
        plot(xx*amp,yy*amp,'-','color',[1 1 1]*.75);
    end
    
    for ang = ang_list(1:end)
        plot([0  cos(ang/180*pi)*max(amp_list)],...
             [0  sin(ang/180*pi)*max(amp_list)],...
             '-','color',[1 1 1]*.75);
         
        if do_circle == 1, 
            text(cos(ang/180*pi)*max(amp_list)*1.13,...
                sin(ang/180*pi)*max(amp_list)*1.13,...
                [num2str(ang/360*24),'hr'],...
                'HorizontalAlignment','center',...
                'VerticalAlignment','middle',...
                'fontsize',ftsz)
        else
            text(cos(ang/180*pi)*max(amp_list)*1.06,...
                sin(ang/180*pi)*max(amp_list)*1.06,...
                [num2str(ang/360*24),'hr'],...
                'HorizontalAlignment','center',...
                'VerticalAlignment','middle',...
                'fontsize',ftsz)
        end
    end

    for amp = amp_list
        if ~ismember(amp,amp_list([1 end])),
            if do_circle == 1,
                text(amp,0,num2str(amp),...
                'HorizontalAlignment', 'center',...
                'VerticalAlignment','middle',...
                'fontsize',ftsz)
            else
                text(- amp,0.01/0.25*amp_list(end),num2str(amp),...
                'HorizontalAlignment', 'center',...
                'VerticalAlignment','middle',...
                'fontsize',ftsz)
            end
        end
    end
    

    if do_circle == 1,
        plot(xx*amp,yy*amp,'-','color',[1 1 1]*0,'linewi',2);
        
        text(-nanmean(amp_list([1 end])),0,'Amplitude (^oC)',...
            'HorizontalAlignment','center',...
            'VerticalAlignment','middle',...
            'fontsize',ftsz)
    else
        plot(xx*amp,yy*amp,'-','color',[1 1 1]*0,'linewi',2);
        plot([0 -amp_list(end)],[0 0],'-','color',[1 1 1]*0,'linewi',2);
        plot([0 0],[0 -amp_list(end)],'-','color',[1 1 1]*0,'linewi',2);
        
        text(-nanmean(amp_list([1 end])),...
            0.028/0.25*amp_list(end),'Amplitude (^oC)',...
            'HorizontalAlignment','center',...
            'VerticalAlignment','middle',...
            'fontsize',ftsz)

        text(-amp_list([end])*1.1/sqrt(2),...
            -amp_list([end])*1.1/sqrt(2),'Local time (hr)',...
            'HorizontalAlignment','center',...
            'VerticalAlignment','middle',...
            'Rotation',-45,'fontsize',ftsz)
    end
    
    axis off;
    daspect([1 1 1])
    
end