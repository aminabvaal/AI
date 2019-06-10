clc
clear
% btc=csvread('BTC_USD_2018-05-25_2019-05-24.csv',4,5)
load('btc.mat');
 btc=cell2mat(btc)'*10;
btc=num2cell(btc);
 
ftdnn_net = timedelaynet([1:8],[10 10]);
ftdnn_net.trainParam.epochs = 2000;
ftdnn_net.divideFcn = '';

% p = btc(9:end);
% t = btc(9:end);
% Pi=btc(1:8);
[p,Pi,Ai,t] = preparets(ftdnn_net,btc,btc);

ftdnn_net = train(ftdnn_net,p,t,Pi);

[netc,Xic,Aic] = closeloop(net,Xf,Af);



yp = ftdnn_net(p,Pi);
e = gsubtract(yp,t);
rmse = sqrt(mse(e))

