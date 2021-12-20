% [region_mask_out,region_name] = CDF_region_mask(reso)
function [region_mask_out,region_name_out] = CDF_region_mask(reso)

    % cd /Users/zen/Program/function/
    load weigh.dat
    for i = 1:25
        region_mask(:,:,i) = weigh((i-1)*36+1:i*36,:);
    end
    region_mask(:,:,2) = region_mask(:,:,1) + region_mask(:,:,2);

    % This is to seperate the Greenland from the Eastern Canada
    a = region_mask(:,:,10);
    a(34:36,:) = 0;
    a(:,61:end) = 0;
    region_mask(:,:,23) = a;
    
    a = region_mask(:,:,10);
    a(1:36,1:61) = 0;
    region_mask(:,:,24) = a;
    
    region_mask = region_mask(:,:,[2:9 23 24 11:22]);

    [land_mask,~] = CDF_land_mask(reso,2);
    [lon1,lat1] = meshgrid(reso/2:reso:360,-90+reso/2:reso:90);
    [lon0,lat0] = meshgrid(2.5:5:360,-87.5:5:90);
    
    for i = 1:size(region_mask,3)
        temp = interp2([lon0-360 lon0 lon0+360],[lat0 lat0 lat0],[region_mask(:,:,i) region_mask(:,:,i) region_mask(:,:,i)],lon1,lat1,'linear');
        region_mask_out(:,:,i) = (land_mask > 0 & temp > 0)';
    end
    
    region_name = {'AUS','NSA','SSA','MEX','WNA','CNA','ENA','ALK','ECA','GLD','MID',...
        'NEU','WAF','EAF','SAF','NAF','OCT','EAS','SAS','WAS','CAS','SIB'};
    
    for i = 1:22
        region_name_out(i,:) = region_name{i}; 
    end
end