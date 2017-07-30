%% Info 
% Writer: Giseop Kim 
% Contact: paulgkim@kaist.ac.kr
% When: 08, July, 2017
clear
clc

tic
%% hyperparameters
%map size 
max = 8;
map_size_plus = 0; 

% sensor limit 
sensing_limit = 20;

%building info 
density = 10;
height = 1;

%obsever info 
%  ob_density = 6; ob_draw_size = 100;
 ob_density = 3; ob_draw_size = 250;
%  ob_density = 1.5; ob_draw_size = 1000;
%  ob_density = 1; ob_draw_size = 2000;

%isovist option 
num_piece = 120;
angle_one_piece = 360/num_piece;

start_portion = 0.3; % start from 
%  start_portion = 0.1; %start from 
end_portion = 1;

heat_max = 200; %for 2d isovist 
heat_min = 0;  %for 2d isovist 
% heat_max = 1000; %for only-tri / triangle + hemishpere(limit=20, 10) 
% heat_min = 0;  %for only-tir / triangle + hemishpere(limit=20, 10) 


%% prepare Buildings represented by 4 points and heights   
%test dataset 1 
% B1 = [1 2; 2 1; 4 4; 2 5];
% B2 = [-1 -1; -1 -3; -3 -3; -3 -1];
% B3 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
% B4 = [2 -0.5; 1 -2; 0.5 -4; 4 -3];

%test dataset 2 
% B1 = [1 2; 2 1; 4 4; 2 5];
% B2 = [-1 -1; -1 -3; -3 -3; -3 -1];
% B3 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
% B4 = [0.5 -1.5; 0 -2; 0.7 -3; 1.8 -2];
% B5 = [1 0; 1.5 -1; 3 -2; 3.5 -0.5];
% B6 = [-1 -4; 2 -4; 3 -5; -1 -5];
% B7 = [1 6; 2 7; -3 7; -3 5];

% paper env 1
B1 = [-1 1; -1 2; -3 2; -3 1];
B2 = [1 -1; 5 -1; 5 -2; 1 -2];
B3 = [-1 -1; -4 -1; -4 -2; -1 -2];
B4 = [-1 1; 2 1; 2 3; -1 3];
B5 = [-0.7 -1; -0.7 -2; 1 -2; 1 -1];
B6 = [2.3 1; 4 1; 4 2; 2.3 2];
% B7 = [1 6; 2 7; -3 7; -3 5];

%paper env 2
% B1 = [1 2; 2 1; 4 4; 2 5];
% B2 = [-1 -1; -1 -3; -3 -3; -3 -1];
% B3 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
% B4 = [0.5 -1.5; 0 -2; 0.7 -3; 1.8 -2];
% B5 = [1 0; 1.5 -1; 3 -2; 3.5 -0.5];
% B6 = [-1 -4; 2 -4; 3 -5; -1 -5];
% B7 = [1 6; 2 7; -3 7; -3 5];

%paper env 3
% B7 = [1 2; 2 1; 4 4; 2 5];
% B5 = [-1 -1; -1 -3; -3 -3; -3 -1];
% B4 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
% B6 = [0.5 -1.5; 0 -2; 0.7 -3; 1.8 -2];
% B1 = [1 0; 1.5 -1; 3 -2; 3.5 -0.5];
% B3 = [-1 -4; 2 -4; 3 -5; -1 -5];
% B2 = [1 6; 2 7; -3 7; -3 5];

%% Map integration with buildings 
four_points = [];

four_points(:,:,1) = B1;
four_points(:,:,2) = B2;
four_points(:,:,3) = B3;
four_points(:,:,4) = B4;
four_points(:,:,5) = B5;
four_points(:,:,6) = B6;
% four_points(:,:,7) = B7;

%% Draw buildings 
[x, y, z, smp_x, smp_y, smp_z] = drawBuildings(four_points, height, density);

%% Adjustment of window or axis 
setSizeOfWorld(max+map_size_plus, max+map_size_plus, max+map_size_plus+4);

%% Make Specific one observer and draw
% observer = [-3 0 0 ];  
% observer = [0.5 4 0 ];  
% observer = [0 0 0 ];  
% observer = [2 -4 0 ];  
% observer = [-0.3 -3 0 ];  
% observer = [-0.3 -2 0 ]; 

%scatter3(observer(1,1),observer(1,2), observer(1,3) , 30 ,'MarkerFaceColor',[0 0 0] );

%% Set the Interested Space of observer
% * op1: full
obx = linspace(-max, max, 2*max*ob_density);
oby = linspace(-max, max, 2*max*ob_density);
obz = zeros( size(obx, 1), size(obx, 2) );

% * op2: env1
% obx = linspace(-max, max, 2*max*ob_density);
% oby = linspace(-1, 1, 2*max*ob_density);
% obz = zeros( size(obx, 1), size(obx, 2) );

% * op3: env2
% obx = linspace(-max, max, 2*max*ob_density);
% oby = linspace(-max, max, 2*max*ob_density);
% obz = zeros( size(obx, 1), size(obx, 2) );

% * op4: env3
% obx = linspace(-max, max, 2*max*ob_density);
% oby = linspace(-max, max, 2*max*ob_density);
% obz = zeros( size(obx, 1), size(obx, 2) );

%% Leave only observers which is in the outside of the buildings, and draw them 
% output: ob_list 

ob_list = [];

for i= 1: size(obx, 2)
    for j = 1:size(obx, 2)
        ob_list = [ ob_list ; obx(1,i), oby(1,j), 0 ];
    end
end

in = zeros(size(ob_list,1), 1);
for i=1:size(four_points,3)
    tmp_in = inpolygon(ob_list(:,1), ob_list(:,2), transpose(four_points(:,1,i)), transpose(four_points(:,2,i)));
    in = or(in, tmp_in);
end

%draw observers
initial_color = [1 1 1];
scatter3 ( ob_list(~in,1), ob_list(~in,2), ob_list(~in,3), ob_draw_size, initial_color, 'filled', 's');

%save observers for next step (isovist analysis)
ob_list = [ob_list(~in,1), ob_list(~in,2), ob_list(~in,3)];
ob_color = zeros(size(ob_list));

%% Isovist Analysis
sight_limit_points = zeros(3, num_piece);
sight_limit_point_angles = zeros(1, num_piece); 
sight_limit_point_lengths = zeros(1, num_piece); 
sight_limit_points_prj = zeros(3, num_piece);

% Set the start point 
ob_list_size = size(ob_list, 1);
start_index = round( start_portion * ob_list_size);
end_index = round( end_portion * ob_list_size);

SVV = [];
% for each observer 
for ith_observer= start_index : end_index
    
    SVV_ob = [];
    
    ob_x = ob_list(ith_observer,1);
    ob_y = ob_list(ith_observer,2);
    ob_z = ob_list(ith_observer,3);

%     tic
    % for each pie 
    for ith_piece = 1 : size(sight_limit_points,2)
        
%         in_the_piece = [];
         in_the_piece = [];
        
        % collect all SLP(sight limit point)s in the pie \
        % this for loop need to be fast. using GPU etc. this is the 90% time consuming for loop of the whole.
        for i = 1 : size(smp_x, 2)

            tmp_x = smp_x(1,i);
            tmp_y = smp_y(1,i);
            tmp_z = smp_z(1,i);
            relative_x = tmp_x - ob_x;
            relative_y = tmp_y - ob_y;
            relative_z = tmp_z - ob_z;

            relative_r = norm( [ relative_x,relative_y] );
            relative_theta = getThetaFromXY(relative_x, relative_y); % degree
            
            % criteria 1: in the angle 
            if ( angle_one_piece * (ith_piece-1) < relative_theta ...
                     && relative_theta < angle_one_piece * (ith_piece) )
                 in_the_piece = [in_the_piece ; tmp_x, tmp_y, tmp_z];
            end
       
            % criteria 2: in the sensing limit (TBA)
            %if  
            %end
            
        end

%         t= toc;
%         disp("all smp search time is:");
%         disp(t)

        
       %% find the representative SLP of the pie 
        the_sight_limit_point = zeros(1, 3);
        angle = 0;
        length_ob_to_slp = 1000;

        % if free space (there not exist any in-pie SLP)
        if ( isempty(in_the_piece) )
            the_sight_limit_point = [ max * cosd(ith_piece*angle_one_piece) + ob_x, max * sind(ith_piece*angle_one_piece) + ob_y, max + ob_z];
      
%             tmp_SVV = [];
%             tmp_SVV = [tmp_SVV, ith_observer, angle_one_piece * (ith_piece-1), 45];
% 
%             SVV_ob = [SVV_ob; tmp_SVV];
           
        % else if there exist any SLP points, fine the representative among them.
        else 
            for j = 1: size(in_the_piece,1)
                
                tmp_x = in_the_piece(j, 1);
                tmp_y = in_the_piece(j, 2);
                tmp_z = in_the_piece(j, 3);

                tmp_x_prj = in_the_piece(j, 1);
                tmp_y_prj = in_the_piece(j, 2);
                tmp_z_prj = ob_z;

                vec1 = [tmp_x_prj, tmp_y_prj, tmp_z_prj] - [ob_x, ob_y, ob_z];
                vec2 = [tmp_x, tmp_y, tmp_z] - [ob_x, ob_y, ob_z];

                tmp_length = norm(vec1); % Sight Limit Point (or Sky Meet Point �� �? SLP���ٴ� �� �������ѵ�... �ǹ������δ� �� �������̰�..)
                tmp_angle = radtodeg(atan2(norm(cross(vec1, vec2)), dot(vec1, vec2)));

                % criteria to pick a representative SLP of the pie 
                % current criteria is: shortest from observer. 
                if (tmp_length < length_ob_to_slp)
                    length_ob_to_slp = tmp_length;
                    the_sight_limit_point = [tmp_x, tmp_y, tmp_z];
                end 
                % other criteria is okay (TBA)
                % if 
                % end 
        
            end
        end
              
%         relative_r = norm( [ relative_x,relative_y] );
%         relative_theta = getThetaFromXY(relative_x, relative_y); % degree

        % SLP and its projection point (for drawing triangles)
        sight_limit_points(:, ith_piece) = ...
            [the_sight_limit_point(1,1), the_sight_limit_point(1,2), the_sight_limit_point(1,3)];
        sight_limit_points_prj(:, ith_piece) = ... 
            [the_sight_limit_point(1,1), the_sight_limit_point(1,2), ob_z];
        % SLP angle and SLP length 
        for ith_phi =  1: num_piece
            tmp_x = the_sight_limit_point(1,1);
            tmp_y = the_sight_limit_point(1,2);
            tmp_z = the_sight_limit_point(1,3);
            relative_x = tmp_x - ob_x;
            relative_y = tmp_y - ob_y;
            relative_z = tmp_z - ob_z;

            len_ob_to_SLP = norm( [relative_x, relative_y, relative_z]);
            len_ob_to_SLP_prj = norm( [relative_x, relative_y]) ;
            angle =  180/pi * acos(len_ob_to_SLP_prj/len_ob_to_SLP);
            
            sight_limit_point_angles(ith_piece) = angle;
            sight_limit_point_lengths(ith_piece) = len_ob_to_SLP;
        end
        
    end % end of all pies 
%     t= toc;
%     disp("all pie search time is:");
%     disp(t)

    % metric from l, phi for all pies 
    value = getValueFromSLPs(sight_limit_point_angles, sight_limit_point_lengths);
    disp(value)
    
    % metric to color 
    cur_ob_color = getColorFromValue(value, heat_max, heat_min);
    ob_color(ith_observer, :) = cur_ob_color; 
    % redraw the observer with the designated color 

     %% drawing part 
    % prepare for drawing Triangle 
    rep_observer_x = repmat(ob_list(ith_observer,1), [1, num_piece]);
    rep_observer_y = repmat(ob_list(ith_observer,2), [1, num_piece]);
    rep_observer_z = repmat(ob_list(ith_observer,3), [1, num_piece]);

    tri_x = [sight_limit_points(1,:); sight_limit_points_prj(1,:); rep_observer_x];
    tri_y = [sight_limit_points(2,:); sight_limit_points_prj(2,:); rep_observer_y];
    tri_z = [sight_limit_points(3,:); sight_limit_points_prj(3,:); rep_observer_z];

    %drawing Triangle 
    if( ith_observer > start_index)
        %delete current drawing 
        delete(h1)
    end
 
%       h1 = patch(tri_x, tri_y, tri_z, 'green');
     h1 = [];
    h2 = h1;
    
    %draw observers
    scatter3 ( ob_list(ith_observer,1), ob_list(ith_observer,2), ob_list(ith_observer,3), ob_draw_size, cur_ob_color, 'filled', 's');

    %re-draw 
    drawnow;
 
end
% end of all observers. 

%% hold off 
hold off;

disp("one observer done")
toc




