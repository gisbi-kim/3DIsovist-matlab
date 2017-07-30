%% Info 
% Writer: Giseop Kim 
% Contact: paulgkim@kaist.ac.kr
% When: 08, July, 2017

tic

% when you save the figure, I recomment the setting parameter 
% - like this: Setttings: Building density=300, Number of pieces = 1440, Sensing limit = 50
% Case 1: Straight road with buildings of arbitrary heights
%% hyperparameters
%map size 
max = 8;
map_size_plus = 0; 

% sensor limit 
sensing_limit = 50;

%building 
density = 100;
height = 2;

%obsever 
ob_density = 3;
ob_draw_size = 30;

%isovist anlaysis 
% num_piece = 1440;
num_piece = 360;
% num_piece = 40;

angle_one_piece = 360/num_piece;
portion = 2.3/5; %start_from_where

%% prepare Buildings represented by 4 points and heights   
%test dataset 1 
% B1 = [1 2; 2 1; 4 4; 2 5];
% B2 = [-1 -1; -1 -3; -3 -3; -3 -1];
% B3 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
% B4 = [2 -0.5; 1 -2; 0.5 -4; 4 -3];

%test dataset 2 
B1 = [1 2; 2 1; 4 4; 2 5];
B2 = [-1 -1; -1 -3; -3 -3; -3 -1];
B3 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
B4 = [0.5 -1.5; 0 -2; 0.7 -3; 1.8 -2];
B5 = [1 0; 1.5 -1; 3 -2; 3.5 -0.5];
B6 = [-1 -4; 2 -4; 3 -5; -1 -5];
B7 = [1 6; 2 7; -3 7; -3 5];

%paper env 1
% B1 = [-1 1; -1 2; -3 2; -3 1];
% B2 = [1 -1; 5 -1; 5 -2; 1 -2];
% B3 = [-1 -1; -4 -1; -4 -2; -1 -2];
% B4 = [-1 1; 2 1; 2 3; -1 3];
% B5 = [-0.7 -1; -0.7 -2; 1 -2; 1 -1];
% B6 = [3.3 1; 4 1; 4 2; 3.3 2];

%paper env 1 - large gap ver
% B1 = [-1 2; -1 3; -3 3; -3 2];
% B2 = [1 -2; 5 -2; 5 -3; 1 -3];
% B3 = [-1 -2; -4 -2; -4 -3; -1 -3];
% B4 = [-1 2; 2 2; 2 3; -1 3];
% B5 = [-0.7 -2; -0.7 -3; 1 -3; 1 -2];
% B6 = [3.3 2; 4 2; 4 3; 3.3 3];

%paper env 2
% B1 = [2 2; 4 2; 4 4; 2 4];
% B2 = [-2 2; -2 4; -4 4; -4 2];
% B3 = [-2 -2; -4 -2; -4 -4; -2 -4];
% B4 = [2 -2; 2 -4; 4 -4; 4 -2];

%paper env 3
% B1 = [1 2; 2 1; 4 4; 2 5];
% B2 = [-1 -1; -1 -3; -3 -3; -3 -1];
% B3 = [-0.5 0.5; -0.5 2; -3 4; -4 1];
% B4 = [0.5 -1.5; 0 -2; 0.7 -3; 1.8 -2];
% B5 = [1 0; 1.5 -1; 3 -2; 3.5 -0.5];
% B6 = [-1 -4; 2 -4; 3 -5; -1 -5];
% B7 = [1 6; 2 7; -3 7; -3 5];


four_points = [];

four_points(:,:,1) = B1;
four_points(:,:,2) = B2;
four_points(:,:,3) = B3;
four_points(:,:,4) = B4;
four_points(:,:,5) = B5;
four_points(:,:,6) = B6;
four_points(:,:,7) = B7;

%% draw buildings 
[x, y, z, smp_x, smp_y, smp_z] = drawBuildings(four_points, height, density);

%% adjustment of window or axis 
setSizeOfWorld(max+map_size_plus, max+map_size_plus, max+map_size_plus);

%% make observer 
%  observer = [-0.4 -0.2 0 ];  
% observer = [0.5 4 0 ];  
% observer = [0 0 0 ];  
% observer = [2 -4 0 ];  
% observer = [-0.3 -3 0 ];  
% observer = [-0.3 -2 0 ]; �̰� Ƥ��. �̰� �ֱ׷����� Ȯ�� �� 

scatter3(observer(1,1),observer(1,2), observer(1,3) , 30 ,'filled', 'square');

%% isovist analysis
sight_limit_points = zeros(3, num_piece);
sight_limit_points_prj = zeros(3, num_piece);

for ith_piece = 1 : size(sight_limit_points,2)
    
    %% inner piece angle point �ӽ� ���� ���� �迭 �ʱ�ȭ  
    ob_x = observer(1,1);
    ob_y = observer(1,2);
    ob_z = observer(1,3);
    
    in_the_piece = [];

    %% piece angle ���� �ִ� point �� �� ������ 
    for i = 1 : size(smp_x,2)
        
        tmp_x = smp_x(1,i);
        tmp_y = smp_y(1,i);
        tmp_z = smp_z(1,i);
        relative_x = tmp_x - ob_x;
        relative_y = tmp_y - ob_y;
        relative_z = tmp_z - ob_z;

        relative_r = norm( [ relative_x,relative_y] );
        relative_theta = getThetaFromXY(relative_x, relative_y);

        if ( angle_one_piece * (ith_piece-1) < relative_theta ...
                 && relative_theta < angle_one_piece * (ith_piece) )
            in_the_piece = [in_the_piece ; tmp_x, tmp_y, tmp_z];
        end
    end
 
    %% piece angle �� ����Ʈ �� ��ǥ �?�� (sight limit ����)
    
    the_sight_limit_point = zeros(1, 3);
    angle = 0;
    length_ob_to_slp = 1000;
    
    % free space �� ��� max �� �Ҵ� (������ �Ÿ��� ����ٰ� �����ϴ� ��) 
    if ( isempty(in_the_piece) )
%          the_sight_limit_point = [ max * cosd(ith_piece*angle_one_piece) + ob_x, max * sind(ith_piece*angle_one_piece) + ob_y, max + ob_z];
          the_sight_limit_point = [ sensing_limit * cosd(ith_piece*angle_one_piece) + ob_x, sensing_limit * sind(ith_piece*angle_one_piece) + ob_y, sensing_limit + ob_z];
    end
    
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
        
         %% ��ǥ �� �Ǻ����� 
%         (���� : ����)  
%         if (tmp_angle > angle)
%             angle = tmp_angle;
%             the_sight_limit_point = [tmp_x, tmp_y, tmp_z];
%         end
        % ��ǥ �� �Ǻ����� (ª������)  
        if (tmp_length < length_ob_to_slp)
            length_ob_to_slp = tmp_length;
            the_sight_limit_point = [tmp_x, tmp_y, tmp_z];
        end

    end
 
   %% SLP ���  
    sight_limit_points(:, ith_piece) = ...
        [the_sight_limit_point(1,1), the_sight_limit_point(1,2), the_sight_limit_point(1,3)];
    
    sight_limit_points_prj(:, ith_piece) = ... 
        [the_sight_limit_point(1,1), the_sight_limit_point(1,2), ob_z];
    
end

%% draw Triangle 
rep_observer_x = repmat(observer(1,1), [1, num_piece]);
rep_observer_y = repmat(observer(1,2), [1, num_piece]);
rep_observer_z = repmat(observer(1,3), [1, num_piece]);

tri_x = [sight_limit_points(1,:); sight_limit_points_prj(1,:); rep_observer_x];
tri_y = [sight_limit_points(2,:); sight_limit_points_prj(2,:); rep_observer_y];
tri_z = [sight_limit_points(3,:); sight_limit_points_prj(3,:); rep_observer_z];
    
patch(tri_x, tri_y, tri_z, 'green')

toc
%% for �����, ����� ���� 
hold off;




