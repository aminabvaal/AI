function [YS] = neronet(w,x)
global nglob nlayer nnu
y=[0.0];

 for j=1:nglob
        wi(j)=w(j);
 end
for i=1:nlayer
    for j=1:nnu
        ws(j,i)=w((j-1)*nlayer+i+nglob);
    end
end
g=zeros(nlayer,nnu)';
%%
for i=1:nnu
    PP=0.0;
    for j=1:length(x)
       PP=PP+x(j)*wi(j); 
    end
   g(i,1)=1/(1+exp(-PP));
end
for i=2:nlayer
   for k=1:nnu
       PP=0.0;
    for j=1:nnu
       PP=PP+g(j,i-1)*ws(j,i-1); 
    end 
   g(k,i)=1/(1+exp(-PP));
   end
end

 i=nlayer;
   for k=1:length(y)
       PP=0.0;
    for j=1:nnu
       PP=PP+g(j,i)*ws(j,i); 
    end 
   ge(k)=1/(1+exp(-PP));
   end
   
%%
YS=ge;