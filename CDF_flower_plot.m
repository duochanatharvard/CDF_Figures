function CDF_flower_plot(input,if_fig)

    N = size(input,2)/2; % length of markers
    M = size(input,1);   % size of pairs

    [member_name,~,member_order] = unique([input(:,1:N);input(:,N+1:2*N)],'rows');

    member_order_pairs = [member_order(1:M) member_order(M+1:2*M)];

    [member_order_pairs_unique,~,member_order_pairs_order] = unique(member_order_pairs,'rows');

    for i = 1:size(member_order_pairs_unique,1)
        Time_count(i) = nnz(i == member_order_pairs_order);
    end

    NN = size(member_name,1);

    if if_fig,

        X = sin(linspace(0,2*pi,NN+1));
        Y = cos(linspace(0,2*pi,NN+1));

        figure(100);clf;
        subplot(5,4,[1 2 3 5 6 7 9 10 11 13 14 15]),hold on;

        temp = log10(Time_count);
        wi = fix(temp)*2+1;
        wi(rem(temp,1)>0.698) = wi(rem(temp,1)>0.698) + 1;
        for i = 1:size(member_order_pairs_unique,1)
            plot(X(member_order_pairs_unique(i,:)),Y(member_order_pairs_unique(i,:)),'-','linewi',wi(i),'color',[1 1 1]*.75);
        end
        daspect([1 1 1])

        col = color_shuang([0 1-1/NN],[.5 .5]-0.05,[1 1]-0.1,NN,0);
        plot(X,Y,'.','color',[1 1 1]*.9,'markersize',130);
        for i = 1:NN
            plot(X(i),Y(i),'.','color',col(i,:),'markersize',100);
        end
        set(gcf,'color','w');
        axis off;

        subplot(5,4,[4 8 12 16 20]),hold on;
        plot(zeros(NN,1),[NN:-1:1],'.','color',[1 1 1]*.9,'markersize',100);
        temp_name = member_name(:,1:2);
        temp_name(temp_name == 32) = '*';
        for i = 1:NN
            plot(0,NN-i+1,'.','color',col(i,:),'markersize',70);
            if(N == 4)
                text(0.3,NN-i+1,[char(temp_name(i,:)),' Deck ',num2str(member_name(i,3)),' SID ',num2str(member_name(i,4))],'color','k','fontsize',16,'fontweight','bold');
            elseif(N == 3)
                text(0.3,NN-i+1,[char(temp_name(i,:)),' Deck ',num2str(member_name(i,3))],'color','k','fontsize',16,'fontweight','bold');
            elseif(N == 2)
                text(0.3,NN-i+1,[char(temp_name(i,:))],'color','k','fontsize',16,'fontweight','bold');
            end
        end
        axis off

        subplot(5,4,[17 18 19]);hold on;
        LN = max(wi);
        legend_list ={'    1','  < 10','  < 50','  < 100','  < 500','< 1,000','< 5,000','<10,000','<50,000','<100,000','<500,000','<1,000,000','<5,000,000','<10,000,000','<50,000,000'};
        for i = 1:LN
            ttt = fix((i-0.5)/7);
            ii = rem(i-0.5,7);
            plot([ii*3-3 ii*3-1],[0 0]-ttt,'k-','linewi',i);
            text(ii*3-2.5,-0.4-ttt,legend_list{i},'color','k','fontsize',16,'fontweight','bold');
        end
        axis off

        set(gcf,'position',[1 1 14 10]*1,'unit','inche');
        set(gcf,'position',[1 1 14 10]*1.2,'unit','inche');
        set(gcf, 'PaperPositionMode','auto');
    end
end