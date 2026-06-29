function remainder = gf_poly_mod(dividend, divisor, m)
% GF(2^m) 上的多项式模除法（长除法求余式）
% 输入：dividend 被除多项式、divisor 除多项式（系数从高次到低次）
% 输出：remainder 余式，长度为 length(divisor)-1

    % 去除前导零
    dividend = dividend(find(dividend, 1):end);
    divisor = divisor(find(divisor, 1):end);
    
    len_dend = length(dividend);
    len_dsor = length(divisor);
    
    % 次数不足直接返回
    if len_dend < len_dsor
        remainder = zeros(1, len_dsor - 1);
        remainder(end - len_dend + 1 : end) = dividend;
        return;
    end
    
    current = dividend;
    while length(current) >= len_dsor
        lead_coeff = current(1);
        if lead_coeff == 0
            current = current(2:end);
            continue;
        end
        
        % 计算商项乘除式的结果
        shift = length(current) - len_dsor;
        scaled = gf_mult(lead_coeff, divisor, m);
        scaled_pad = [scaled, zeros(1, shift)];
        
        % GF域减法等价于按位异或
        current = bitxor(current, scaled_pad);
        
        % 去除前导零，处理全零情况
        first_nonzero = find(current, 1);
        if isempty(first_nonzero)
            current = [];
            break;
        end
        current = current(first_nonzero:end);
    end
    
    % 补零到固定长度
    remainder = zeros(1, len_dsor - 1);
    if ~isempty(current)
        remainder(end - length(current) + 1 : end) = current;
    end
end