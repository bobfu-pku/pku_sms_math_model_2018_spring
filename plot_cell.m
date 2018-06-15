% 绘图
function [fig] = plot_cell(COORD, NO)
    global X
    global Y
    global d
    
    N_p = size(COORD, 1);

    fig = figure(1);
    hold on
    axis equal
    axis([0.5 X+0.5 0.5 Y+0.5])
    set(gcf,'unit','centimeters','position',[1 1 55 35])

    M = 0.5:1:X+0.5;
    N = 0.5:1:Y+0.5;
    
    m = size(M, 2);
    n = size(N, 2);
    
    for i = 1:n
        plot(M, N(i)*ones(m, 1), 'k')
    end
     
    for i = 1:m
        plot(M(i)*ones(n, 1), N, 'k')
    end   
    
    scatter(COORD(:,1), COORD(:,2), 800, 'b')
    
    for p = 1:N_p
        O = COORD(p, :);
        text(O(1)-0.07, O(2), num2str(NO(p)))
    end
    
    a = X/2- d/2+ 0.5;
    A = X/2+ d/2+ 0.5;
    b = Y- 0.5;
    B = Y+ 0.5;
    
    fill([a A A a], [b b B B], 'g') 

end