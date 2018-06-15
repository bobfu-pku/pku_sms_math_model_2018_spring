% 描述排斥行为
function [pre_next_COORD, W] = repel(COORD, pre_next_COORD, W)
    global k_r
    global alpha
    global alpha_
    global V_exp
    
    N_p = size(COORD, 1);
    % 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
        
    for p = 1:N_p
        if W(p) == 5
            continue
        end
        
        IS_P = is_near_p(pre_next_COORD(p,:), COORD);
        IS_WALL = is_near_wall(pre_next_COORD(p,:));
        
        if IS_P( W(p) )
            P_repel = k_r * (1-exp(-alpha*V_exp))/(1+exp(-alpha*V_exp));
        elseif IS_WALL( W(p) ) 
            P_repel = k_r * (1-exp(-alpha_*V_exp))/(1+exp(-alpha_*V_exp));
        else
            continue
        end
        
        if rand(1) < P_repel
            pre_next_COORD(p, :) = COORD(p, :);
            W(p) = 5;
        end
        
    end

end