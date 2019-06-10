function [ttnew] = fc(times)

ttnew=sin((2*pi*times/1540+pi/54))./(2.5+cos(2*pi*times/150+pi/4)).^2;
end

