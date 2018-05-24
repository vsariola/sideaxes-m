

addpath ..;

close all;
width = 16;
height = 12;
figure('unit','centimeter','position',[5 5 width height],'color','w');

edge = 1.1;
ticklength = 0.2;
subwidth = (width-edge-ticklength-0.05)/2;
subheight = (height-edge-ticklength-0.05)/2;
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

edgeaxes(ax1,'west');
rangeline(-20,20,0);
tick(-10:10);
label(-10:10);
label([],0.7,'Variable 2','orientation','vertical');

edgeaxes(ax1,'south');
rangeline(-20,20,0);
tick(-10:10);
label(-10:10);
label([],0.7,'Variable 1');

edgeaxes(ax1,'north','size',ticklength);
rangeline(-20,20,0);
tick(data(:,1),[0;ticklength]);
rangeline(-20,20,ticklength);

edgeaxes(ax1,'east','size',ticklength);
rangeline(-20,20,0);
tick(data(:,2),[0;ticklength]);

ax2 = edgeaxes(ax1,'north','gap',ticklength,'size',subheight,'orientation','north')
hold on;
plot(data(:,1),data(:,3),'b.');
line([data(1,1);data(1,1)],[data(1,3);-20],'Color','k','LineStyle','--');    
line([data(1,1);20],[data(1,3);data(1,3)],'Color','k','LineStyle','--');    
ylim(expand([min(data(:,3)) max(data(:,3))]));

edgeaxes(ax2,'west');
rangeline(-20,20,0);
tick(-10:10);
label(-10:10);
label([],0.7,'Variable 3','orientation','vertical');

edgeaxes(ax2,'east','size',ticklength);
rangeline(-20,20,0);
tick(data(:,3),[0;ticklength]);
rangeline(-20,20,ticklength);

edgeaxes(ax2,'north');
rangeline(-20,20,0);

ax3 = edgeaxes(ax2,'east','gap',ticklength,'size',subwidth,'orientation','north');
hold on;
plot(data(:,2),data(:,3),'b.');
line([data(1,2);-20],[data(1,3);data(1,3)],'Color','k','LineStyle','--');    
xlim(expand([min(data(:,2)) max(data(:,2))]));


edgeaxes(ax3,'north');
rangeline(-20,20,0);

edgeaxes(ax3,'east');
rangeline(-20,20,0);

edgeaxes(ax3,'south');
rangeline(-20,20,0);
tick(-10:10);
label(-10:10);
label([],0.7,'Variable 2');


rmpath('..');
