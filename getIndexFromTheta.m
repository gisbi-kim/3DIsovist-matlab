function [ index ] = getIndexFromTheta( theta, num_piece )
%GETINDEXFROMTHETA �� �Լ��� ��� ���� ��ġ

    angle_one_piece = 360/num_piece;
    
    quotient = fix( theta/angle_one_piece );
    index = quotient + 1;
end

