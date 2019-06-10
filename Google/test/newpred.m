bit=csvread('../BTC_USD_2018-05-25_2019-05-24.csv',4,5)/1000;
TBit = num2cell(bit');
m=length(bit);
n=m-20;

%%
X = num2cell((1:n));
T = num2cell(TBit(1:n));

%%
r=2;
Tnew = num2cell(TBit(n+1-r:m));
Xnew = num2cell((n+1-r:m));

%%
d1 = 1:r;
d2 = 1:r;
narx_net = narxnet(d1,d2,[10 10 10]);
narx_net.divideFcn = '';
narx_net.trainParam.min_grad = 1e-10;
[p,Pi,Ai,t] = preparets(narx_net,X,{},T);
[p2,Pi2,Ai2,t2] = preparets(narx_net,Xnew,{},Tnew);
narx_net = train(narx_net,p,t,Pi);

yp = sim(narx_net,p2,Pi2);
e = cell2mat(yp)-cell2mat(t2);

%%
hold on
plot(n+1:m,cell2mat(yp),'--')
hold on
plot(n+1:m,cell2mat(Tnew(3:end)),'b--','DisplayName','predict')



