clc
clear
close all

ff=csvread('btc_hours2.csv',1,3);

timestamp=ff(:,1)/1e9;

n=50;

btc=ff(:,2)/1000;
% plot(timestamp,btc)


btcnew=num2cell(btc(end-n+1:end))';
btc2=num2cell(btc(1:end-n))';
times=num2cell(timestamp(1:end-n))';

%  
 
net = timedelaynet([1:20],[10 10 10]);
net.trainParam.epochs = 1000;
net.divideFcn = '';

[Xs,Xi,Ai,Ts] = preparets(net,times,btc2);
net = train(net,Xs,Ts,Xi,Ai);

[Y,Xf,Af] = net(Xs,Xi,Ai);
perf = perform(net,Ts,Y)



[netc,Xic,Aic] = closeloop(net,Xf,Af);


trainbtc=btc(1:end-n);

figure(2)
% 
% plot(timestamp(1:end-n),trainbtc,'--')
% legend('train real')
% hold on

ttg=timestamp(end-n+1:end)';



for i=1:10
   ttg(end+1)=ttg(end)+3600*(i)/1e9; 
end

% y2 = netc(num2cell(timestamp(end-n+1:end))',Xic,Aic);

yy=[];
for i=1:3
    
y2 = netc(num2cell(ttg(20*(i-1)+1:(20*(i)))),Xic,Aic);
yy=[yy cell2mat(y2)];
end



tm=cell2mat(btcnew);


for i=1:10
   ttt(i)=ff(end,1)+3600*(i-1); 
end

tttcell=num2cell(ttt./1e9);

y3= netc(tttcell,Xic,Aic);
y3=cell2mat(y3);




plot(timestamp(end-n+1:end)',tm,'r--','DisplayName','real')
hold on
plot(ttg,yy,'c--','DisplayName','prediction')
legend('show')
hold on
plot(ttt./1e9,y3,'g--','DisplayName','prediction')
legend('show')


