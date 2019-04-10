% out = CDF_span_mask(input)

function out = CDF_span_mask(input)

    clear('out')
    radius = 1;
    X = size(input,1);
    Y = size(input,2);
    
    for i = 1:X
        for j = 1:Y
            x = i-radius : 1: i+radius;
            y = j-radius : 1: j+radius;
            x(x >  X) = x(x >  X) - X;
            x(x <= 0) = x(x <= 0) + X;
            y(y >  Y) = [];
            y(y <= 0) = [];
            temp1 = input(x,j);
            temp2 = input(i,y);
            out(i,j) = any(temp1(:) ~= 0) | any(temp2(:) ~= 0);
        end
    end
end