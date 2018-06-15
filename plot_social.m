% 绘图
function [fig] = plot_social(COORD, SIZE, V, NO, F)
    global X
    global Y
    global desti
    global D
    
    N_p = size(COORD, 1);

    x = 0: 0.1: X; 
    y = 0: 0.1: Y; 
    
    fig = figure(1);

    hold on
    axis equal
    axis([-2 X+2 -2 Y+2])
    set(gcf,'unit','centimeters','position',[1 1 55 35]);
    
    plot(x, zeros(1,size(x,2)) ,'r');
    plot(x, ones(1,size(x,2))*Y ,'r');
    plot(zeros(1,size(y,2)), y ,'r');
    plot(ones(1,size(y,2))*X, y ,'r');

    O_x = zeros(1, 101);
    O_y = zeros(1, 101);
    for i = 1:101
        theta = pi/50*(i-1);
        O_x(i) = cos(theta);
        O_y(i) = sin(theta);
    end

    plot(D/2* O_x(51:end)+ desti(1), D/2* O_y(51:end)+ desti(2), 'g');

    hold on
    axis equal
    for i = 1:N_p
        O = COORD(i, :);
        r = SIZE(i);

        plot(r*O_x+O(1), r*O_y+O(2), 'k');
        text(O(1), O(2), num2str(NO(i)))
    end
    
    % 绘制受力
%     t = 0:0.01:1;
%     F = F/300;
%     for i = 1:N_p
%         O = COORD(i, :);
% 
%         plot(t*F(i,1)+O(1), t*F(i,2)+O(2), 'b');
%     end
    
    % 绘制速度
    t = 0:0.01:1;
    for i = 1:N_p
        O = COORD(i, :);

        plot(t*V(i,1)+O(1), t*V(i,2)+O(2), 'b');
    end

end

