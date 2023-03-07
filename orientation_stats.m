function [theta_m,theta_s,length_m]=orientation_stats(thetas,lengths)

    % ORIENTATION_STATS Given a set of orientations (undirected line
    % segments), this computes the (vector) average orientation
    % (optionally weighted by lengths), the length of the vector average
    % (measuring the coherence of the orientations), and the sd of
    % the orientations, properly taking care of the angular wrapping for
    % undirected orientation vectors.
    % For more info on how these are mathematically computed, see the
    % ReadMe for the toolbox, or on <a href="matlab:web('https://github.com/abhranildas/orientation_stats')"
    % >github</a>.
    %
    % Abhranil Das <abhranil.das@utexas.edu> & Wilson Geisler
    % Center for Perceptual Systems, University of Texas at Austin.
    % If you use this code, please cite:
    % <a href="matlab:web('http://dx.doi.org/10.13140/RG.2.2.10585.80487')"
    % >Camouflage Detection & Signal Discrimination: Theory, Methods & Experiments</a>.
    %
    % Usage:
    % [theta_m,theta_s,length_m]=orientation_stats(thetas);
    % [theta_m,theta_s,length_m]=orientation_stats(thetas,lengths);
    %
    % Example:
    % thetas=[0;pi/4];
    % [theta_m,theta_s,length_m]=orientation_stats(thetas)
    %
    % thetas=[0;pi/4]; lengths=[1;2];
    % [theta_m,theta_s,length_m]=orientation_stats(thetas,lengths)
    %
    % Inputs:
    % thetas    column vector of orientations (angles measured from the 
    %           positive x-axis) in radians. Directionality (tail-to-head
    %           or head-to-tail) is ignored by automatically converting
    %           to a vector pointing towards the right (-pi/2 through pi/2
    %           from the positive x-axis, i.e. 12 to 6 o' clock).
    % lengths   (optional) column vector of lengths of the line segments.
    %           When passed, they are used as weights for the vector
    %           averaging to find the mean orientation and length, and sd.
    %           When not passed, all lengths are assumed to be 1.
    %
    % Outputs:
    % theta_m   (vector) average orientation, in radians from the positive
    %           x-axis
    % length_m  length of the vector-averaged orientation, measuring the
    %           coherence of the orientations. If this is 0, the input
    %           orientations exactly cancel out, and theta_m is meaningless
    % theta_s   sd of the orientations around the mean

    % standardize orientations:
    thetas=standard_orientation(thetas);

    % map orientations from half to full circle:
    theta_d=2*thetas;

    % then vector-average them to find doubled mean:
    x=[cos(theta_d) sin(theta_d)];
    if nargin==1
        lengths=ones(size(thetas));
    end
    x_m=mean(lengths.*x);
    theta_md=atan2(x_m(2),x_m(1));

    % map mean back to half circle:
    theta_m=theta_md/2;

    % return vector-averaged length:
    if nargout==3
        length_m=norm(x_m);
    end

    if nargout>1
        % for sd, find diff of angles from mean angle on the full circle:
        theta_diff=wrapToPi(theta_d-theta_md);

        % then take RMS of diffs:
        theta_s=rms(theta_diff);

        % map this back to half circle:
        theta_s=theta_s/2;
    end