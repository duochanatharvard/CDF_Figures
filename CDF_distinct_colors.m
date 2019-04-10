% [col,b] = CDF_distinct_colors
% This function returns the colormaps - col, and a color pallate - b
% US   UK     DE    NL    JP    RU    UK    OT
% 9    14     9     5     6     5     5     4     0
function [col,b] = CDF_distinct_colors



    a = imread('/Users/zen/Program/Figure_Tool_Box_CD//Color_Map.png');
    b = double(a(7:36:end,18:78:end,:))/255;
    
    if all(b(1,1,:) == 1,3), b(1,:,:) = []; end
    % Color for US --------------------------------------------------------
    col{1} = flipud([squeeze(b(4,[1:5],:)); squeeze(b(2,[12:-1:8],:))]);
    % Color for UK --------------------------------------------------------
    col{2} = ([squeeze(b(2,[1:5],:)); squeeze(b(1,[1:5],:)); squeeze(nanmean(b(1:2,[1:5],:),1)); ]);
    [Hue,Str,Brt] = CDF_generate_HSB(col{2});
    col{2} = CDF_generate_RGB([Hue+[-1 -1 -1 -1 -1 0 0 0 0 0 1 1 1 1 1]'*-.02-0.02,Str,Brt],1);
    % Color for DE --------------------------------------------------------
    col{3} = flipud(squeeze(b(3,[7:10 1:5],:)));
    [Hue,Str,Brt] = CDF_generate_HSB(col{3});
    col{3} = CDF_generate_RGB([Hue+[0 0 0 0 0 -1 -1 -1 -1]'*-0.1,Str,Brt+[0 0 0 0 0 -1 -1 -1 -1]'*.05],1);
    % Color for NL --------------------------------------------------------
    col{4} = ([squeeze(b(7,[5:-1:1],:))]);
    [Hue,Str,Brt] = CDF_generate_HSB(col{4});
    col{4} = CDF_generate_RGB([Hue-0.01,Str,Brt+[-2:2]'*-0.03],1);
    % Color for JP --------------------------------------------------------
    col{5} = ([squeeze(b(8,1:3,:)); squeeze(b(8,[9:11],:))]);
    [Hue,Str,Brt] = CDF_generate_HSB(col{5});
    col{5} = CDF_generate_RGB([Hue-0.03,Str,Brt],1);
    % Color for RU --------------------------------------------------------
    col{6} = (squeeze(b(5,1:5,:)));
    [Hue,Str,Brt] = CDF_generate_HSB(col{6});
    col{6} = CDF_generate_RGB([Hue+0.05,Str,Brt-0.2],1);
    % Color for UN --------------------------------------------------------
    col{7} = .5 + (squeeze(b(6,1:5,:)))/2;
    % Color for OT --------------------------------------------------------
    col{8} = flipud(squeeze(b(1,[6 8 10 12],:)));
    
end