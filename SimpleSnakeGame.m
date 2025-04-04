function SimpleSnakeGame()
    % 游戏设置
    rows = 20; % 游戏区域行数
    cols = 20; % 游戏区域列数
    snake = [3 3; 3 2]; % 贪吃蛇初始位置
    direction = 'right'; % 初始移动方向
    food = []; % 食物位置

    % 初始化游戏界面
    fig = figure('KeyPressFcn', @keyPress); % 创建一个新的图形窗口
    axis on; % 打开坐标轴
    axis equal; % 设置坐标轴比例一致
    hold on;
    xlim([0,cols+1]); % 设置坐标轴限制
    ylim([0,rows+1]);

    % 绘制初始贪吃蛇和食物
    snake_plot = plot(snake(:,2), snake(:,1), 'b', 'LineWidth', 2); % 绘制贪吃蛇
    food = [randi(rows), randi(cols)];
        
    % 绘制食物
    h=plot(food(2), food(1), 'ro', 'MarkerSize', 10); % 使用红色圆点表示食物
        

    % 主循环
    while true
        % 移动贪吃蛇
        snake = moveSnake(snake, direction);

        % 检查是否吃到食物
        if snake(1,1) == food(1) && snake(1,2) == food(2)
            snake = [food; snake]; % 将新头部添加到贪吃蛇
            delete(h)
            generateFood(); % 生成新食物

        end

        % 更新贪吃蛇的显示
        snake_plot.XData = snake(:,2);
        snake_plot.YData = snake(:,1);

        % 检查游戏是否结束
        if checkBoundary(snake, rows, cols)
            msgbox('Game Over!', 'Game Over', 'warn');
            break;
        end

        % 延时一段时间，控制贪吃蛇移动速度
        pause(0.2);
    end

    % 处理按键事件，改变移动方向
    function keyPress(~, event)
        key = event.Key;
        if strcmp(key, 'uparrow') && ~strcmp(direction, 'down')
            direction = 'down';
        elseif strcmp(key, 'downarrow') && ~strcmp(direction, 'up')
            direction = 'up';
        elseif strcmp(key, 'leftarrow') && ~strcmp(direction, 'right')
            direction = 'left';
        elseif strcmp(key, 'rightarrow') && ~strcmp(direction, 'left')
            direction = 'right';
        end
    end

    % 生成新食物的函数
function generateFood()
    while true
        % 在随机位置生成食物
        food = [randi(rows), randi(cols)];
        
        % 绘制食物
        h=plot(food(2), food(1), 'ro', 'MarkerSize', 10); % 使用红色圆点表示食物
        
        % 检查食物是否在贪吃蛇身上
        if ~ismember(food, snake, 'rows')
            break; % 如果食物不在贪吃蛇身上，退出循环
        end
    end
end


    % 移动贪吃蛇的函数
    function newSnake = moveSnake(oldSnake, dir)
        head = oldSnake(1, :);
        switch dir
            case 'up'
                newHead = [head(1)-1, head(2)];
            case 'down'
                newHead = [head(1)+1, head(2)];
            case 'left'
                newHead = [head(1), head(2)-1];
            case 'right'
                newHead = [head(1), head(2)+1];
        end
        newSnake = [newHead; oldSnake(1:end-1, :)];
    end

    % 检查是否与边界碰撞
    function collided = checkBoundary(snake, r, c)
        head = snake(1, :);
        collided = (head(1) < 1 || head(1) > r || head(2) < 1 || head(2) > c);
    end
end





