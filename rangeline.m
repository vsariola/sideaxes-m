function ret = rangeline(varargin)

    [ax,arg,~] = axescheck(varargin{:});
    
    if (isempty(ax))
        ax = gca;
    end
        
    x1 = arg{1};
    x2 = arg{2};
	ret = line(ax,[x1;x2],[0;0],'LineStyle','-','Color','k',arg{3:end});
end