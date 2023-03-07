# Orientation Stats [![View Orientation Stats on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/125715-orientation-stats)
Matlab toolbox to compute mean and sd of undirected orientations in 2D, with correct angle-wrapping.

## Author
Abhranil Das & Wilson Geisler, Center for Perceptual Systems, The University of Texas at Austin.

Bugs/comments/questions/suggestions to abhranil.das@utexas.edu.

If you use this code, please cite: [Camouflage Detection & Signal Discrimination: Theory, Methods & Experiments.](http://dx.doi.org/10.13140/RG.2.2.10585.80487)

## Installation
Within Matlab's Home tab, select Add-Ons > Get Add-Ons > Search for 'Orientation Stats' and install.

## Quick Start
After installation, begin with the Getting Started live script with interactive examples, or, at any time, go to Matlab Home tab > Add-Ons > Manage Add-Ons > click the three dots next to this toolbox > View Getting Started Guide

## Documentation
For function help, type:

    doc orientation_stats

## How it Works
When computing the average direction of a set of directed vectors (i.e. with a head and tail), we can simply average the vectors, then take the direction of this average vector. But computing the average of some orientations with no 'sense', i.e. just a line segment with no head or tail, is trickier. For example, consider two orientations: vertical and horizontal. Depending on where you assume their heads and tails to be, the vector average would be either diagonally from bottom left to top right, or diagonally from top left to bottom right. But in reality, these two undirected orientations have no meaningful average since they cancel out.

Now take another example: two orientations that are slightly tilted on either side of the vertical (black lines in image below). Again, depending on what you arbitrarily consider their sense to be, the vector-averaged orientation may turn out to be horizontal. But clearly, the correct answer is vertical (red line).

![image](https://user-images.githubusercontent.com/1142007/223535942-fdd92316-c705-4879-be15-7f6f8e8e67e7.png)


The root of the issue is that when we measure angles, the space these angles live on is the full circle. That is indeed the full space of angles of directed vectors. But the angles of undirected line segments are a smaller space: straight up (12 o' clock) and straight down (6 o' clock) are the same. Since the sense doesn't matter, we can decide to consider all such lines to be pointing, say, towards the right half plane. So the space of these angles is a half-circle, not a full circle. The top of this half-circle (12 o' clock) is the same point as the bottom (6 o' clock). So we can glue the top and bottom of this half-circle together and map this to a circle, which gives us the right topological space of undirected orientations.

Now when computing me
