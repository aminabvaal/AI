clc
clear
close all

times=linspace(0,5*pi,2000);

global n
n=500;
Xnew = num2cell(times(n+1:2000));

X = num2cell(times(1:n));
tt=fc(times(1:n));
ttnew=fc(times(n+1:2000));
T = num2cell(tt);
Tnew = num2cell(ttnew);

net = timedelaynet(1:10,10);
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)

[netc,Xic,Aic] = closeloop(net,Xf,Af);

y2 = netc(Xnew,Xic,Aic);
yy=cell2mat(y2);

plot(cell2mat(Xnew),yy,'--')
hold on
plot(cell2mat(Xnew),fc(cell2mat(Xnew)),'--')


plot(cell2mat(X),(cell2mat(T)),'g--')

