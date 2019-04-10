% [KK,KK_re] = CDF_kurtosis(input,do_pic)

function [KK,KK_re] = CDF_kurtosis(input,do_pic)

    clear('KK','KK_re')
    KK = kurtosis(input);
    sigma = sqrt(fangcha(input));
    input_re = input(abs(input) < 3 * sigma);
    KK_re = kurtosis(input_re);
    sigma_re = sqrt(fangcha(input_re));
    
    
    if do_pic == 1,
        bb = normrnd(nanmean(input_re),sigma_re,1,numel(input_re));
        
        subplot(1,2,1); hold on;
        h = histogram(bb,[-20:0.1:20],'Normalization','pdf');
        set(h,'edgecolor','none')
        h = histogram(input_re,[-20:0.1:20],'Normalization','pdf');
        set(h,'edgecolor','none')
        xlim([-10 10])
        CDF_panel([-10 10 0 0.5],[],[],[],[]);
        legend('Normal','Data','fontsize',16)

        subplot(1,2,2); hold on;   
        x = quantile(input_re,[0.001:0.001:0.999]);
        y = norminv([0.001:0.001:0.999],0,1);
        plot(x,y,'.')
        CDF_panel([-5 5 -5 5],[],[],'Data quantile','Normal quantile');
        set(gca,'xtick',[-5:1:5],'ytick',[-5:1:5])
        plot(x([1 end]),y([1 end]),'--','color',[1 1 1]*.7)
        
    end
end