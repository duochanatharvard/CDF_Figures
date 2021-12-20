function [lon2,lat2] = CDF_up_hill(lon,lat,reso)

    [~,topo,~] = CDF_land_mask(reso,2,reso,0);  topo = topo';
    H    = grd2pnt(lon,lat,topo,reso,reso);
    H10  = grd2pnt(lon+1,lat,topo,reso,reso);
    H_10 = grd2pnt(lon-1,lat,topo,reso,reso);
    H01  = grd2pnt(lon,lat+1,topo,reso,reso);
    H0_1 = grd2pnt(lon,lat-1,topo,reso,reso);
    G_ew = H10 - H_10;
    G_ns = H01 - H0_1;
    
    [TH,~] = cart2pol(G_ew,G_ns); TH = TH/pi*180;
    
    lon2 = lon;    lat2 = lat;
    
    l = abs(TH)<22.5;
    lon2(l) = lon2(l) + 1 * reso;
    lat2(l) = lat2(l) + 0;

    l = TH>=22.5 & TH <= 67.5;
    lon2(l) = lon2(l) + 1 * reso;
    lat2(l) = lat2(l) + 1 * reso;

    l = TH>67.5 & TH < 112.5;
    lon2(l) = lon2(l) + 0;
    lat2(l) = lat2(l) + 1 * reso;

    l = TH>=112.5 & TH <= 157.5;
    lon2(l) = lon2(l) - 1 * reso;
    lat2(l) = lat2(l) + 1 * reso;

    l = abs(TH)>157.5;
    lon2(l) = lon2(l) - 1 * reso;
    lat2(l) = lat2(l) + 0;

    l = -TH>=22.5 & -TH <= 67.5;
    lon2(l) = lon2(l) + 1 * reso;
    lat2(l) = lat2(l) - 1 * reso;

    l = -TH>67.5 & -TH < 112.5;
    lon2(l) = lon2(l) + 0;
    lat2(l) = lat2(l) - 1 * reso;

    l = -TH>=112.5 & -TH <= 157.5;
    lon2(l) = lon2(l) - 1 * reso;
    lat2(l) = lat2(l) - 1 * reso;
    
    H2    = grd2pnt(lon2,lat2,topo,reso,reso);
    l     = (H2 - H) < 0;
    lon2(l)  = lon(l);
    lat2(l)  = lat(l);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function out_pnts = grd2pnt(in_lon,in_lat,in_grd,reso_x,reso_y)

    in_lon = rem(in_lon + 360*5, 360);
    x = fix(in_lon/reso_x)+1;
    num_x = 360/reso_x;
    x(x>num_x) = x(x>num_x) - num_x;

    in_lat(in_lat>90) = 90;
    in_lat(in_lat<-90) = -90;
    y = fix((in_lat+90)/reso_y) +1;
    num_y = 180/reso_y;
    y(y>num_y) = num_y;

    index = sub2ind(size(in_grd),x,y);
    out_pnts = in_grd (index);
    out_pnts(abs(out_pnts)>1e8) = NaN;

end