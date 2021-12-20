function CDF_plot_intercompare(M,groups,col,varargin)

    % *********************************************************************
    % Parse input argument
    % ********************************************************************* 
    if numel(varargin) == 1
        varargin = varargin{1};
    end
    para = reshape(varargin(:),2,numel(varargin)/2)';
    for ct = 1 : size(para,1)
        temp = para{ct,1};
        temp = lower(temp);
        temp(temp == '_') = [];
        para{ct,1} = temp;
    end


    if size(M,1) ~= size(M,2)
        % you want to compute a connection, 
        % but this function is not included in the current version!
    end

    N_grp = size(M,1);
    line_wi = 3;
    
    % Set location of individual groups -----------------------------------
    X = sin(linspace(0,2*pi,N_grp+1));
    Y = cos(linspace(0,2*pi,N_grp+1));

    f = gcf;    hold on;
    % Plot connections ----------------------------------------------------
    r = 0.15;
    for i = 1:N_grp
        for j = i:N_grp
            
            if M(i,j) > 0
                if i ~= j
                    % wi  = log10(M(i,j))/100;
                    wi  = M(i,j)/.5e8;
                    L   = sqrt((Y(j)-Y(i))^2 + (X(j)-X(i))^2);
                    dx  = - wi * (Y(j)-Y(i)) / L;
                    dy  =   wi * (X(j)-X(i)) / L;
                    x   = [X(i)+dx  X(i)-dx  X(j)-dx  X(j)+dx];
                    y   = [Y(i)+dy  Y(i)-dy  Y(j)-dy  Y(j)+dy];
                    patch(x,y,[1 1 1]*.75,'linest','none')
%                     plot(X([i j]),Y([i j]),'-',...
%                         'linewi',fix(log10(M(i,j)) * line_wi) + 1,...
%                         'color',[1 1 1]*.75);
                else
                    % wi  = log10(M(i,j))/100;
                    wi  = M(i,j)/.5e8;
                    c_x = X(i) * (1 + r);
                    c_y = Y(i) * (1 + r);
                    x_o = (r + wi) * sin(0:pi/100:2*pi) + c_x;
                    x_i = (r - wi) * sin(0:pi/100:2*pi) + c_x;
                    y_o = (r + wi) * cos(0:pi/100:2*pi) + c_y;
                    y_i = (r - wi) * cos(0:pi/100:2*pi) + c_y;
                    patch([x_i fliplr(x_o)],[y_i fliplr(y_o)],[1 1 1]*.75,'linest','none')
%                     plot(r * sin(0:0.01:2*pi) + X(i) * (1 + r),...
%                         r * cos(0:0.01:2*pi) + Y(j) * (1 + r),...
%                         'linewi',fix() * line_wi) + 1,...
%                         'color',[1 1 1]*.75);
                end
            end
        end
    end
    daspect([1 1 1])
    axis([-1.5 1.5 -1.5 1.5])

    % Plot groups ---------------------------------------------------------
    plot(X,Y,'.','color',[1 1 1]*.9,'markersize',130);
    for ct = 1:N_grp
        plot(X(ct),Y(ct),'.','color',col(ct,:),'markersize',100);
    end
    set(gcf,'color','w');
    axis off;
    
    set(gcf,'position',[10 15 8 8],'unit','inches');
    set(gcf,'position',[10 15 7 7],'unit','inches');
    
    % Plot legends --------------------------------------------------------
    figure(100); clf; hold on;
    ct_pic = 0;
    for ct = [1e5 1e6 2e6 3e6]
        % wi = fix(log10(ct) * line_wi) + 1;
        % plot([0.3 .8],0.2*[1 1]*log10(ct),'linewi',wi,'color',[1 1 1]*.75);
        % wi  = log10(ct)/100;
        
        ct_pic = ct_pic + 1;
        
        wi  = ct/.5e8;
        x   = [.3 .8 .8 .3];
        y   = [-wi -wi wi wi] + 0.2 * [1 1 1 1]*ct_pic;
        patch(x,y,[1 1 1]*.75,'linest','none');
        a = ct ./ 10.^(fix(log10(ct)));
        text(0.9,0.2*ct_pic + 0.04,[num2str(a),'x10^',num2str(fix(log10(ct)))],'fontsize',20,'fontweight','bold')
    end
    axis([-1.5 1.5 -1.5 1.5]+0.8)
    daspect([1 1 1])
    set(gcf,'position',[10 15 8 8],'unit','inches');
    set(gcf,'position',[10 15 7 7],'unit','inches');
    axis off;
    
    figure(f);
    
end