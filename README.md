# mat-edge-axes

Matlab tools to display rich information on the edges of a plot, inspired by Edward Tufte's range frames, dot dash plots and rug plots.

What is it?
===========

Matlab's capabilities to display information on the edges of a plot are limited to ticks and labels. Displaying marginal distributions, rug plots, dot dash plots are all out of question.

edgeaxes.m solves this problem by setting up a completely new axes object besides the main axes object with a convenient coordinate system:

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/coordinatesystem.png "Coordinate systems set up by the edgeaxes.m")

In the typical mode of operation, the newly create axes object shares x-axis with the main plot, and y-axis is pointing away from the main axes. In this new coordinate system, adding tick marks, range frames, marginal distributions etc. becomes a breeze. Some examples you can do with it:

Include outside and inside tick marks with different scales, for example inches and centimeters (source: [examples/example_multipleticks.m](examples/example_multipleticks.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/twoscales.png "Example displaying inch and cm ticks in a plot")

Use dashes on the edge to visualize marginal distributions (Tufte calls this dot-dash plot) (source: [examples/example_dotdash.m](examples/example_dotdash.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/dotdash.png "Example of a dot-dash plot")

The frame line extends to the minimum/maximum of data (source: [examples/example_rangeframe.m](examples/example_rangeframe.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/rangeframe.png "Example of a range frame")

Rug plots, which is a combination of several dot-dash plots. (source: [examples/example_rugplot.m](examples/example_rugplot.m))

![alt text](https://github.com/vsariola/mat-edge-axes/raw/master/images/rugplot.png "Example of a rug plot")
