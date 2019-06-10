clc
clear

[X,T] = simpleseries_dataset;




% plot(cell2mat(X),cell2mat(T),'*')
% pause
Xnew = X(81:100);
Tmew=T(81:100);


X = X(1:80);
T = T(1:80);

net = timedelaynet(1:2,10);
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y);



[netc,Xic,Aic] = closeloop(net,Xf,Af);


y2 = netc(Xnew,Xic,Aic);

tm=cell2mat(Tmew);
yy=cell2mat(y2);

plot(cell2mat(Xnew),tm,'r*')
hold on
plot(cell2mat(Xnew),yy,'b*')




