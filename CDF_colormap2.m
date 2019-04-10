% RGB_out = CDF_colormap2(col,brt,gry,num,random)
% col = n * 2 matrix, where n is the number of hues - linear interpolation
% brt = n * 2 matrix, when n == 1, will be copied to match dim of col
% gry = n * 1 vector, when gry == 1, gray scale, default: n*1 zeros vector
% statiation values are automatically interpolated using a quadratic
% interpolation
% we turn of the randomness in this version

function RGB_out = CDF_colormap2(col,brt,gry,num)

    if size(col,2)==1,         col = [col col];    end
    for ct = 1:size(col,1)
        if (col(ct,1) - col(ct,2)) > 0.5,
            col(ct,1) = col(ct,1) - 1;
        end
        if (col(ct,2) - col(ct,1)) > 0.5,
            col(ct,2) = col(ct,2) - 1;
        end
    end
    
    if size(brt,2)==1,         brt = [brt brt];    end
    if size(brt,1)==1,         brt = repmat(brt,size(col,1),1);    end
    if ~exist('gry','var'),    gry = zeros(size(col,1),1);    end
    gry = gry(:);
    if numel(num) == 1,        num = repmat(num,size(col,1),1);    end
    
    for ct = 1:size(col,1)
        
        if num(ct) == 1,
            col_intp = col(ct,1);
            brt_intp = col(ct,1);
        else
            col_intp = interp1([1 num(ct)],col(ct,:),[1:num(ct)]);
            brt_intp = interp1([1 num(ct)],brt(ct,:),[1:num(ct)]);
        end
        mu = interp1([0 1/12 1/6 1/3 1/2 2/3 5/6 1],[.75 .85 .85 .7 .55 .8 .65 .75],col_intp,'spline');
        a  = 4 * (1-mu);
        gry_intp = a .* (brt_intp - 0.5).^2 + mu;
        if gry(ct) == 1, gry_intp(:) = 0; end

        RGB{ct} = CDF_generate_RGB([col_intp(:) gry_intp(:) brt_intp(:)]);
        
    end
    
    if(size(col,1) == 1)
        RGB_out = RGB{1};
    else
        RGB_out = [flipud(RGB{2}); RGB{1}];      
    end
    
    colormap(gca,RGB_out);

end