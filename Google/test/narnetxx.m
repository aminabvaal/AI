clc
clear

%%
m=2000;
times=linspace(0,55*pi,m);
tm=fc(times(1:m));
plot(1:m,tm,'r--')
%%

n=1500;
tt=fc(times(1:n));

T = num2cell(tt);
X = num2cell(times(1:n));

%%
r=2;
t2t=fc(times(n+1-r:m));

Tnew = num2cell(t2t);
Xnew = num2cell(times(n+1-r:m));

%%
d1 = [1:r];
d2 = [1:r];
narx_net = narxnet(d1,d2,[10 10 10]);
narx_net.divideFcn = '';
narx_net.trainParam.min_grad = 1e-10;
[p,Pi,Ai,t] = preparets(narx_net,X,{},T);

[p2,Pi2,Ai2,t2] = preparets(narx_net,Xnew,{},Tnew);
narx_net = train(narx_net,p,t,Pi);

yp = sim(narx_net,p2,Pi2);
e = cell2mat(yp)-cell2mat(t2);


%%
narx_net_closed = closeloop(narx_net);


%%
hold on
plot(n+1:m,cell2mat(yp),'g--','DisplayName','predict')
hold on
plot(n+1:m,cell2mat(Tnew(3:end)),'b--','DisplayName','real')
hold on
plot(n+1:m,(randingpred(3:end)),'--','DisplayName','randingpred')
legend('show')

