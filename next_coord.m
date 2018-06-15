% 生成下一步坐标
function [next_COORD, W] = next_coord(COORD, W, D_field)
    global k_s 
    global k_D
    global S_field
    global w
    
    
    N_p = size(COORD,1);
    pre_next_COORD = zeros(N_p, 2);
    
    for p = 1:N_p
        now_coord = COORD(p, :);
        % 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
        P = ones(5,1);
        
        near_coord = now_coord + [[0,1];[0,-1];[1,0];[-1,0];[0,0]];
        
        P(5) = exp( k_s* S_field(now_coord(1), now_coord(2)) ) *...
            exp( k_D* D_field(now_coord(1), now_coord(2)) );
        
        IS = is_near_wall(now_coord) + is_near_p(now_coord, COORD);
        
        for k = 1:4

            % �����û��ǽ
            if IS(k) == 1
                P(k) = 0;
                continue
            end
            
            P(k) = exp(k_s*S_field(near_coord(k,1),near_coord(k,2))) *...
                exp(k_D*D_field(near_coord(k,1),near_coord(k,2)));
            
            if W(p) == k
                P(k) = w * P(k);
            end
            
        end

        P = P/sum(P);

        % �������ģ��������һ���ж�������¼���Է���
        epsilon = rand(1);
        for k = 1:5
            epsilon = epsilon - P(k);
            if epsilon <= 0
                W(p) = k;
                break
            end
        end
        
        pre_next_COORD(p, :) = near_coord(k,:);
    end
    
    [pre_next_COORD, W] = repel(COORD, pre_next_COORD, W);
    
    [pre_next_COORD, W] = friction(COORD, pre_next_COORD, W);
    
    [next_COORD, W] = compete(COORD, pre_next_COORD, W);

end






