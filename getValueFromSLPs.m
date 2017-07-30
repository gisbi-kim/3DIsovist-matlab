function [ value ] = getValueFromSLPs( sight_limit_point_angles, sight_limit_point_lengths )
%GETVALUEFROMSLPS 이 함수의 요약 설명 위치
sensing_limit = 000;

%  mode = "triangle_only"; 
 mode = "2D_isovist"; 
% mode = "triangle+Hemisphere";

num_piece = size(sight_limit_point_angles,2);
one_angle_deg = 360/num_piece;
one_angle_rad = pi/180 * one_angle_deg;

volume_triangles = 0;
area_2d = 0;
volume_hemispheres = 0;

for i = 1:num_piece
    phi_deg = sight_limit_point_angles(i);
    phi_rad = pi/180 * phi_deg;
    len = sight_limit_point_lengths(i);

    h = len * sin(phi_rad);
    r = len * cos(phi_rad);
    w = r * one_angle_rad;
    
    volume_triangles = volume_triangles + (w*h*r*1/3); % Square horn volume
    area_2d = area_2d + (w*r*1/2);

    volume_hemispheres = volume_hemispheres + (sensing_limit * r * sin(1-phi_rad) * 1/2) * w *1/3; % (1/2)absin = triangle 
    
    
end

if (mode == "triangle_only")
    value = volume_triangles;
elseif(mode == "2D_isovist")
    value = area_2d;
elseif (mode == "triangle+Hemisphere")
    value = volume_triangles + volume_hemispheres;
% elseif (mode == "triangle+DirectSky")    
end

end

