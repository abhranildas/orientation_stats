function theta_s=standard_orientation(theta)
    % standardize the orientation to an angle between
    % -pi/2 and pi/2 of the positive x-axis

    % first wrap to [-pi,pi]:
    theta_s=wrapToPi(theta);

    % convert to a vector towards the right:
    quad_2=(theta_s>pi/2)&(theta_s<=pi);
    theta_s(quad_2)=theta_s(quad_2)-pi;

    quad_3=(theta_s<-pi/2)&(theta_s>=-pi);
    theta_s(quad_3)=theta_s(quad_3)+pi;