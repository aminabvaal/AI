clc
clear

for i=1:1000
    X(i,:)=[rand rand rand rand rand];
    Y(i)=tif(X(i,:));
end
plot(Y)
clear i