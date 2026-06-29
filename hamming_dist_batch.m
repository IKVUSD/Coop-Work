function dist = hamming_dist_batch(vec, code_mat)
% 批量计算单个向量与矩阵所有行的比特级汉明距离
% 输入：vec 1×n参考向量，code_mat M×n码字矩阵
% 输出：dist M×1 距离向量

    % 按位异或得到差异位
    xor_mat = bitxor(vec, code_mat);
    
    % 计算每个元素的二进制1的个数
    bit_counts = sum(dec2bin(xor_mat(:)) - '0', 2);
    % 恢复成原矩阵尺寸
    bit_counts = reshape(bit_counts, size(xor_mat));
    
    % 按行求和得到总汉明距离
    dist = sum(bit_counts, 2);
end