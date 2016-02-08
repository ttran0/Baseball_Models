clc
clear all
A = readtable('ColeHamelspbp_09.csv','ReadVariableNames',false);
num_games = size(A)-1;
y = table2array(A(30,2:end-1));
na_val = strcmp(y,'NA');
% index = find([na_val{:}] =='1');
index = find(na_val==0);
dat = str2double(y(index));

