function [x,fval,exitflag,output,population,score] = kin(fitnessfcn,nvars)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'Display', 'iter');
[x,fval,exitflag,output,population,score] = ...
ga(fitnessfcn,nvars,[],[],[],[],[],[],[],[],options);
