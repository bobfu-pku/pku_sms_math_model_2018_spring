% 行人坐标随机生成函数
function COORD = rand_COORD(SIZE)
    global X
    global Y
    
    N_p = size(SIZE, 1);
    
    COORD = zeros(N_p, 2);
    
    n = 1;
    while n <= N_p
        x = rand(1) * X;
        y = rand(1) * Y;
        
        is_conflict = 0;
        
        if min([x, y, X-x, Y-y]) < SIZE(n)
            is_conflict = 1;
        end
        
        for i = 1:n-1
            if normest( COORD(i,:)-[x,y] ) < SIZE(i)+SIZE(n)
                is_conflict = 1;
                break
            end
        end
        
        if is_conflict == 1
            continue
        else
            COORD(n,:) = [x, y];
            n = n + 1;
        end
        
    end

end