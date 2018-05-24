# mat-edge-axes

Matlab tools to display rich information on the edges of a plot, inspired by Edward Tufte's range frames, dot dash plots and rug plots.

Matlab's capabilities to display information on the edges of a plot are limited to ticks and labels. Tufte suggests one should use the edges of the plot wisely to display rich information, for example: marginal distributions, rug plots, dot dash plots etc. These are all beyond Matlab's usual capabilities.

edgeaxes.m solves this problem by setting up a completely new axes object besides the main axes object. The new axes object has a convenient coordinate system. The x-coordinate of the newly created axes is linked to the coordinate system of the original axes object, so that you can use it for example:

- display custom tick marks and labels, for example rug plots
- display custom range frames or marginal distributions
- use it to make a second plot that is guaranteed to share one axis with the original plot. Useful for packing several plots side by side for e.g. small multiples or just to save space.
- use it display two different scales for tick marks, e.g. inches and centimeters.

Table of Contents
=================

* [Installation](#installation)
* [Usage](#usage)
* [Credits](#credits)
* [License](#license)

Installation
============

After downloading, you should add edgeaxes.m to your matlab path. For example:

    addpath('/path/to/mat-edge-axes/')
    
Note that edgeaxes.m is a standalone function and you don't necessarily need tick.m, label.m or autotick.m. However, these are very helpful in many practical situations and you might find it faster to use those functions than write your own.  

Usage
=====

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/coordinatesystem.png "Coordinate systems set up by the edgeaxes.m")

In the typical mode of operation, the newly create axes object shares x-axis with the main plot, and y-axis is pointing away from the main axes. In this new coordinate system, adding tick marks, range frames, marginal distributions etc. becomes a breeze.

Quick example
-------------

```
x = randn(100,1)+0.5;                % synthesize data
y = randn(100,1);
axes('Position',[0.05 0.1 0.9 0.9]); % create main axes
plot(x,y,'.'); 
set(gca,'visible','off')             % disable matlab's own tick marks
edgeaxes('south');                   % add edgeaxes to south for ticks
tick(-5:5);                          % add custom tick marks
label(-5:5);                         % add custom labels for the tick marks
rangeline(min(x),quantile(x,0.25));  % show minimum and first quantile
plot(median(x),0,'k.','MarkerSize',10); % show median as a dot
label(median(x),[],@(x) sprintf('%.1f',x),'Clipping','off');
rangeline(quantile(x,0.75),max(x));  % third quantile  
```

produces:

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/quickexample.png "Quick example plot that shows median, min and maximum on the edge")

Tips for using
--------------

- Remember to set(gca,'visible','off') for the main plot to disable Matlab's own ticks
- Study how rangeline.m and tick.m take advantage of the convenient coordinate system so that their implementation is very simple. Writing your own code.
- The 'side' parameter is stored in the UserData of the axes object created by edgeaxes.m. label.m takes use of this to know on which side to display the labels by default.

More examples
-------------

Include outside and inside tick marks with different scales, for example inches and centimeters (source: [examples/example_multipleticks.m](examples/example_multipleticks.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/twoscales.png "Example displaying inch and cm ticks in a plot")

Use dashes on the edge to visualize marginal distributions (Tufte calls this dot-dash plot) (source: [examples/example_dotdash.m](examples/example_dotdash.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/dotdash.png "Example of a dot-dash plot")

The frame line extends to the minimum/maximum of data (source: [examples/example_rangeframe.m](examples/example_rangeframe.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/rangeframe.png "Example of a range frame")

Rug plots, which is a combination of several dot-dash plots. (source: [examples/example_rugplot.m](examples/example_rugplot.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/rugplot.png "Example of a rug plot")

For publication quality plots, working in centimeters or inches is recommended, and then using the fantastic export_fig (https://se.mathworks.com/matlabcentral/fileexchange/23629-export-fig) toolbox for exporting.

Credits
=======

Veikko Sariola, Tampere University of Technology, 2017-2018

The inspiration for this toolbox came from reading Edward Tufte's "Visual Display of Quantitative Information". Reading the book cannot be recommended enough.

License
=======

MIT, see [LICENSE](LICENSE)
