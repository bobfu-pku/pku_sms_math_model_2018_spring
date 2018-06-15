% 描述摩擦行为
function [pre_next_COORD, W] = friction(COORD, pre_next_COORD, W)

    global k_f
    global theta
    global theta_
    global V_exp
    
    N_p = size(COORD, 1);
    % 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
        
    for p = 1:N_p
        if W(p) == 5
            continue
        end
        
        IS_P = is_near_p(COORD(p,:), COORD);
        IS_WALL = is_near_wall(COORD(p,:));
        
        P_fric = 0;
        if W(p) == 1 || W(p) == 2
            if sum(IS_P(3:4)) > 0 
                P_fric = P_fric + k_f * theta * V_exp;
            end
            if sum(IS_WALL(3:4)) > 0
                P_fric = P_fric + k_f * theta_ * V_exp;
            end
        else
            if sum(IS_P(1:2)) > 0 
                P_fric = P_fric + k_f * theta * V_exp;
            end
            if sum(IS_WALL(1:2)) > 0
                P_fric = P_fric + k_f * theta_ * V_exp;
            end
        end
            
        if rand(1) < P_fric
            pre_next_COORD(p, :) = COORD(p, :);
            W(p) = 5;
        end

    end

end

