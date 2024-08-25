

% 绘制直角三棱锥的边
figure;
trimesh(faces, vertices(:, 1), vertices(:, 2), vertices(:, 3), 'EdgeColor', 'k', 'LineStyle', '-');
axis off;  % 不显示坐标系

% 标注底边长度
text(0.5, -0.1, 0, 'a', 'HorizontalAlignment', 'center');

% 标注角 beta
text(0.05, 0.05, 0.4, '\beta', 'FontSize', 14, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% 绘制不可见表面
patch('Faces', faces(1, :), 'Vertices', vertices, 'EdgeColor', 'k', 'FaceColor', 'none', 'LineStyle', '--');
% 创建一个新的图形窗口
figure;

% 定义长方形的参数
x = [1, 1, 5, 5]; % 长方形的 x 坐标
y = [1, 3, 3, 1]; % 长方形的 y 坐标

% 绘制长方形
fill(x, y, 'w'); % 'b' 表示填充蓝色

% 添加平行于短边的线段
num_lines = 5; % 定义线段的数量
line_length = 4; % 定义线段的长度
short_side_length = 2; % 长方形的短边长度

for i = 1:num_lines
    % 计算线段的起始点和结束点坐标
    x1 = 1; % 线段的起始 x 坐标
    y1 = 1 + (i - 1) * (short_side_length / (num_lines - 1)); % 线段的起始 y 坐标
    x2 = x1 + line_length; % 线段的结束 x 坐标
    y2 = y1; % 线段的结束 y 坐标
    
    % 绘制线段
    line([x1, x2], [y1, y2], 'Color', 'k', 'LineWidth', 2); % 'r' 表示线段颜色为红色，'LineWidth' 可以调整线段宽度
end

% 隐藏坐标轴
axis off;

% 设置坐标范围，根据需要调整
axis([0, 6, 0, 4]);

% 可选：添加标题
title('长方形内部的线段');

% 可选：保存图像为图像文件
% saveas(gcf, 'rectangle_with_lines.png');



