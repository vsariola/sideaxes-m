addpath('..');

close all

data = readtable('iris.data.txt','Delimiter',',','Format','%f%f%f%f%s');
x = table2array(data(:,1));
y = table2array(data(:,2));
y1 = min(y);
y2 = max(y);
x1 = min(x);
x2 = max(x);
plot(x,y,'.');
ex = (x2 - x1) * .05;
ey = (y2 - y1) * .05;
axis([x1 x2 y1 y2]+[-ex ex -ey ey]);
set(gca,'visible','off');
ax = gca;

edgeaxes(ax,'west');
rangeline(min(y),max(y));
d = 0.5;
yticks = ceil(min(y)/d)*d:d:floor(max(y)/d)*d;
ticks(yticks);
labels(yticks);

edgeaxes(ax,'south');
rangeline(min(x),max(x));
d = 0.5;
xticks = ceil(min(x)/d)*d:d:floor(max(x)/d)*d;
ticks(xticks);
labels(xticks);

rmpath('..');
