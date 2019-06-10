er=[]
for kkj=1:200

close all

ff=csvread('btc_hours2.csv',1,3);

timestamp=ff(1000:end,1)/1e9;

n=20;

btc=ff(1000:end,2)/1000;
% plot(timestamp,btc)


btcnew=num2cell(btc(end-n+1:end))';
btc2=num2cell(btc(1:end-n))';
times=num2cell(timestamp(1:end-n))';

%  
 
net = timedelaynet([1:10],[10 10 10]);
net.trainParam.epochs = 1000;
net.divideFcn = '';

[Xs,Xi,Ai,Ts] = preparets(net,btc2,btc2);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)



[netc,Xic,Aic] = closeloop(net,Xf,Af);



y2 = netc((btcnew),Xic,Aic);
yy=cell2mat(y2)

tm=cell2mat(btcnew);

error=(sum((tm-yy).*(tm-yy)))^00.5
er=[er error];
if error <=1.0
   break 
end

plot(1:n,tm,'r--','DisplayName','real')
hold on
plot(1:n,yy,'c--','DisplayName','validation')
legend('show')


end
