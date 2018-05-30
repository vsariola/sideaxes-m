addpath('..');

close all;
width = 8;
height = 6;
b = [2.08 1.98 0.2 0.2];
figure('unit','centimeter','position',[5 5 8 6],'color','w');
ax = axes('unit','centimeter','Position',[b(1:2) width-b(1)-b(3) height-b(2)-b(4)],'visible','off');

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
axis([x1 x2 y1 y2]);
hold on;

yhistax = sideaxes(ax,'west','size',0.9,'orientation','east','gap',0.1);
ylim([0 0.1]);
ytickax = sideaxes('west','size',0.5);
d = 1;
yticks = ceil(y1/d)*d:d:floor(y2/d)*d;
ticks(yticks);
labels(yticks);
sideaxes('west','link',false);
labels([],[],'Y','Orientation','vertical');


xhistax = sideaxes(ax,'south','size',0.9,'orientation','north','gap',0.1);
ylim([0 0.1]);
xtickax = sideaxes('south','size',0.4);
d = 1;
xticks = ceil(x1/d)*d:d:floor(x2/d)*d;
ticks(xticks);
labels(xticks);
sideaxes('south','link',false);
labels([],[],'X');

for i = 1:length(datas);   
    xx = datas{i}(:,1);
    yy = datas{i}(:,2);
    plot(ax,xx,yy,'.','Color',colors{i});   
    h1 = histogram(yhistax,yy,'BinLimits',[y1,y2],'Normalization','pdf','FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.1);    
    ylim(yhistax,[0 max(max(ylim(yhistax)),max(h1.Values))]);
    h2 =  histogram(xhistax,xx,'BinLimits',[x1,x2],'Normalization','pdf','FaceColor',colors{i},'EdgeColor','none','FaceAlpha',0.1);      
    ylim(xhistax,[0 max(max(ylim(yhistax)),max(h2.Values))]);
end

rmpath('..');
