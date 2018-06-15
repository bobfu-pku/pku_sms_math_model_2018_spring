% 描述竞争行为
function [pre_next_COORD, W] = compete(COORD, pre_next_COORD, W)
	global X
    global Y

    for i = 1:X
        for j = 1:Y
            N = ismember(pre_next_COORD, [i,j], 'rows') ;
            n = sum(N);
            
            if n <= 1
                continue
            else
                M = find(N==1);
                m = randperm(n, 1);
                
                for l = 1:n
                    if l == m
                        continue
                    end
                    
                    pre_next_COORD(M(l), :) = COORD(M(l), :);
                    % 1-(i,j+1);2-(i,j-1);3-(i+1,j);4-(i-1,j);5-(i,j)
                    W(M(l)) = 5;
                end

            end
            
        end
    end
    

end