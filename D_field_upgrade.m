% 动态场更新
function next_D_field = D_field_upgrade(D_field, COORD, W, outer)
    global X
    global Y
    global r
    global beta
    
    next_D_field = (1-r) * (1-beta) .* D_field;
    N_p = size(COORD,1);
    
    for p = 1:N_p
        if W(p) ~= 5
            next_D_field(COORD(p,1), COORD(p,2)) = next_D_field(COORD(p,1), COORD(p,2)) + 1;
        end
    end
    
    for p = 1:size(outer, 1)
        next_D_field(outer(p,1), outer(p,2)) = next_D_field(outer(p,1), outer(p,2)) + 1;
    end
    
    next_D_field(1,1) = next_D_field(1,1) + beta* (1-r)/2 * (D_field(1,2)+ D_field(2,1));
    next_D_field(X,1) = next_D_field(X,1) + beta* (1-r)/2 * (D_field(X-1,1)+ D_field(X,2));
    next_D_field(1,Y) = next_D_field(1,Y) + beta* (1-r)/2 * (D_field(2,Y)+ D_field(1,Y-1));
    next_D_field(X,Y) = next_D_field(X,Y) + beta* (1-r)/2 * (D_field(X-1,Y)+ D_field(X,Y-1));
    
    for i = 2:X-1
        next_D_field(i,1) = next_D_field(i,1) + beta*(1-r)/3 * (D_field(i-1,1)+D_field(i+1,1)+D_field(i,2));
        next_D_field(i,Y) = next_D_field(i,Y) + beta*(1-r)/3 * (D_field(i-1,Y)+D_field(i+1,Y)+D_field(i,Y-1));
    end
    
    for j = 2:Y-1
        next_D_field(1,j) = next_D_field(1,j) + beta*(1-r)/3 * (D_field(1,j-1)+D_field(1,j+1)+D_field(2,j));
        next_D_field(X,j) = next_D_field(X,j) + beta*(1-r)/3 * (D_field(X,j-1)+D_field(X,j+1)+D_field(X-1,j));
    end
    
    for i = 2:X-1
        for j = 2:Y-1
            next_D_field(i,j) = next_D_field(i,j) + beta*(1-r)/4 * (D_field(i,j-1)+D_field(i,j+1)+D_field(i-1,j)+D_field(i+1,j));
        end
    end
    
    next_D_field = next_D_field ./ sum(sum(next_D_field));
    
end