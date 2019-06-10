%%
clc
% clear
% close all
% ALL=[];

for kkk=1:300
 
btc_time=csvread('btc_hours3.csv',0,3);

n=10;
nv=10;
m=2001;

%%
cc=btc_time(1:m,2);
gg=(cc-mean(cc))/std(cc);

for i=1:length(gg)
    ff(i)=(1)/(1+exp(-gg(i)));
end

btc_time(:,2)=ff;
btc_time(:,1)=(1:m)';

%%

T = num2cell(btc_time(1:m,2))';
X = num2cell(btc_time(1:m,1))';
%%
% r=10;
% Tvalid = num2cell(btc_time(m+1-r:m+n,2))';
% Xvalid = num2cell((m+1-r:m+n));
%%
r=20;
% Tnew = num2cell(btc_time(m+1-r:m+n,2))';
Xnew = num2cell((m+1:m+n));
%%
net = narxnet(1:r,1:r,[10 10 10]);
net.divideFcn='divideind';
net.divideParam.trainInd=1:m-r-nv;
net.divideParam.valInd=m-r-nv+1:m;
net.divideParam.testInd=[];
net.layers{1}.transferFcn='poslin';
net.layers{2}.transferFcn='poslin';
net.layers{3}.transferFcn='poslin';
%%

[Xs,Xi,Ai,Ts] = preparets(net,X,{},T);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)
%%
[netc,Xic,Aic] = closeloop(net,Xf,Af);

%%
y2 = netc(Xnew,Xic,Aic);
ynew=cell2mat(y2);
ynew2 =-1*log(1./ynew-1);
yyy=ynew2.*std(cc)+mean(cc);

ALL=[ALL;yyy];
%%
xnew=cell2mat(Xnew);
% figure(1)
% plot(cell2mat(X),cell2mat(T),'r--')
hold on
figure(2)
plot(xnew,yyy,'--')
hold on
% plot(xnew,cell2mat(Tnew),'b--')

end

