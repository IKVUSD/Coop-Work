function code = rs73_encode(msg, m, n, k)
% RS(7,3) 系统码编码函数，基于有限域多项式除法生成校验位
% 生成多项式 g(x) = x^4 + 7x^3 + 6x^2 + x + 6
% 输入参数
%   msg    : 信息矩阵，每行1组k维信息符号，符号取值范围0~7
%   m / n / k : RS码参数，本函数固定适配RS(7,3)
% 输出参数
%   code   : 码字矩阵，每行1组n维系统码字，信息位在前、校验位在后
% RS(7,3)固定生成多项式系数
gen_poly = [1, 7, 6, 1, 6];
poly_len = length(gen_poly);

% 获取输入信息总组数（修复语法错误，添加[]）
[row_total, ~] = size(msg);
% 预分配输出码字内存
code = zeros(row_total, n);

% 逐行完成每组信息的编码运算
for data_idx = 1 : row_total
    % 信息多项式左移 (n-k) 位，低位补0，预留校验位空间
    msg_shifted = [msg(data_idx, :), zeros(1, n - k)];
    % GF(m)多项式取模运算，求得校验符号
    parity_symbol = gf_poly_mod(msg_shifted, gen_poly, m);
    % 拼接系统码字：信息位 + 校验位
    code(data_idx, :) = [msg(data_idx, :), parity_symbol];
end

end