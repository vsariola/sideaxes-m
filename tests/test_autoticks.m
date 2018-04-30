function test_autoticks    
    addpath('..');
   
    figure;
    
    axes('position',[0.1 0.1 0.4 0.4],'visible','off');
    make_test_plot();          

    ax = axes('position',[0.6 0.1 0.4 0.4],'visible','off');
    make_test_plot();
    axis([-0.5 0.5 -0.5 0.5]);

    ax = axes('position',[0.1 0.6 0.4 0.4],'visible','off');
    make_test_plot();    
    axis([-0.1 0.1 -0.1 0.1]);
    
    ax = axes('position',[0.6 0.6 0.4 0.4],'visible','off');
    make_test_plot();
    axis([-0.05 0.05 -0.05 0.05]);    
end

function make_test_plot
    ax = gca;
    x = randn(1000,1);
    y = randn(1000,1);
    hold on;
    plot(x,y,'k.');   
    hold off;    
    edgeaxes(ax,'west','size',0.1);
    autoticks();
    edgeaxes(ax,'south','size',0.1);
    autoticks();
    axes(ax);
end


