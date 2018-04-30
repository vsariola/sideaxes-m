function autoticks(varargin)    
    [ax,arg,narg] = axescheck(varargin{:});
    if (isempty(ax))
        ax = gca;
    end   
    
    hticks = [];
    hlabels = [];
    addlistener(ax,{'XLim','XScale'},'PostSet',@callback);        
    callback();
    
    function callback(~,~)         
        t = chooseticks(5);
        hticksnew = ticks(ax,t);
        hlabelsnew = labels(ax,t);                
        if ~isempty(hticks)            
            delete(hticks);                        
        end
        if ~isempty(hlabels)
            for i = 1:length(hlabels)
                delete(hlabels{i});
            end            
        end
        hticks = hticksnew;
        hlabels = hlabelsnew;        
    end

    function ret = chooseticks(desired_numticks)
        a = min(ax.XLim);
        b = max(ax.XLim);      
        mantissa = [0.1 0.2 0.5];
        exponent = 10.^(-15:15);
        tickws = mantissa' * exponent;
        tickws = tickws(:);
        numticks = floor(b./tickws)-ceil(a./tickws);
        error = abs(numticks- desired_numticks);
        [~,i] = min(error);
        tickw = tickws(i);
        ret = (ceil(a/tickw):floor(b/tickw))*tickw;              
    end  
end
        