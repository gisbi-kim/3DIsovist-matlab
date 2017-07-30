function [ color ] = getColorFromValue( value, max, min )
%GETCOLORFROMVALUE 이 함수의 요약 설명 위치
%   자세한 설명 위치
    if(value > max)
        r = 1;
        g = 0;
        b = 0;
    elseif(value < min)
        r = 0;
        g = 0;  
        b = 1;    
    else
        r = (value-min)/(max-min);
        g = 0;
        b = 1-r;
    end
    
    color = [ r, g, b];

end

