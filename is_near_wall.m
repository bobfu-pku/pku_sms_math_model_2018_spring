% 判断行人A周围是否有墙
function IS = is_near_wall(coord)
    global X
    global Y
    
    % 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
    IS = zeros(4, 1);
        
    if coord(2) == Y
        IS(1) = 1;
    end
    if coord(2) == 1
        IS(2) = 1;
    end
    if coord(1) == X
        IS(3) = 1;
    end
    if coord(1) == 1
        IS(4) = 1;
    end


end