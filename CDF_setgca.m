% CDF_setgca(mode)
% mode: season, season_annual
function CDF_setgca(mode)
    if strcmp(mode,'season')
        name = {'J','F','M','A','M','J','J','A','S','O','N','D'};
        name = [name name];
        set(gca,'xtick',1:24,'xticklabel',name);
    elseif strcmp(mode,'season_annual')
        set(gca,'xtick',1:13,'xticklabel',{'J','F','M','A','M','J','J','A','S','O','N','D','Annual'});
    end
end