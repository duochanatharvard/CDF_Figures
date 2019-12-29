% CDF_scatter_fit(x,y,x_rnd,y_rnd,N)
% This function defaultly compute york fit in the first dimension
% make sure that input x and y are Nx1 vectors
% P.x_pic
% P.n_sigma 
% P.linewi
% P.mksiz
% P.report
% P.x_text
% P.fontsize

function [slope_NH, slope_member_NH, out_st,out_col] = CDF_scatter_fit(x,y,x_rnd,y_rnd,N,ll,P)

    P.mute_output = 1;

    if any(size(x_rnd) == 1),
        sigma_x = x_rnd;
        sigma_y = y_rnd;
    else
        dim = 2;
        sigma_x = CDC_std(x_rnd,dim);
        sigma_y = CDC_std(y_rnd,dim);
    end
    
    n_sigma = 1;
    if isfield(P,'n_sigma'),
        if ~isempty(P.n_sigma),
            n_sigma = P.n_sigma;
        end
    end

    linewi = 1;
    if isfield(P,'linewi'),
        if ~isempty(P.linewi),
            linewi = P.linewi;
        end
    end
    
    mksiz = 10;
    if isfield(P,'mksiz'),
        if ~isempty(P.mksiz),
            mksiz = P.mksiz;
        end
    end  

    report = 1;
    if isfield(P,'report'),
        if ~isempty(P.report),
            report = P.report;
        end
    end   

    fontsize = 14;
    if isfield(P,'fontsize'),
        if ~isempty(P.fontsize),
            fontsize = P.fontsize;
        end
    end   

    if ~exist('ll','var'),
        ll = true(size(x));
    end
    
    if isempty(ll),
        ll = true(size(x));
    end
    
    [slope_NH, inter_NH, slope_member_NH, inter_member_NH] =  ...
        CDC_yorkfit_bt(y(ll),x(ll),sigma_y(ll),sigma_x(ll),0,1,N,P);
    
    % Plot York fit
    [slope_member_NH,I] = sort(slope_member_NH);
    inter_member_NH = inter_member_NH(I);
    x1_pic = -10;    
    x2_pic = 10;
    if isfield(P,'x_pic'),
        if ~isempty(P.x_pic),
            x1_pic = P.x_pic(1);
            x2_pic = P.x_pic(2);
        end
    end
    for i = round(0.25*N):round(0.75*N)
        plot([x1_pic x2_pic],[x1_pic x2_pic]*slope_member_NH(i)+inter_member_NH(i),...
            '-','linewi',2,'color',[1 1 1]*.85)
    end
    plot([x1_pic x2_pic],[x1_pic x2_pic]*slope_NH+inter_NH,'w-','linewi',4)
    plot([x1_pic x2_pic],[x1_pic x2_pic]*slope_NH+inter_NH,'r-','linewi',2)


    if report == 1,
        texts = [num2str(slope_NH,'%6.2f'),' ~ [',...
            num2str(quantile(slope_member_NH,[0.25 0.75]),'%6.2f'),']'];
        disp(texts)
        x_text = -10;
        y_text = 10;
        if isfield(P,'x_text'),
            if ~isempty(P.x_text),
                x_text = P.x_text(1);
                y_text = P.x_text(2);
            end
        end
        text(x_text,y_text,texts,'fontsize',fontsize,'fontweight','bold')
    else
        disp([num2str(slope_NH,'%6.2f'),'\pm',...
            num2str(CDC_std(slope_member_NH)*n_sigma,'%6.2f')])
        disp(['Correlation: ',num2str(CDC_corr(y(ll),x(ll)),'%6.2f')])
    end
    

    % plot points
    for i = 1:numel(x)
        plot(x(i) + [-1 1]*sigma_x(i)*n_sigma , y(i) * [1 1],'-','color',[1 1 1]*.3);
        plot(x(i) * [1 1] , [-1 1]*sigma_y(i)*n_sigma + y(i),'-','color',[1 1 1]*.3);
    end
    
    [out_st,out_col] = CDF_scatter(x(:),y(:),6,'mksize',mksiz,'edgecol','k','linewi',linewi);
end