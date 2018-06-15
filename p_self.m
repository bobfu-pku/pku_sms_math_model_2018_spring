% 行人自驱力
function F_self = p_self( COORD, V, M, N )
    global desti
    global tau
    global X 
    global Y
    global V_EXP
    
    N_p = size(COORD, 1);
    F_self = zeros(N_p, 2);
    
    rho = N_p/(X*Y);
    v_exp = V_EXP*(1-exp(-1.913*(1/rho-1/5.4)));
    
    for p = 1:N_p
        e = (desti - COORD(p, :))/normest(desti - COORD(p, :));
        
        if normest(sum(V)) == 0
            e_others = zeros(1,2);
        else
            e_others = sum(V)/normest(sum(V));
        end
        
        e_correct = (1-N(p))* e + N(p)* e_others;
        e_correct = e_correct/ normest(e_correct);
        
        F_self(p, :) = M(p)* (v_exp* e_correct - V(p, :))/ tau ;
        
        if sum(sum(isnan(F_self)))>0
            pause
            error('F_self_error');
        end
    end
    
end
    