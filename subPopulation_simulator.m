%%%%%
%Nathan Keane
% Simulator with gene frequency = 1 / n;
%%%%%

function [sample] = subPopulation_simulator(n,w)

%sample = exp(w*rand(1,n)- w);
sample = 1 ./ (unidrnd(w-1,1,n) + rand(1,n)) ;



