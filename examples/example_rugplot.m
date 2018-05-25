

addpath ..;

close all;
width = 16;
height = 12;
figure('unit','centimeter','position',[5 5 width height],'color','w');

edge = 1.1;
tickslength = 0.2;
subwidth = (width-edge-tickslength-0.05)/2;
subheight = (height-edge-tickslength-0.05)/2;
ax1 = axes('unit','centimeter','Position',[edge edge subwidth subheight],'visible','off');

N = 30;

T = [1 .2 -0.5;.2 1 .4;-0.5 .4 1];

data = randn(N,3) * T;

expand = @(r) (r-mean(r))*1.05+mean(r);

hold on;
plot(data(:,1),data(:,2),'b.');
xlim(expand([min(data(:,1)) max(data(:,1))]));
ylim(expand([min(data(:,2)) max(data(:,2))]));
line([data(1,1);data(1,1)],[data(1,2);20],'Color','k','LineStyle','--');    

sideaxes(ax1,'west');
rangeline(-20,20,0);
ticks(-10:10);
labels(-10:10);
labels([],0.7,'Variable 2','orientation','vertical');

sideaxes(ax1,'south');
rangeline(-20,20,0);
ticks(-10:10);
labels(-10:10);
labels([],0.7,'Variable 1');

sideaxes(ax1,'north','size',tickslength);
rangeline(-20,20,0);
ticks(data(:,1),[0;tickslength]);
rangeline(-20,20,tickslength);

sideaxes(ax1,'east','size',tickslength);
rangeline(-20,20,0);
ticks(data(:,2),[0;tickslength]);

ax2 = sideaxes(ax1,'north','gap',tickslength,'size',subheight,'orientation','north')
hold on;
plot(data(:,1),data(:,3),'b.');
line([data(1,1);data(1,1)],[data(1,3);-20],'Color','k','LineStyle','--');    
line([data(1,1);20],[data(1,3);data(1,3)],'Color','k','LineStyle','--');    
ylim(expand([min(data(:,3)) max(data(:,3))]));

sideaxes(ax2,'west');
rangeline(-20,20,0);
ticks(-10:10);
labels(-10:10);
labels([],0.7,'Variable 3','orientation','vertical');

sideaxes(ax2,'east','size',tickslength);
rangeline(-20,20,0);
ticks(data(:,3),[0;tickslength]);
rangeline(-20,20,tickslength);

sideaxes(ax2,'north');
rangeline(-20,20,0);

ax3 = sideaxes(ax2,'east','gap',tickslength,'size',subwidth,'orientation','north');
hold on;
plot(data(:,2),data(:,3),'b.');
line([data(1,2);-20],[data(1,3);data(1,3)],'Color','k','LineStyle','--');    
xlim(expand([min(data(:,2)) max(data(:,2))]));


sideaxes(ax3,'north');
rangeline(-20,20,0);

sideaxes(ax3,'east');
rangeline(-20,20,0);

sideaxes(ax3,'south');
rangeline(-20,20,0);
ticks(-10:10);
labels(-10:10);
labels([],0.7,'Variable 2');


rmpath('..');
