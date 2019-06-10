%%
clc
clear
close all
m=2000;
times=linspace(0,550*pi,m);
tm=fc(times(1:m));
%%
n=1400;
tt=fc(times(1:n));
T = num2cell(tt);
X = num2cell(times(1:n));
%%
r=10;
t2t=fc(times(n+1-r:m));

Tnew = num2cell(t2t);
Xnew = num2cell(times(n+1-r:m));
%%
net = narxnet(1:2,1:2,[10 10]);
[Xs,Xi,Ai,Ts] = preparets(net,X,{},T);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)


%%
[netc,Xic,Aic] = closeloop(net,Xf,Af);

%%
y2 = netc(Xnew,Xic,Aic);
ynew=cell2mat(y2);

%%
xnew=cell2mat(Xnew);


plot(cell2mat(X),cell2mat(T),'r--')
hold on
plot(xnew,ynew,'g--')
plot(xnew,cell2mat(Tnew),'b--')
