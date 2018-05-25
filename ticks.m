function ret = ticks(varargin)
% ticks Draws ticks in an axes object created by edgeaxes.
%   ticks(x) adds ticks marks to positions defined by x.
%
%   Example: (run after having plot something)
%       sideaxes('south');
%       ticks(-5:5);
%
%   ticks(...,y). If y is a singleton, the tickmarks extend from 0 to y,
%   effectively making them have the length y. If y is a 2 x 1 vector, the
%   tick marks start from y(1) and end at y(2), useful for making e.g.
%   major and minor tick marks. If y is a 2 x N vector, each tick mark has
%   a custom extend. By default, y = 0.1. Note that you can use negative
%   values to make ticks that extend inside the plot; however, in that
%   case, you will have to disable clipping (ticks(...,'Clipping','off'))
%
%   Any extra name-value parameters are passed forward to the line command
%   used internally. Useful for changing linestyles, colors and clipping.
%
%   ticks(AX,...) adds the ticks to the axes object AX
%
%   H = ticks(...) returns the line object created.
%
%   See also sideaxes, labels, autoticks.

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
    
    
