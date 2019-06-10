times(n+1:2000)clc
clear

times=linspace(0,5*pi,2000);

n=1250;
Xnew = num2cell(times(n+1:2000));

X = num2cell(times(1:n));
tt=sin((times(1:n)))./(2.5+cos(times(1:n)));
ttnew=sin((times(n+1:2000)))./(2.5+cos(times(n+1:2000)));
T = num2cell(tt);
Tnew = num2cell(ttnew);

net = timedelaynet(1:5,10);
[Xs,Xi,Ai,Ts] = preparets(net,T,T);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)

[netc,Xic,Aic] = closeloop(net,Xf,Af);

y2 = netc(Tnew,Xic,Aic);
yy=cell2mat(y2);

plot(cell2mat(Xnew),yy)
hold on
plot(cell2mat(Xnew),sin((cell2mat(Xnew)))./(2.5+cos(cell2mat(Xnew))),'--')
