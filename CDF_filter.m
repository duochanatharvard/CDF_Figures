
function out = CDF_filter(in,target)

    in = in(:)';
    t  = 1:size(in,2);
    
    in_p = interp1(t(~isnan(in)),in(~isnan(in)),t); 
    
    logic_not_nan = ~isnan(in_p);
    
    in_use = in_p(logic_not_nan);
    in_fft = fft(in_use);
    
    in_fft([1]) = 0;
    remove = fix(numel(in_use)/target);     
    in_fft([2:remove+1 end-remove+1:end]) = 0;
    
    in_high = ifft(in_fft);
    in_low  = in_use - in_high;
    
    in_remove = in;
    in_remove(logic_not_nan) = in_low;
    
    out = in - in_remove;
end