function ret = labels(varargin)
% labels Draws (tick)labels in an axes object created by edgeaxes.
%   labels(x) adds labels at positions defined by x. If x is omitted, it
%   defaults to mean(xlim(gca)).
%
%   Example: (run after having plot something)
%       sideaxes('south');
%       tick(-5:5);
%       label(-5:5);
%
%   labels(...,y). Y-coordinate of each label, vector or a scalaer. If y is a
%   singleton, it is expanded for every x. Defaults to 0.2.
%  
%   labels(...,s). S defines the text to draw at the position(s) defined by
%   x and y. S can be:
%       1) a string, in which it is printed as it is
%       2) a numeric value, in which case it is converted to string using
%       num2str
%       3) a function that takes 1 argument and returns a value. In this
%       case, the x-coordinates is passed to the function and the value is
%       displayed. Example: @(x) sprintf('%.1f',x)
%       4) a function that takes 2 arguments and returns a value. In this
%       case, the x- and y-coordinates are passed to the function and the value is
%       displayed. Example: @(x,y) sprintf('(%.1f,%.1f)',x,y)
%       5) a function that takes 3 arguments and returns a value. In this
%       case, the x- and y-coordinates and index of the tick are passed to
%       the function. If you want to label data points, the index is useful
%       if there is a lookup table to find the name of each data point.
%
%   labels(...,Name,Value) specifies edgeaxes properties using one or
%   more Name,Value pair arguments:
%   
%       location - 'north','northeast','east', etc. or 'center'. If the
%           axes object has UserData, labels uses that. Otherwise defaults
%           to 'east'.
%       orientation - 'vertical' or 'horizontal'. Default: 'vertical'
%
%   H = labels(...) returns a cell array of the text objects created.
%
%   See also sideaxes, ticks, autoticks.

    [ax,arg,narg] = axescheck(varargin{:});
    
    if (isempty(ax))
        ax = gca;
    end
    
    if (narg < 1 || isempty(arg{1}))        
        arg{1} = mean(xlim(gca));
    end
    
    if (narg < 2|| isempty(arg{2}))
        arg{2} = 0.2;
    end
    
    if (narg < 3 || isempty(arg{3}))
        arg{3} = @(x) num2str(x);
    end
    
    expectedLocation = {'north','south','west','east','northwest','northeast','southwest','southeast','center'};
    expectedOrientation = {'horizontal','vertical'};
    
    if ~isempty(ax.UserData) && any(validatestring(ax.UserData,expectedLocation))
        defaultLocation = ax.UserData;
    else
        defaultLocation = 'east';
    end
            
    p = inputParser();
    p.KeepUnmatched = true;    
    addRequired(p,'x',@isnumeric);    
    addRequired(p,'y',@isnumeric);    
    addRequired(p,'text');    
    addParameter(p,'location',defaultLocation,@(x) any(validatestring(x,expectedLocation)));    
    addParameter(p,'orientation','horizontal',@(x) any(validatestring(x,expectedOrientation)));
    parse(p,arg{:});
    x = p.Results.x;
    y = p.Results.y;
    if (numel(x) == 1 && numel(y) > 1)
        x = x*ones(size(y));
    end
    if (numel(y) == 1 && numel(x) > 1)
        y = y*ones(size(x));
    end   
    
    if strfind(p.Results.location, 'north')
        i1 = 3;
    elseif strfind(p.Results.location, 'south')
        i1 = 1;
    else
        i1 = 2;
    end
    
    if strfind(p.Results.location, 'west')
        i2 = 3;
    elseif strfind(p.Results.location, 'east')
        i2 = 1;
    else
        i2 = 2;
    end
    
    valigns = {'top','middle','bottom'};
    haligns = {'left','center','right'};
    
    if strcmp(p.Results.orientation,'horizontal')
        valign = valigns{i1};
        halign = haligns{i2};
        rotation = 0;
    else
        valign = valigns{i2};
        halign = haligns{i1};
        rotation = 90;
    end    
    
    d = [fieldnames(p.Unmatched) struct2cell(p.Unmatched)]';
    d = reshape(d,1,numel(d));
    ind = 1:numel(x);
    ind = reshape(ind,size(x));
	ret = arrayfun(@fun,x,y,ind,'UniformOutput',false);
    
    function fret = fun(x,y,i)
        str = p.Results.text;        
        if isa(str,'function_handle')
            if nargin(str) == 3
                str = str(x,y,i);
            elseif nargin(str) == 2
                str = str(x,y);
            elseif nargin(str) == 1;
                str = str(x);
            else
                error('Functionhandle labels should take either 1 parameter (x), 2 parameters (x,y) or 3 parameters (x,y,index)');
            end           
        end                      
        if isnumeric(str)
            str = num2str(str);
        end
        fret = text(ax,x,y,str,'FontName','Arial','FontSize',10,'Rotation',rotation,'VerticalAlign',valign,'HorizontalALign',halign,'Clipping','on',d{:});
    end
end