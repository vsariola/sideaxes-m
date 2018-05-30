function export_all
    filelist = dir('example_*.m');

    if ~exist('../images/pdfs','dir')
       mkdir('../images/pdfs');
    end
    
    for i = 1:length(filelist)
        close all;
        n = filelist(i).name;
        runInSepareteWorkspace(n);
        s = regexp(n,'example_(\w+)','once','tokens');
        warning('');
        exportedName = sprintf('../images/pdfs/%s.pdf',s{1});
        export_fig(exportedName);
        [warnMsg, warnId] = lastwarn;
        if ~isempty(warnMsg)
            fig = gcf;
            fig.PaperPositionMode = 'auto';
            fig_pos = fig.PaperPosition;
            fig.PaperSize = [fig_pos(3) fig_pos(4)];
            print(gcf, '-dpdf', exportedName); 
        end
    end
end

function runInSepareteWorkspace(script)
    run(script);
end