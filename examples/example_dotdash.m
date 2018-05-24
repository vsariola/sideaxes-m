addpath('..');

close all;
figure('unit','centimeter','position',[5 5 8 6],'color','w');
ax = axes('Position',[0.19 0.21 0.8 0.78],'visible','off');

N = 100;

Ts = {[1 0 0;0 1 0],[1 0.4 2;0.4 0.5 -1]};

colors = {'b','r','g'};

data1 = [randn(N,2) ones(N,1)] * Ts{1}';
data2 = [randn(N,2) ones(N,1)] * Ts{2}';
datas = {data1,data2};

x = [data1(:,1);data2(:,1)];
y = [data1(:,2);data2(:,2)];
y1 = min(y);
y2 = max(y);
x1 = min(x);
x2 = max(x);
ex = (x2 - x1) * .05;
ey = (y2 - y1) * .05;
axis([x1 x2 y1 y2]+[-ex ex -ey ey]);
hold on;

westax = edgeaxes(ax,'west','size',0.9);
rangeline(min(y),max(y),0.4);
d = 1;
ytick = ceil(y1/d+0.4)*d:d:floor(y2/d-0.4)*d;
tick(ytick,[0.4;0.5]);
label(ytick,0.5);
label([y1 y2],0.5,@(x) sprintf('%.2f',x));
edgeaxes('west','link',false);
label([],[],'Y','Orientation','vertical');

southax = edgeaxes(ax,'south','size',0.7);
rangeline(min(x),max(x),0.4);
d = 1;
xtick = ceil(x1/d+0.7)*d:d:floor(x2/d-0.7)*d;
tick(xtick,[0.4;0.5]);
label(xtick,0.5);
label([x1 x2],0.5,@(x) sprintf('%.2f',x));
edgeaxes('south','link',false);
label([],[],'X');

for i = 1:length(datas);
    axes(ax);
    xx = datas{i}(:,1);
    yy = datas{i}(:,2);
    plot(xx,yy,'.','Color',colors{i});
    
    axes(westax);
    tick(yy,[-0.2;0]+i*0.2,'Color',colors{i});
    
    axes(southax);
    tick(xx,[-0.2;0]+i*0.2,'Color',colors{i});
end

rmpath('..');
