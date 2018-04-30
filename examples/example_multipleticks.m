addpath ..;

x = randn(100,1)*2;
y = randn(100,1)*2;
axes('Position',[0.2 0.2 0.8 0.8],'visible','off');
axis([-4.5 4.5 -4.5 4.5]);
hold on;
plot(x,y,'.');
% Create first edge axes. We use units centimeters so the 
% y-axis units are centimeters and thus later when we define e.g. the 
% length of the tick, that is centimeters 
edgeaxes('south','units','centimeters');
x = -10:10;
% Add the ticks to the centimeter side of things. The labels for the
% centimeter scale are on the northside of things
ticks(x,[0.4 0.7]');
labels(x,0.4,[],'Side','north'); 
% Draw a black line between the ticks
line([-10;10],[0.7;0.7],'Color','k');
% Add ticks to the inch scale. The inch scale ticks are pointing south.
% Note that we define a custom way to create the text for the label
ticks(x*2.54,[0.7;1]);
labels(x*2.54,1,@(a,b,i) num2str(x(i)),'Side','south');
% Finally, create one edge axes for the labels. This way, the labels
% won't move even when scaling the axes
edgeaxes('west','units','centimeters');
labels(0.7,1,'Length');
labels(0.4,0.1,'cm');
labels(1,0.1,'inch');

rmpath ..;