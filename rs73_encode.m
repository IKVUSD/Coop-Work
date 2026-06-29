function code = rs73_encode(msg, m, n, k)
% RS(7,3) 系统编码函数：多项式除法生成校验位
% 输入：msg 信息矩阵（每行1组k维信息，元素0~7），m/n/k为码参数
% 输出：code 码字矩阵（每行1组n维系统码字）

    % RS(7,3) 生成多项式 g(x) = x^4 + 7x^3 + 6x^2 + x + 6
    g = [1, 7, 6, 1, 6];  
    len_g = length(g);
    
    [row_num, ~] = size(msg);
    code = zeros(row_num, n);
    
    for i = 1:row_num
        % 信息多项式左移 (n-k) 位，空出校验位位置
        msg_shifted = [msg(i, :), zeros(1, n - k)];
        % GF域多项式除法求余式（校验位）
        parity = gf_poly_mod(msg_shifted, g, m);
        % 系统码结构：信息位在前，校验位在后
        code(i, :) = [msg(i, :), parity];
    end
end