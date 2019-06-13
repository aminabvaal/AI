global nglob nlayer nnu X Y

nglob=5;
nlayer=2;
nnu=10;
load('lo.mat')
 
%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'Display', 'iter');
options = optimoptions(options,'MaxGenerations', 1000);
inintws=[wbest];
options = optimoptions(options,'InitialPopulationMatrix', inintws);


%%
for i=1:(nlayer*nnu+nglob)
   lb(i)=-06.6; 
end
for i=1:nlayer*nnu+nglob
   ub(i)=06.6; 
end
[wbest,fval,exitflag,output,population,score] = ...
ga(@ki,nlayer*nnu+nglob,[],[],[],[],lb,ub,[],[],options);

%%

for jij=1:1000
y(jij)=neronet(wbest,X(jij,:));
Yt(jij)=1/(1+exp(-Y(jij)));
end
plot(Yt)
hold on
plot(y)

%%



% 
%  for j=1:nglob
%         w(j)=1.1*wi(j);
%  end
% for i=1:nlayer
%     for j=1:nnu
%        w((j-1)*nlayer+i+nglob)= ws(j,i);
%     end
% end
% 
% ki(w)






   