function ret = ticks(varargin)
    % Note: pass 'Clipping','off' if you want to disable clipping
    [ax,arg,narg] = axescheck(varargin{:});
    if (isempty(ax))
        ax = gca;
    end
    x = arg{1};
    if (narg < 2)
        y = 0.1;
    else
        y = arg{2};   
    end
    if (size(x,2) == 1)
        x = x';
    end
    if (size(y,2) == 1 && size(y,1) > 2)
        y = y';
    end
    if (size(x,1) == 1)
        x = [x;x];
    end
    if (size(y,1) == 1)
        y = [y;zeros(size(y))];
    end
    if (size(y,2) == 1 && size(x,2) > 1)
        y = repmat(y,1,size(x,2));
    end
    ret = line(ax,x,y,'LineStyle','-','Color','k',arg{3:end});        
end
    
    
