function example_coordinatesystem
    addpath ..;
    close all;

    width = 12;
    height = 9;
    edge = 2.2;
    a = 0;
    b = 10.5;
    figure('unit','centimeter','position',[10 10 width height],'color','w');
    ax = axes('unit','centimeter','position',[edge edge width-2*edge height-2*edge],'visible','off');
        
    draw_arrows()    
    axis([a b a b]);    
    hold on;
    
    labels(b/2,b/2,'Main axes','side','middle');
    
    sideaxes(ax,'north');
    draw_arrows();
    labels(b/2,edge-0.6,'sideaxes(''north'')','side','middle');
    
    sideaxes('west');
    ticks(1:edge);
    labels(1:edge);
    labels([],0.5,'cm','orientation','vertical');
    
    sideaxes(ax,'south');
    labels(b/2,edge-0.6,'sideaxes(''south'')','side','middle');
    draw_arrows();
    labels(1:b);
    ticks(1:b,[-0.1;0.1],'Clipping','off');
    labels([],0.5,'Arbitrary units');
    
    sideaxes('east');
    ticks(1:edge);
    labels(1:edge);
    labels([],0.5,'cm','orientation','vertical');
    
    sideaxes(ax,'west');
    labels(b/2,edge-0.6,'sideaxes(''west'')','side','middle','orientation','vertical');
    draw_arrows();
    ticks(1:b,[-0.1;0.1],'Clipping','off');
    labels(1:b);
    labels([],0.5,'Arbitrary units','orientation','vertical');  
    
    sideaxes('south');
    ticks(1:edge);
    labels(1:edge);
    labels([],0.5,'cm');
    
    sideaxes(ax,'east');
    labels(b/2,edge-0.6,'sideaxes(''east'')','side','middle','orientation','vertical');
    draw_arrows();
    
    sideaxes('north');
    ticks(1:edge);
    labels(1:edge);
    labels([],0.5,'cm');

    rmpath ..;
    
    function draw_arrows   
        hold on;
        line([a a;a b;b b;b a]',[a b;b b;b a;a a]','Color','k');
        line([0.7;0.7],[0.7;1.3],'Color','k');
        line([0.6;0.7],[1.2;1.3],'Color','k');
        line([0.8;0.7],[1.2;1.3],'Color','k');
        labels(0.7,1.7,'y','side','middle');
        line([0.7;1.3],[0.7;0.7],'Color','k');
        line([1.2;1.3],[0.6;0.7],'Color','k');
        line([1.2;1.3],[0.8;0.7],'Color','k');
        labels(1.7,0.7,'x','side','middle');
    end

     function ret = getInUnits(ax,property,unitType)      
        oldUnits = get(ax,'Units');
        set(ax,'Units',unitType);
        ret = get(ax,property);
        set(ax,'Units',oldUnits);
    end
end



