function [ index ] = getIndexFromTheta( theta, num_piece )
%GETINDEXFROMTHETA 이 함수의 요약 설명 위치

    angle_one_piece = 360/num_piece;
    
    quotient = fix( theta/angle_one_piece );
    index = quotient + 1;
end

