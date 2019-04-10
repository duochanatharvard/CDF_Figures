function CDF_plot_gaussian_ellipsoid(a,b,col,n)
%     a = cmip5_pi(:,2);
%     b = cmip5_pi(:,3);
    mu = [nanmean(a) nanmean(b)];
    a = a - nanmean(a);
    b = b - nanmean(b);
    cov = [nanmean(a.^2) nanmean(a.*b); nanmean(a.*b) nanmean(b.^2)];
    for i = 1:n
        h = plot_gaussian_ellipsoid(mu,cov,i);
        set(h,'color',col,'linewi',2)
    end
end