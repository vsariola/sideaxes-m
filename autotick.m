function autotick(varargin)   
% autotick Adds ticks and ticklabels automatically to the edgeaxes
%   autotick(count) tries to create approximately 'count' number of ticks.
%   Note that this is not always exact. By default, count = 5.
%   Internally, autotick uses tick and label commands.
%
%   See also edgeaxes, tick, label.
    [ax,arg] = axescheck(varargin{:});
    if (isempty(ax))
        ax = gca;
    end   
    
    p = inputParser();
    p.KeepUnmatched = true;
    addOptional(p,'approximateCount',5,@isnumeric);  
    parse(p,arg{1:end});
    
    htick = [];
    hlabel = [];
    addlistener(ax,{'XLim','XScale','XDir'},'PostSet',@callback);        
    callback();
    
    function callback(~,~)         
        t = choosetick(p.Results.approximateCount);
        hticknew = tick(ax,t);
        hlabelnew = label(ax,t);                
        if ~isempty(htick)            
            delete(htick);                        
        end
        if ~isempty(hlabel)
            for i = 1:length(hlabel)
                delete(hlabel{i});
            end            
        end
        htick = hticknew;
        hlabel = hlabelnew;        
    end

    function ret = choosetick(desired_numtick)
        a = min(ax.XLim);
        b = max(ax.XLim);      
        mantissa = [0.1 0.2 0.5];
        exponent = 10.^(-15:15);
        tickws = mantissa' * exponent;
        tickws = tickws(:);
        numtick = floor(b./tickws)-ceil(a./tickws);
        error = abs(numtick- desired_numtick);
        [~,i] = min(error);
        tickw = tickws(i);
        ret = (ceil(a/tickw):floor(b/tickw))*tickw;              
    end  
end
        