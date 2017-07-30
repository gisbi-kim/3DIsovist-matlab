function [x y z, smp_x, smp_y, smp_z] = drawBuildings( four_points, height_avg, density )
%DRAWBUILDINGS �� �Լ��� ���?���� ��ġ

    [size1, size2, size3] = size(four_points);
    x = [];
    y = [];
    z = [];
    smp_x = [];
    smp_y = [];
    smp_z = [];

    fig = figure;
    set(fig, 'position', [100 100 900 850])

    for i=1:size3
        [tmp_x, tmp_y, tmp_z, smp_tmp_x, smp_tmp_y, smp_tmp_z] = makeBuilding( four_points(:,:,i), height_avg, density);
        scatter3(tmp_x, tmp_y, tmp_z, 1);
        hold on;
        scatter3(smp_tmp_x, smp_tmp_y, smp_tmp_z, 5);
        hold on;
       
        x = [x tmp_x]; 
        y = [y tmp_y];
        z = [z tmp_z];
        smp_x = [smp_x smp_tmp_x];
        smp_y = [smp_y smp_tmp_y];
        smp_z = [smp_z smp_tmp_z];
        
        hold on;
        height_avg = height_avg + 2;
    end

end

