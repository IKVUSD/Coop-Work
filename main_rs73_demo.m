%% 1. 参数配置
m = 3;                  % GF(2^m) 域的指数
n = 2^m - 1;            % 码长 n=7
k = 3;                  % 信息位长度 k=3
t = (n - k) / 2;        % 纠错能力：可纠正2个符号错误

%% 2. 构建全局码本（所有合法信息与对应码字，用于译码）
% 自动生成所有 8^3=512 组3元GF(8)信息序列
all_msg = dec2base(0:8^k - 1, 8, k) - '0';
% 批量编码得到所有合法码字
all_code = rs73_encode(all_msg, m, n, k);

%% 3. 生成测试数据
test_num = 5;                           % 测试组数
msg_original = randi([0, 7], test_num, k);  % 随机生成原始信息

%% 4. RS编码
code_original = rs73_encode(msg_original, m, n, k);

%% 5. 加入随机符号噪声
error_sym_num = 2;  % 错误符号数，≤t=2时可正确译码
noise = zeros(test_num, n);
for i = 1:test_num
    err_pos = randperm(n, error_sym_num);   % 随机错误位置
    noise(i, err_pos) = randi([1, 7], 1, error_sym_num); % 随机错误值
end
received_code = bitxor(code_original, noise);  % GF域加法等价于按位异或

%% 6. RS译码
msg_decoded = rs73_decode(received_code, all_code, all_msg);

%% 7. 结果统计与输出
correct_cnt = sum(all(msg_original == msg_decoded, 2));
correct_rate = correct_cnt / test_num;

fprintf('===== 原始信息 =====\n');
disp(msg_original);
fprintf('===== 编码后码字 =====\n');
disp(code_original);
fprintf('===== 加噪后接收码字 =====\n');
disp(received_code);
fprintf('===== 译码结果 =====\n');
disp(msg_decoded);
fprintf('译码正确率：%.2f %%\n', correct_rate * 100);