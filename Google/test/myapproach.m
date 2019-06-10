close all
clc
clear
% load('news.mat');
bit0=csvread('../BTC_USD_2018-06-04_2019-06-03-CoinDesk.csv',0,2)/150;
bit=bit0(:,1);
bit=diff(bit);
n=30;
m=length(bit);
%%
kk=100;
for ik=1:kk
    
inp=[];
targ=[];
for i=m-1:-1:n+mod(m,n)+1
   for j=1:n
     inp(i-(n+mod(m,n)),n-j+1)=  bit(i-j+1);
   end
   targ(i-(n+mod(m,n)))=bit(i+1);
end
targ=targ';

x = inp';
t = targ';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = [10 25 10];
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 30/100;
net.divideParam.testRatio = 0/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance(ik) = perform(net,t,y);

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotfit(net,x,t)

news(ik)=net(bit(end-n+1:end));
ik
end
sol=mean(news)
(sol+bit0(end,1))*150
hold on
plot(news,'--')
figure(2)
plot(1:kk,zeros(kk),'--')
hold on
h=sort(news);
plot(h,'--')
save('mews','news')
save('performance','performance')