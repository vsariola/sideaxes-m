addpath('..');

close all
figure('unit','centimeter','position',[5 5 8 6],'color','w');
axes('Position',[0.15 0.2 0.85 0.8],'visible','off');

data = readtable('iris.data.txt','Delimiter',',','Format','%f%f%f%f%s');
groups = table2array(unique(data(:,5)));
x = table2array(data(:,1));
y = table2array(data(:,2));
y1 = min(y);
y2 = max(y);
x1 = min(x);
x2 = max(x);
for i = 1:length(groups)
    rows = strcmp(data.Var5,groups{i});
    subtable = data(rows,{'Var1','Var2'});
    xx = table2array(subtable(:,1));
    yy = table2array(subtable(:,2));
    plot(xx,yy,'.');
    hold on;
end
ex = (x2 - x1) * .05;
ey = (y2 - y1) * .05;
axis([x1 x2 y1 y2]+[-ex ex -ey ey]);
set(gca,'visible','off');
ax = gca;

sideaxes(ax,'west','size',0.6);
rangeline(min(y),max(y));
d = 0.5;
yticks = ceil(y1/d+0.4)*d:d:floor(y2/d-0.4)*d;
ticks(yticks);
labels(yticks);
labels([y1 y2]);
sideaxes('west','link',false);
labels([],[],'Sepal length (cm)','Orientation','vertical');

sideaxes(ax,'south','size',0.5);
rangeline(min(x),max(x));
d = 0.5;
xticks = ceil(x1/d+0.7)*d:d:floor(x2/d-0.7)*d;
ticks(xticks);
labels(xticks);
labels([x1 x2]);
sideaxes('south','link',false);
labels([],[],'Sepal width (cm)');

rmpath('..');
