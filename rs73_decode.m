function decoded_msg = rs73_decode(received, all_code, all_msg)
% RS73分组码穷举最小汉明距离译码
% 译码准则：选取与接收码字汉明距离最小的合法码字，输出对应原始信息
% 输入参数
%   received  : 接收码字矩阵，每行代表1组接收码元
%   all_code  : 编码生成的全部合法码字集合矩阵
%   all_msg   : 与all_code一一对应的原始信息比特矩阵
% 输出参数
%   decoded_msg: 译码恢复后的信息矩阵，行数等于接收码字组数
% 获取接收码字总组数
[row_total, ~] = size(received);
% 预分配译码结果存储空间
msg_col_num = size(all_msg, 2);
decoded_msg = zeros(row_total, msg_col_num);
% 逐组完成译码
for code_idx = 1 : row_total
    % 批量计算当前接收码字与所有标准码字的汉明距离
    hamming_dist_list = hamming_dist_batch(received(code_idx, :), all_code);
    % 查找最小汉明距离对应的合法码字索引
    [~, min_dist_code_index] = min(hamming_dist_list);
    % 映射得到原始信息，存入输出矩阵
    decoded_msg(code_idx, :) = all_msg(min_dist_code_index, :);
end

end