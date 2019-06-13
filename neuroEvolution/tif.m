function [f] = tif(x)

f=0.0;
for i=1:length(x)
  f=f+sin(x(i));
end

end

