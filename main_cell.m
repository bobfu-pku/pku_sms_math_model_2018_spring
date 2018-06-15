%% 主程序
% initialize
clear all
global k_s 
global k_D

global k_r
global alpha
global alpha_

global k_f
global theta
global theta_

global V_exp

global S_field
global r
global beta

global X
global Y
global d
global w

k_r = 0.5; k_f = 0.5; 

theta = 0.1; theta_ = 0.3;

alpha = 1; alpha_ = 1.5;

p = 0.05;
beta = 0.2;
r = 0.2;

V_exp = 2; % 期望速度

N_init = 50; % 初始人数

l = 0.4; % 元胞边长
X = 12/l; Y = 8/l; 

d = 1.6/l; % 出口格点数
D = [ [(X/2-d/2+1):(X/2+d/2)]', Y*ones(d, 1) ]; % 出口位置


%% 计算
% 随机生成行人坐标
NO = (1:N_init)';
p = randperm(X*Y, N_init)';
COORD = [p- X* (ceil(p/X)-1), ceil(p/X)];
% clear p N_init

w = 1.2; % 惯性系数
W = 5 * ones(N_init, 1); % 代表行人方向
% 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
        
% 生成静态场场强
k_s = 1; 
S_field = zeros(X, Y);
for i = 1:X
    for j = 1:Y
    	S_field(i,j) = normest( min(abs(D-[i,j])) );
    end
end
M = max(max(S_field));
S_field = M-S_field;


% 刻画动态场
k_D = 0.1;
D_field = zeros(X, Y);

T = 1000; 
delta = 0.2; 
t = 0;
 
while t<T
    % 判断是否有人离开
    l = 1;
    outer = [];
    while l <= size(COORD,1)
        if sum( ismember(D, COORD(l,:), 'rows') ) == 1
            outer = [outer; COORD(l,:)];
            
            COORD(l,:) = [];
            W(l,:) = [];
            NO(l,:) = [];
            
            continue
        end
        
        l = l+1;
    end
    
    [fig] = plot_cell(COORD, NO);
    
    N_p = size(COORD,1); % 现有人数
    
    if N_p == 0
        break
    end
    

    [next_COORD, W] = next_coord(COORD, W, D_field);
    
    D_field = D_field_upgrade(D_field, COORD, W, outer);
    
    COORD = next_COORD;
    
    pause(1)
    delete(fig)
    
    t = t + delta;
    
end





    





