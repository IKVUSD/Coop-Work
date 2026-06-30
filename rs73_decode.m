function decoded_msg = rs73_decode(received, all_code, all_msg)
% 穷举法译码：计算接收码字与所有合法码字的比特汉明距离，取最小对应信息
% 输入：received 接收码字矩阵，all_code 全部合法码字，all_msg 对应信息
% 输出：decoded_msg 译码后的信息矩阵

    [row_num, ~] = size(received);
    decoded_msg = zeros(row_num, size(all_msg, 2));
    
    for i = 1:row_num
        % 批量计算当前接收字与所有码字的比特汉明距离
        dist = hamming_dist_batch(received(i, :), all_code);
        % 找到最小距离对应的索引
        [~, min_idx] = min(dist);
        decoded_msg(i, :) = all_msg(min_idx, :);
    end
end