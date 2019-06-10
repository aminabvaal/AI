btc_time=csvread('btc_hours3.csv',0,3);
cc=btc_time(1:m,2);
gg=(cc-mean(cc))/std(cc);

for i=1:length(gg)
    ff(i)=(1)/(1+exp(-gg(i)));
end
