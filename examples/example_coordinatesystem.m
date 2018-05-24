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
    
    label(b/2,b/2,'Main axes','side','middle');
    
    edgeaxes(ax,'north');
    draw_arrows();
    label(b/2,edge-0.6,'edgeaxes(''north'')','side','middle');
    
    edgeaxes('west');
    tick(1:edge);
    label(1:edge);
    label([],0.5,'cm','orientation','vertical');
    
    edgeaxes(ax,'south');
    label(b/2,edge-0.6,'edgeaxes(''south'')','side','middle');
    draw_arrows();
    label(1:b);
    tick(1:b,[-0.1;0.1],'Clipping','off');
    label([],0.5,'Arbitrary units');
    
    edgeaxes('east');
    tick(1:edge);
    label(1:edge);
    label([],0.5,'cm','orientation','vertical');
    
    edgeaxes(ax,'west');
    label(b/2,edge-0.6,'edgeaxes(''west'')','side','middle','orientation','vertical');
    draw_arrows();
    tick(1:b,[-0.1;0.1],'Clipping','off');
    label(1:b);
    label([],0.5,'Arbitrary units','orientation','vertical');  
    
    edgeaxes('south');
    tick(1:edge);
    label(1:edge);
    label([],0.5,'cm');
    
    edgeaxes(ax,'east');
    label(b/2,edge-0.6,'edgeaxes(''east'')','side','middle','orientation','vertical');
    draw_arrows();
    
    edgeaxes('north');
    tick(1:edge);
    label(1:edge);
    label([],0.5,'cm');

    rmpath ..;
    
    function draw_arrows   
        hold on;
        line([a a;a b;b b;b a]',[a b;b b;b a;a a]','Color','k');
        line([0.7;0.7],[0.7;1.3],'Color','k');
        line([0.6;0.7],[1.2;1.3],'Color','k');
        line([0.8;0.7],[1.2;1.3],'Color','k');
        label(0.7,1.7,'y','side','middle');
        line([0.7;1.3],[0.7;0.7],'Color','k');
        line([1.2;1.3],[0.6;0.7],'Color','k');
        line([1.2;1.3],[0.8;0.7],'Color','k');
        label(1.7,0.7,'x','side','middle');
    end

     function ret = getInUnits(ax,property,unitType)      
        oldUnits = get(ax,'Units');
        set(ax,'Units',unitType);
        ret = get(ax,property);
        set(ax,'Units',oldUnits);
    end
end



