# Orientation Stats [![View Orientation Stats on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/125715-orientation-stats)
Matlab toolbox to compute mean and sd of orientations (without head or tail) in 2D, with correct angle-wrapping.

## Author
Abhranil Das & Wilson Geisler, Center for Perceptual Systems, The University of Texas at Austin.

Bugs/comments/questions/suggestions to abhranil.das@utexas.edu.

If you use this code, please cite: [Camouflage Detection & Signal Discrimination: Theory, Methods & Experiments.](http://dx.doi.org/10.13140/RG.2.2.10585.80487)

## Installation
Within Matlab's Home tab, select Add-Ons > Get Add-Ons > Search for 'Orientation Stats' and install.

## Getting started
After installation, begin with the Getting Started live script with interactive examples, or, at any time, go to Matlab Home tab > Add-Ons > Manage Add-Ons > click the three dots next to this toolbox > View Getting Started Guide

## Documentation
For function help, type:

    doc orientation_stats

## The math behind this
When computing the average direction of a set of directed vectors (i.e. with a head and tail), we can either measure their angles from some reference axis and average them, or we can average the vectors, then take the direction of this average vector.

But computing the average of some orientations with no 'sense', i.e. just a line segment with no head or tail, is trickier. For example, consider two orientations: vertical and horizontal. Depending on your choice of the reference axis from which you measure angles, or what you assume their 'senses' (head and tail) to be for vector-averaging, the average orientation would be either diagonally from bottom left to top right, or diagonally from top left to bottom right. But in reality, these two undirected orientations have no meaningful average since they cancel out.

Now take another example: two orientations that are slightly tilted on either side of the vertical (black lines in image below). Again, depending on your assumption of the arbitrary reference axis or vector sense, the average orientation may turn out to be horizontal. But clearly, the correct answer here is vertical (red line).

![image](https://user-images.githubusercontent.com/1142007/223535942-fdd92316-c705-4879-be15-7f6f8e8e67e7.png)


The root issue at play here is that when we measure angles of 2D directed vectors, the space these angles live on is a full circle. But the angles of _undirected_ line segments live in a smaller space: Since the sense doesn't matter (every vector direction and its opposite are the same), we can decide to consider all such lines to be pointing, say, towards the right half plane, and can measure their angles within ±90° of the positive x-axis. So the space of these angles is this right half of a circle, not a full circle. The top of this half-circle (+90°) is the same point as the bottom (-90°), so they can be glued together. The metric is uniform across this glued half-circle, so we now map this glued half circle to a full circle, which is the right topological space of undirected orientations. Effectively, this simply means doubling the measured angle from the x-axis.

So when computing the mean of a set of orientations, we measure their angle within ±90° from the positive x-axis, then double it. On this full circle space, every point is unique, so we can now vector-average them like we would for directed vectors. Then we halve the answer to convert it back to the original space.

The standard deviation can also be properly computed by mapping everything to this circle, averaging squared deviations from the mean angle, taking the square root and transforming back. In fact, any other function or measure of undirected orientations can be correctly computed by mapping to this space.

For some more alternative methods to average orientations, see [_On computing the average orientation of vectors and lines, Olson (2011)_](https://ieeexplore.ieee.org/abstract/document/5979562)
