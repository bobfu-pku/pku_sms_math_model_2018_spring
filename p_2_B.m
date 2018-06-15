% �����ϰ���(barricade)���˵�������
% size Ϊ���˰뾶
% coord Ϊ��������
% m Ϊ��������
% v Ϊ�����ٶ�

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
        
        [d_aB, i] = min(abs([x, y, X-x, Y-y])); %����-ǽ����
        
        if d_aB > B_ + SIZE(p) %������ǽ���÷�Χ֮��
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
        end % n_aBǽָ�����˵ĵ�λ����/t_aB-n_aB������λ����
        
        F_p2B(p, :) = ( M(p)* A_* exp((SIZE(p)- d_aB)/ B_) + k_* relu(SIZE(p)- d_aB) ) * n_aB +...
            K_* relu(SIZE(p)- d_aB)* (V(p, :)* t_aB')* t_aB;
    
    end
    
end


