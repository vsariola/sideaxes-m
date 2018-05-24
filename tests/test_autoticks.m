function test_autoticks    
    addpath('..');
   
    x = randn(1000,1);
    y = randn(1000,1);
    
    figure;
    
    axes('position',[0.1 0.1 0.4 0.4],'visible','off');
    make_test_plot(x,y);          

    ax = axes('position',[0.6 0.1 0.4 0.4],'visible','off');
    make_test_plot(x,y);
    axis([-0.5 0.5 -0.5 0.5]);

    ax = axes('position',[0.1 0.6 0.4 0.4],'visible','off');
    make_test_plot(x,y);    
    axis([-0.1 0.1 -0.1 0.1]);
    
    ax = axes('position',[0.6 0.6 0.4 0.4],'visible','off');
    make_test_plot(x,y);
    axis([-0.05 0.05 -0.05 0.05]);    
end

function make_test_plot(x,y)
    ax = gca;
    hold on;
    plot(x,y,'k.');   
    hold off;    
    edgeaxes(ax,'west','size',1);
    rangeline(min(y),max(y));
    autotick();
    edgeaxes(ax,'south','size',1);
    rangeline(min(y),max(y));
    autotick();
    axes(ax);
end


