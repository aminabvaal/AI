clc
clear
close all
% % btc=csvread('BTC_USD_2018-05-25_2019-05-24.csv',4,5)
load('btc.mat');
btc=cell2mat(btc)'*10;
n=20;
btc2=num2cell(btc(1:end-n));
% btcnew=num2cell(btc(21:end));
btcnew=num2cell(btc(end-n+1:end));
%  
 
net = timedelaynet([1:8],[10 10]);
net.trainParam.epochs = 1000;
net.divideFcn = '';

[Xs,Xi,Ai,Ts] = preparets(net,num2cell(1:332),btc2);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)



[netc,Xic,Aic] = closeloop(net,Xf,Af);


trainbtc=btc(1:end-n);

plot((1:332),trainbtc,'--')
legend('train real')
hold on

last=450

y2 = netc(num2cell(333:last),Xic,Aic);

tm=cell2mat(btcnew);
yy=cell2mat(y2);

plot((333:352),tm,'r--','DisplayName','real')

hold on
plot((333:last),yy,'c--','DisplayName','prediction')
legend('show')
