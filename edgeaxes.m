function ret = edgeaxes(varargin)
% edgeaxes Creates axes that shares an edge with an existing axes object
%   edgeaxes(S) where S is 'north','east','south' or 'west' creates a new
%   axes graphics object relative to current axes object.
%
%   edgeaxes(AX,...) creates the new axes object relative to axes AX
%
%   H = edgeaxes(...) returns the axes object created.
%
%   edgeaxes(...,Name,Value) specifies edgeaxes properties using one or
%   more Name,Value pair arguments:
%   
%       gap - adds small gap between the edges of the axes in the units
%           defined by 'units'. Default: 0.
%       size - size (width or height) of the other edge, which was not
%           shared with the 
%       link - true (default) or false. Callback functions are added to
%           both original and created axes objects to make sure that
%           changing the limits of one changes them in another, allowing
%           dynamic zooming etc.
%       orientation - 'relative' (default),'west','east','south' or 'north'
%           Defines how the created axes is oriented. Positive y-direction
%           is pointing to this direction,
%       units - 'normalized','inches','centimeters','points','pixels' or
%           'characters'. Def
%
%   Any extra Name,Value pairs are passed forward to the axes.
%
%   Example: visualize rug plot, medians and quantiles on the edge of an
%   axes object. ticks, rangeline and labels all take advantage of the
%   easy coordinate system set up by edgeaxes, and note the extra plot
%   command that adds a dot right at the median
%
%       x = randn(100,1);
%       y = randn(100,1);
%       axes('Position',[0.1 0.9 0.1 0.9]
%       plot(x,y,'.');
%       edgeaxes('south')
%       ticks(x);
%       rangeline(min(x),quantile(x,0.25));
%       plot(median(x),0,'k.','MarkerSize',10);
%       labels(median(x));
%       rangeline(quantile(x,0.25),max(x));       
%
%   See also ticks, labels.

    [ax,arg,~] = axescheck(varargin{:});

    if (isempty(ax))
        ax = gca;
    end
    fig = ancestor(ax,'figure');

    expectedSides = {'north','south','west','east'};
    expectedUnits = {'pixels','normalized','inches','centimeters','points','characters'};
    expectedOrientation = {'relative','west','east','south','north'};

    p = inputParser();
    p.KeepUnmatched = true;
    addRequired(p,'side',@(x) any(validatestring(x,expectedSides)));
    addParameter(p,'gap',0,@isnumeric);
    addParameter(p,'link',true);
    addParameter(p,'size',[],@(x) isempty(x) || isnumeric(x));
    addParameter(p,'units','centimeter',@(x) any(validatestring(x,expectedUnits)));
    addParameter(p,'orientation','relative',@(x) any(validatestring(x,expectedOrientation)));
    parse(p,arg{1},arg{2:end});

    mpn = getInUnits(ax,'Position','normalized');
    mpu = getInUnits(ax,'Position',p.Results.units);
    s = mpn(3:4) ./ mpu(3:4);
    size = p.Results.size;
    
    if strcmp(p.Results.side,'west')
        if (isempty(size))
            size = mpu(1)-p.Results.gap;
        end
        subpos = [(mpn(1)-s(1)*(p.Results.gap+size)) mpn(2) size*s(1) mpn(4)];
    elseif strcmp(p.Results.side,'east')
        if (isempty(size))
            size = 1/s(1)-mpu(1)-mpu(3)-p.Results.gap;
        end
        subpos = [(mpn(1)+mpn(3)+s(1)*p.Results.gap) mpn(2) size*s(1) mpn(4)];
    elseif strcmp(p.Results.side,'north')
        if (isempty(size))
            size = 1/s(2)-mpu(2)-mpu(4)-p.Results.gap;
        end
        subpos = [mpn(1) (mpn(2)+mpn(4)+s(2)*p.Results.gap) mpn(3) size*s(2)];
    else        
        if (isempty(size))
            size = mpu(2)-p.Results.gap;
        end
        subpos = [mpn(1) (mpn(2)-s(2)*(p.Results.gap+size)) mpn(3) size*s(2)];
    end
    
    d = [fieldnames(p.Unmatched) struct2cell(p.Unmatched)]';
    d = reshape(d,1,numel(d));
    ret = axes(fig,'Position',subpos,'units','normalized','visible','off','ClippingStyle','3dbox',d{:});    
    ret.UserData = p.Results.side;        
    
    orientation = p.Results.orientation;
    if strcmp(orientation,'relative')
        orientation = p.Results.side;
    end
        
    if strcmp(orientation,'west')
        ret.View = ax.View - [90 0];                     
    elseif strcmp(orientation,'east')
        ret.View = ax.View - [90 0];              
        set(ret,'ydir','reverse');
    elseif strcmp(orientation,'south')    
        set(ret,'ydir','reverse')            
    end           
    
    sides = {'north','west','south','east'};        
    IndexOrientation = strfind(sides, orientation);        
    indOrient = find(not(cellfun('isempty', IndexOrientation)));                
    IndexSide = strfind(sides, p.Results.side);        
    indSide = find(not(cellfun('isempty', IndexSide)));
    r2 = mod(indOrient-indSide,2);
        
    if abs(r2 - 1) == 0 
        ret.XLim = [0 size];
    else
        ret.YLim = [0 size];
    end
    
    epsilon = 1e-8;
    callback();
    
    if p.Results.link
        addlistener(ax,{'XLim','YLim','XScale','YScale'},'PostSet',@callback);        
    end
    
    function callback(~,~)               
        r1 = mod(ax.View(1)-(indSide-1)*90,180);        
        if any(abs(r1 - [0 180]) < epsilon)
            if abs(r2 - 1) == 0                
                ret.YLim = ax.XLim;
                ret.YScale = ax.XScale;
                ret.YDir = ax.XDir;
            else
                ret.XLim = ax.XLim;
                ret.XScale = ax.XScale;
                ret.XDir = ax.XDir;
            end
        elseif any(abs(r1 - [90 270]) < epsilon)
            if abs(r2 - 1) == 0
                ret.YLim = ax.YLim;
                ret.YScale = ax.YScale;
                ret.YDir = ax.YDir;
            else
                ret.XLim = ax.YLim;
                ret.XScale = ax.YScale;
                ret.XDir = ax.YDir;
            end
        end     
    end
    
    function ret = getInUnits(ax,property,unitType)
        % In order to get a property of axes in specific units,
        % e.g. position, we have to change the units, then get the property
        % and finally restore the original units to leave it untouched.        
        oldUnits = get(ax,'Units');
        set(ax,'Units',unitType);
        ret = get(ax,property);
        set(ax,'Units',oldUnits);
    end
end
