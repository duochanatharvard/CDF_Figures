function output = CDF_transfer_level(input,level)

    output = nan(size(input));
    for i = 1:numel(level)-1
        output(input>=level(i) & input<level(i+1)) = i;
    end
    output(input<=level(1)) = 1;
    output(input>=level(end)) = numel(level)-1;
end