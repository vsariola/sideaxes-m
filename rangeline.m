function ret = rangeline(varargin)

    [ax,arg,narg] = axescheck(varargin{:});
    
    if (isempty(ax))
        ax = gca;
    end
        
    x1 = arg{1};
    x2 = arg{2};
    
    if (narg < 3)
        y = 0;
    else
        y = arg{3};
    end
      
	ret = line(ax,[x1;x2],[y;y],'LineStyle','-','Color','k',arg{4:end});
end