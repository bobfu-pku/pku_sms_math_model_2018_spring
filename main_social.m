%% 初始化
clear 

global X
global Y
global D
global desti
global tau

global A
global B
global k
global K
global A_
global B_
global k_
global K_

global V_EXP


N_init = 50; 

X = 12; Y = 8; 

V_EXP = 2;

D = 1.6; 

NO = (1:N_init)' ; % 行人序号

SIZE = normrnd(50, 3.3, N_init, 1)/2/100; % 行人尺寸

M = normrnd(65, 5, N_init, 1); % 行人质量

COORD = rand_COORD(SIZE); % 行人坐标

F = zeros(N_init, 2); % 行人受力

V = zeros(N_init, 2); % 行人速度

N = rand(N_init, 1)/2; % 行人从众系数

desti = [X/2, Y]; % 目标点

tau = 0.5; 

% 人-人作用力参数
A = 2.1; B = 0.08;
k = 4e4; K = 6e4;

% 人-墙作用力参数
A_ = 10; B_ = 0.3;
k_ = 4e4; K_ = 6e4;



%% 运算
T = 1000; 
delta = 0.0001; % 时间步长
t = 0;

fig = figure(1);
while t < T
    % 判断是否有人逃生（进入以门为直径的半圆内）
    p = 1;
    while p <= size(COORD,1)
        if normest( COORD(p, :)-desti ) < D/2
            
            COORD(p, :) = []; SIZE(p, :) = [];
            V(p, :) = []; F(p, :) = [];
            
            M(p) = []; N(p) = []; NO(p) = [];
            
            continue
        end
        
        p = p + 1;
        
    end
    
    if size(COORD,1) == 0
        break
    end
    
    
    F_self = p_self( COORD, V, M, N );
    F_p2p = p_2_p(COORD, SIZE, V, M);
    F_p2B = p_2_B(COORD, SIZE, V, M);
    
    F = F_self + F_p2p + F_p2B;
    
    V_end = V + F./ M * delta;
    
    for p = 1:size(COORD,1)
        if normest(V_end(p,:)) > 2*V_EXP
            V_end(p,:) = V_end(p,:)/normest(V_end(p,:))* 2*V_EXP;
        end
    end
    
    COORD = COORD + (V + V_end) / 2 * delta;
    
    V = V_end;
    
    t = t + delta;
    
    if mod(round(10000*t),1000) == 0
        delete(fig)
        fig = plot_social(COORD, SIZE, V, NO, F_self);
        pause(0.1)
    end
    
end

t

'the end'
