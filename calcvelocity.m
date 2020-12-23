function [dotproduct,velocity,normvelo,omega]=calcvelocity(TEMP,FrameRate,n)
if nargin==2
    n=1;
end
    for i=1:length(TEMP) 
        Ax = TEMP(i).x(1:length(TEMP(i).x)-1);
        Bx = TEMP(i).x(2:length(TEMP(i).x));
        Ay = TEMP(i).y(1:length(TEMP(i).y)-1);
        By = TEMP(i).y(2:length(TEMP(i).y));
        Az = TEMP(i).z(1:length(TEMP(i).z)-1);
        Bz = TEMP(i).z(2:length(TEMP(i).z));
        dx = Bx-Ax;  
        dy = By-Ay;
        dz = Bz-Az;
        dr = sqrt(dx.^2+dy.^2+dz.^2);
        dotproduct(i).d=(dx(1:length(dx)-n).*dx(n+1:length(dx))+dy(1:length(dy)-n).*dy(n+1:length(dy))+dz(1:length(dz)-n).*dz(n+1:length(dz)))./(dr(1:length(dr)-n).*dr(n+1:length(dr)));
        velocity(i).v = dr*FrameRate*5.3/20.0;
        normvelo(i).v = (velocity(i).v-min(velocity(i).v))/(max(velocity(i).v)-min(velocity(i).v));
        omega(i).o = acosd(dotproduct(i).d)*FrameRate/n;

    end
