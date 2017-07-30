function [ x, y, z, smp_x, smp_y, smp_z ] = makeBuilding(four_points, height, density)

%% �ܰ� shape �� �׸��� (for fast)
   
    len_edge1 = norm(four_points(1,:) - four_points(2,:));
    len_edge2 = norm(four_points(2,:) - four_points(3,:));
    len_edge3 = norm(four_points(3,:) - four_points(4,:));
    len_edge4 = norm(four_points(4,:) - four_points(1,:));
    
    num_edge1 = round(len_edge1 * density);
    num_edge2 = round(len_edge2 * density);
    num_edge3 = round(len_edge3 * density);
    num_edge4 = round(len_edge4 * density);
    
    total_2d_num = num_edge1 + num_edge2 + num_edge3 + num_edge4;
    
    x_edge1 = linspace( four_points(1,1), four_points(2,1), num_edge1 );
    x_edge2 = linspace( four_points(2,1), four_points(3,1), num_edge2 );
    x_edge3 = linspace( four_points(3,1), four_points(4,1), num_edge3 );
    x_edge4 = linspace( four_points(4,1), four_points(1,1), num_edge4 );
    y_edge1 = linspace( four_points(1,2), four_points(2,2), num_edge1 );
    y_edge2 = linspace( four_points(2,2), four_points(3,2), num_edge2 );
    y_edge3 = linspace( four_points(3,2), four_points(4,2), num_edge3 );
    y_edge4 = linspace( four_points(4,2), four_points(1,2), num_edge4 );
    
    x_2d = [ x_edge1 x_edge2 x_edge3 x_edge4 ]; 
    y_2d = [ y_edge1 y_edge2 y_edge3 y_edge4 ];

    [row_2d, column_2d] = size(x_2d);
    
    x = repmat(x_2d, 1, height * density);
    y = repmat(y_2d, 1, height * density);
    z = [];
        
    z = [];
    gap = 1 / density ;
    
    for i= 1: (height * density)
        z = [z, (gap * i * ones(1,column_2d))];     

        if i == height * density
           smp_x = x_2d;
           smp_y = y_2d;
           smp_z = gap * i * ones(1,column_2d);
        end
    end

end

