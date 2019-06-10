%%
clc
clear
close all
btc_time=csvread('btc_hours3.csv',0,3);
n=10;
n2=10;
m=2001;

btc_time(:,1)=btc_time(:,1)/1558980000.0;
btc_time(:,2)=btc_time(:,2)/1000;

btc_time(:,1)=(1:m)';

tm=btc_time(:,2)/1000;
%%

T = num2cell(btc_time(1:m-n,2))';
X = num2cell(btc_time(1:m-n,1))';
%%
% r=10;
% Tvalid = num2cell(btc_time(m+1-r:m+n,2))';
% Xvalid = num2cell((m+1-r:m+n));
%%
r=5;
% Tnew = num2cell(btc_time(m+1-r:m+n,2))';
Xnew = num2cell((m+1:m+n));
%%
net = narxnet(1:r,1:r,[10 10]);
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
plot(xnew,ynew,'g*')
% plot(xnew,cell2mat(Tnew),'b--')
