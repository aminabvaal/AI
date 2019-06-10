clc
clear
% T = simplenar_dataset;
times=linspace(0,355*pi,3000);
ttnew=fc(times);
T=num2cell(ttnew);



net = narnet(1:2,10);
[Xs,Xi,Ai,Ts] = preparets(net,{},{},T);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)

[netc,Xic,Aic] = closeloop(net,Xf,Af);
m=1000
f=cell(0,m)
y2 = netc(f,Xic,Aic);
ttt=cell2mat(T);

plot(ttt)
hold on
plot(length(ttt)+1:length(ttt)+m,cell2mat(y2))


