% [Hue,Str,Brt] = CDF_generate_HSB(input)
% Generate the hue, saturation, and brightness of a color given its RGB

function [Hue,Str,Brt] = CDF_generate_HSB(Input)

    if max(Input(:)) > 1,
        Input = double(Input)/255;
    end
 
    zzz = size(Input);
    if zzz(2) ~= 3,
        input = reshape(Input,zzz(1)*zzz(2),3);
    else
        input = Input;
    end
    clear('Input')

    x0 = input(:,1);
    y0 = input(:,2);
    y0(y0 == x0 & x0 >= 0.5) = y0(y0 == x0 & x0 >= 0.5) - 0.0000001;
    y0(y0 == x0 & x0 < 0.5) = y0(y0 == x0 & x0 < 0.5) + 0.0000001;
    z0 = input(:,3);

    a = (y0 - z0)./(x0 - y0);
    b = (z0 - x0)./(x0 - y0); 
    
    % Reversing Brightness ------------------------------------------------
    
    A = [a a+b b b+1 ones(size(a)) a+1 a];
    B = sign(A(:,2:end)) ~= sign(A(:,1:end-1));
     
    bk = nan(size(input,1),1);

    logic_1 = B(:,1) == 1;
    logic_2 = B(:,2) == 1;
    logic_3 = B(:,3) == 1;
    
    bk_1 = x0 + z0 - 1;
    bk_2 = y0 + z0 - 1;
    bk_3 = x0 + y0 - 1; 
    
    bk(logic_1) = bk_1(logic_1);
    bk(logic_2) = bk_2(logic_2);
    bk(logic_3) = bk_3(logic_3);
    
    k = nan(size(input,1),1);
  
    logic = logic_1 & bk <= 0;
    k(logic) = 1./ (x0(logic) + z0(logic));

    logic = logic_2 & bk <= 0;
    k(logic) = 1./ (y0(logic) + z0(logic));

    logic = logic_3 & bk <= 0;
    k(logic) = 1./ (x0(logic) + y0(logic));
    
    logic = logic_1 & bk > 0;
    k(logic) = -1./ (x0(logic) + z0(logic) -2);

    logic = logic_2 & bk > 0;
    k(logic) = -1./ (y0(logic) + z0(logic) -2);

    logic = logic_3 & bk > 0;
    k(logic) = -1./ (x0(logic) + y0(logic) -2);
    
    k(isnan(k)) = 100000000000000000000;
    
    Brt = 1*(k-1)./k .* (double(bk >= 0) -.5) + 0.5;
    
    % Reversing Hue -------------------------------------------------------
    
    Hue = nan(size(input,1),1);

    x1 = nan(size(input,1),1);
    y1 = nan(size(input,1),1);
    z1 = nan(size(input,1),1);
    
    x1(bk <= 0) = k(bk <= 0) .* x0(bk <= 0);
    y1(bk <= 0) = k(bk <= 0) .* y0(bk <= 0);
    z1(bk <= 0) = k(bk <= 0) .* z0(bk <= 0);
    
    x1(bk > 0) = k(bk > 0) .* (x0(bk > 0) - 1) + 1;
    y1(bk > 0) = k(bk > 0) .* (y0(bk > 0) - 1) + 1;
    z1(bk > 0) = k(bk > 0) .* (z0(bk > 0) - 1) + 1;
    
    k = nan(size(input,1),1);
    x2 = nan(size(input,1),1);
    y2 = nan(size(input,1),1);
    z2 = nan(size(input,1),1);
    
    logic = logic_1 & x1 > 0.5;
    k(logic) = 1./ (2*x1(logic) -1);
    y2(logic) = 1/2 + (y1(logic)-1/2).*k(logic);
    Hue(logic) = 0/6 + y2(logic) /6;
    
    logic = logic_1 & x1 <= 0.5;
    k(logic) = -1./ (2*x1(logic) -1);
    y2(logic) = 1/2 + (y1(logic)-1/2).*k(logic);
    Hue(logic) = 3/6 + (1-y2(logic))/6;

    logic = logic_2 & y1 > 0.5;
    k(logic) = 1./ (2*y1(logic) -1);
    x2(logic) = 1/2 + (x1(logic)-1/2).*k(logic);
    Hue(logic) = 1/6 + (1-x2(logic))/6;

    logic = logic_2 & y1 <= 0.5;
    k(logic) = -1./ (2*y1(logic) -1);
    x2(logic) = 1/2 + (x1(logic)-1/2).*k(logic);
    Hue(logic) = 4/6 + x2(logic) /6;

    logic = logic_3 & x1 < 0.5;
    k(logic) = -1./ (2*x1(logic) -1);
    z2(logic) = 1/2 + (z1(logic)-1/2).*k(logic);
    Hue(logic) = 2/6 + z2(logic) /6;

    logic = logic_3 & x1 >= 0.5;
    k(logic) = 1./ (2*x1(logic) -1);
    z2(logic) = 1/2 + (z1(logic)-1/2).*k(logic);
    Hue(logic) = 5/6 + (1-z2(logic))/6;
    
    % Revesing Saturation -------------------------------------------------
    k(isnan(k)) = 100000000000000000000;
    Str = 1./k;
    
    if zzz(2) ~= 3,
        Hue = reshape(Hue,zzz(1),zzz(2));
        Str = reshape(Str,zzz(1),zzz(2));
        Brt = reshape(Brt,zzz(1),zzz(2));
    end
 
end