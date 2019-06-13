clc
clear
load('lo.mat')

nlayer=2;
nnu=10;
ws=0.5*ones(nlayer,nnu)';

g=zeros(nlayer,nnu)';

wi=0.5*ones(5,1);

for i=1:length(nlayer)
    for j=1:nnu
   ws(j,i)=2*rand -1 ;
    end
end

for i=1:length(wi)
   wi(i)=2*rand -1 ;
end

%%
YS=[];
for jij=1:1000

x=X(jij,:);
Y2(jij)=1/(1+exp(-Y(jij)));
y=Y2(jij);

gi=x';
ge=y';


%%
for i=1:nnu
    PP=0.0;
    for j=1:length(x)
       PP=PP+x(j)*wi(j); 
    end
   g(i,1)=1/(1+exp(-PP));
end

%%
for i=2:nlayer
   for k=1:nnu
       PP=0.0;
    for j=1:nnu
       PP=PP+g(j,i-1)*ws(j,i-1); 
    end 
   g(k,i)=1/(1+exp(-PP));
   end
end
%%
 i=nlayer;
   for k=1:length(y)
       PP=0.0;
    for j=1:nnu
       PP=PP+g(j,i)*ws(j,i); 
    end 
   ge(k)=1/(1+exp(-PP));
   end

   
   YS(jij)=ge;
   
end

error=1/2*(YS-Y2)*(YS-Y2)'
   
plot(YS)
hold on
plot(Y2)
   
   


