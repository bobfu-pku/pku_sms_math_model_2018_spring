% 判断行人A周围是否有其他人
function IS = is_near_p(coord, COORD)
    % 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
    
    x = coord(1);
    y = coord(2);
    
    IS = zeros(4, 1);
        
    if sum( ismember(COORD, [x, y+1], 'rows') ) > 0 
        IS(1) = 1;
    end
    if sum( ismember(COORD, [x, y-1], 'rows') ) > 0 
        IS(2) = 1;
    end
    if sum( ismember(COORD, [x+1, y], 'rows') ) > 0 
        IS(3) = 1;
    end
    if sum( ismember(COORD, [x-1, y], 'rows') ) > 0 
        IS(4) = 1;
    end

end