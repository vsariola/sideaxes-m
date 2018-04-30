function test_logscales    
    addpath('..');
   
    figure;
    
    axes('position',[0.1 0.1 0.4 0.4],'visible','off');
    make_test_plot();      
    text(5,5,'Points should align to ticks','Clipping','off');

    ax = axes('position',[0.6 0.1 0.4 0.4],'visible','off');
    make_test_plot();
    ax.XScale = 'log';    

    ax = axes('position',[0.1 0.6 0.4 0.4],'visible','off');
    make_test_plot();    
    ax.YScale = 'log';    
    
    ax = axes('position',[0.6 0.6 0.4 0.4],'visible','off');
    make_test_plot();
    ax.XScale = 'log';
    ax.YScale = 'log';    
    
    rmpath('..');
end

function make_test_plot
    ax = gca;
    x = 2:10;
    hold on;
    plot(x,2,'k.');
    plot(2,x,'k.');
    hold off;
    axis([1 10 1 10]);
    edgeaxes(ax,'west','size',0.1);
    ticks(x);
    edgeaxes(ax,'south','size',0.1);
    ticks(x);
    axes(ax);
end


