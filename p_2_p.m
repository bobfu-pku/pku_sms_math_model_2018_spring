% 人-人作用力
function F_p2p = p_2_p(COORD, SIZE, V, M)
    global A
    global B
    global k
    global K
    
    N_p = size(COORD,1);
    F_soc = zeros(N_p, 2);
    F_ph = zeros(N_p, 2);
    
    for p = 1: N_p
        f_soc = zeros(1, 2);
        f_ph = zeros(1, 2);
        
        for q = 1: N_p
            if q == p
                continue
            end
            
            r_ab = SIZE(p)+ SIZE(q);
            d_ab = normest(COORD(p, :)-COORD(q, :));
                
            if d_ab <= B+ r_ab
                n_ab = (COORD(p, :)-COORD(q, :))/d_ab; 
                t_ab = [n_ab(2), -n_ab(1)]; 
                delta_v = (V(q)- V(p))*t_ab; 
                
                f_soc = f_soc+ M(p)* A* exp( (r_ab - d_ab)/B )* n_ab ;
                f_ph = f_ph+ k* relu(r_ab- d_ab)* n_ab+ ...
                    K* relu(r_ab - d_ab)* (delta_v* t_ab')* t_ab;
            end
            
        end
        
        F_soc(p, :) = f_soc;
        F_ph(p, :) = f_ph;
    end
    
    F_p2p = F_soc+ F_ph;

end

    