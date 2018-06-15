% 计算障碍物(barricade)对人的作用力
% size 为行人半径
% coord 为行人坐标
% m 为行人质量
% v 为行人速度

function F_p2B = p_2_B(COORD, SIZE, V, M)
    global X
    global Y
    global A_
    global B_
    global k_
    global K_

    N_p = size(COORD,1);
    F_p2B = zeros(N_p, 2);
    
    for p = 1:N_p
        x = COORD(p, 1);
        y = COORD(p, 2);
        
        [d_aB, i] = min(abs([x, y, X-x, Y-y])); %行人-墙距离
        
        if d_aB > B_ + SIZE(p) %行人在墙作用范围之外
            F_p2B(p, :) = zeros(1, 2);
            continue
        end
        
        switch i
            case {1}
                n_aB = [1, 0];
                t_aB = [0, 1];
            case {2}
                n_aB = [0, 1];
                t_aB = [1, 0];
            case {3}
                n_aB = [-1, 0];
                t_aB = [0, 1];
            case {4}
                n_aB = [0, -1];
                t_aB = [1, 0];
        end % n_aB墙指向行人的单位向量/t_aB-n_aB的切向单位向量
        
        F_p2B(p, :) = ( M(p)* A_* exp((SIZE(p)- d_aB)/ B_) + k_* relu(SIZE(p)- d_aB) ) * n_aB +...
            K_* relu(SIZE(p)- d_aB)* (V(p, :)* t_aB')* t_aB;
    
    end
    
end


