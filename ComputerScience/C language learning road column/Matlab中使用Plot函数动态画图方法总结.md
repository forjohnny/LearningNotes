## Matlab中使用Plot函数动态画图方法总结

转载自：[Matlab中使用Plot函数动态画图方法总结](http://www.cnblogs.com/duanp/archive/2008/12/02/Matlab-Plot-Animation.html)

Matlab除了强大的矩阵运算，仿真分析外，绘图功能也是相当的强大，静态画图没什么问题，由于Matlab本身的多线程编程缺陷，想要动态的画图，并且能够很好的在GUI中得到控制，还不是一件很容易的事情，下面总结几种方法。

  一. AXIS 移动坐标系
​    这种方法是最简单的一种方法，适合于数据已经全部生成的场合，先画图，然后移动坐标轴。实例代码如下：

```matlab
%%
%先画好，然后更改坐标系
%在命令行中 使用 Ctrl+C 结束
t=0:0.1:100*pi;
m=sin(t);
plot(t,m);
x=-2*pi;
axis([x,x+4*pi,-2,2]);
grid on
while 1 

    if x>max(t)

        break;

    end

    x=x+0.1;

    axis([x,x+4*pi,-2,2]); %移动坐标系

    pause(0.1);

end

```




 二. Hold On 模式
​     
​       此种方法比较原始，适合于即时数据，原理是先画上一帧，接着保留原始图像，追加下一幀图像，此种方式比较繁琐，涉及画图细节，并且没有完整并连续的Line对象数据。

   例如：

```matlab
%%

% Hold On 法

% 此种方法只能点，或者分段划线

hold off

t=0;

m=0;

t1=[0 0.1]; %要构成序列

m1=[sin(t1);cos(t1)];

p = plot(t,m,'*',t1,m1(1,:),'-r',t1,m1(2,:),'-b','MarkerSize',5);   

x=-1.5*pi;

axis([x x+2*pi -1.5 1.5]);

grid on;

for i=1:100

    hold on

    t=0.1*i;  %下一个点

    m=t-floor(t);

    t1=t1+0.1; %下一段线(组)

    m1=[sin(t1);cos(t1)];

    p = plot(t,m,'*',t1,m1(1,:),'-r',t1,m1(2,:),'-b','MarkerSize',5);   

    x=x+0.1;

    axis([x x+2*pi -1.5 1.5]);

    pause(0.01);

end

```




三.  Plot 背景擦除模式

  这种模式比较适合画动画，效率比较高，刷新闪烁小，适合即时数据，最终的Line结构数据完整。

了解此方法之前要搞清楚 Plot函数的原型是什么： Plot函数，输入为 X-Y (-X)坐标元组、以及“属性”-“值对，输出为一个列向量（每条曲线岁对应的Line结构 Handle，每一行代表一个 线条的handles）, 每一线条都有 XData，YData 向量。如果你画了2条线，那么会返回 2×1的向量。
  重新画图不需要 重新书写 Plot，只需要 刷新图像即可，使用drawnow函数。

完整实例如下：

1. 画一个点的动画：

```matlab
%%

%采用背景擦除的方法，动态的划点，并且动态改变坐标系

% t,m 均为一行 ，并且不能为多行

t=0;

m=0;

p = plot(t,m,'*',...

   'EraseMode','background','MarkerSize',5);

x=-1.5*pi;

axis([x x+2*pi -1.5 1.5]);

grid on;

for i=1:1000

    t=0.1*i;       %两个变量均不追加  

    m=sin(0.1*i); 

    set(p,'XData',t,'YData',m)

    x=x+0.1;    

    drawnow

    axis([x x+2*pi -1.5 1.5]);

    pause(0.1);

end

```



2.动态多条曲线(即时数据)

```matlab
1. %%
   %采用背景擦除的方法，动态的划线，并且动态改变坐标系
   % 多行划线

t=[0]

m=[sin(t);cos(t)]

p = plot(t,m,...

   'EraseMode','background','MarkerSize',5);

x=-1.5*pi;

axis([x x+2*pi -1.5 1.5]);

grid on;

for i=1:1000

    t=[t 0.1i];                   %Matrix 1(i+1)

    m=[m [sin(0.1i);cos(0.1i)]]; %Matrix 2*(i+1)

    set(p(1),'XData',t,'YData',m(1,:))

    set(p(2),'XData',t,'YData',m(2,:))    

    drawnow

    x=x+0.1;    

    axis([x x+2*pi -1.5 1.5]);

    pause(0.5);

end
```


上面的这几个画图方式的示例只是简单的for循环，是单线程的，如果是涉及到GUI的编程，那么请使用Timer来完成这件事情，Timer是我在Matlab中实现多线程唯一方法(没有找到别的方法)。