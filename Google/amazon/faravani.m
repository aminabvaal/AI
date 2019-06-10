c1=ALL(:,1);
q=zeros(1,length(c1));

minc=min(c1)
maxc=max(c1)

number=(maxc-minc)/1
dol=linspace(minc,maxc,number);
farav=[];
for i=1:number
     farav(i)=0
for j=1:length(c1)
x1=minc+10*i;
x0=minc+10*(i-1);
if c1(j)>x0 && c1(j)<x1
    farav(i)= farav(i)+1;
end
end
end

plot(dol,farav)





