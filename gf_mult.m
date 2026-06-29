function result = gf_mult(a, b, m)
% GF(2^3) 元素级乘法，支持标量、向量、矩阵混合输入
% 本原多项式：x^3 + x + 1

    % ========== 维度对齐：标量自动扩展为与另一操作数同尺寸 ==========
    if isscalar(a)
        a = repmat(a, size(b));
    elseif isscalar(b)
        b = repmat(b, size(a));
    end
    
    % 幂次表：exp_table(i) = α^(i-1) 对应的十进制值
    exp_table = [1, 2, 4, 3, 6, 7, 5];
    % 对数表：log_table(val+1) = 值val对应的α幂次
    log_table = [0, 0, 1, 3, 2, 6, 4, 5];  
    
    % 初始化结果全零
    result = zeros(size(a));
    
    % 非零元素掩码（a、b均非零时才做乘法）
    mask = (a ~= 0) & (b ~= 0);
    
    if any(mask(:))
        % 仅对非零位置做查表运算
        power_a = log_table(a(mask) + 1);
        power_b = log_table(b(mask) + 1);
        power_res = mod(power_a + power_b, 2^m - 1);
        result(mask) = exp_table(power_res + 1);
    end
end