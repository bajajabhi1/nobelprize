%%%%%
%Nathan Keane
% Simulator with gene frequency = 1 / n;
% k = minimum frequency you want to draw;
%%%%%%

function [sample] = subPopulation_simulator(n,k)
w = -log(k);
sample = exp(w*rand(1,n)- w);
%sample = 1 ./ (unidrnd(w-1,1,n) + rand(1,n)) ;



