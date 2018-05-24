function ret = labels(varargin)

    [ax,arg,narg] = axescheck(varargin{:});
    
    if (isempty(ax))
        ax = gca;
    end
    
    if (narg < 1 || isempty(arg{1}))
        xlim = get(gca,'XLim');
        arg{1} = mean(xlim);
    end
    
    if (narg < 2|| isempty(arg{2}))
        arg{2} = 0.2;
    end
    
    if (narg < 3 || isempty(arg{3}))
        arg{3} = @(x) num2str(x);
    end
    
    expectedSides = {'north','south','west','east','northwest','northeast','southwest','southeast','middle'};
    expectedOrientation = {'horizontal','vertical'};
    
    if ~isempty(ax.UserData) && any(validatestring(ax.UserData,expectedSides))
        defaultSide = ax.UserData;
    else
        defaultSide = 'east';
    end
            
    p = inputParser();
    p.KeepUnmatched = true;    
    addRequired(p,'x',@isnumeric);    
    addRequired(p,'y',@isnumeric);    
    addRequired(p,'text');    
    addParameter(p,'side',defaultSide,@(x) any(validatestring(x,expectedSides)));    
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
    
    if strfind(p.Results.side, 'north')
        i1 = 3;
    elseif strfind(p.Results.side, 'south')
        i1 = 1;
    else
        i1 = 2;
    end
    
    if strfind(p.Results.side, 'west')
        i2 = 3;
    elseif strfind(p.Results.side, 'east')
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