%%
clc;clear;close all


s = [1 1 1 2 2 3];
t = [2 3 4 3 4 4];
weights = [6 6.5 7 11.5 12 17]';
code = {'1-44__1-3' '1-49__1-34' '1-49__1-34' '1-49__1-34' '1-49__1-34' '1-49__1-34'}';
EdgeTable = table([s' t'], weights, code, 'VariableNames', {'EndNodes' 'Weight' 'Code'})

names = {'USA' 'GBR' 'DEU' 'FRA'}';
country_code = {'1' '44' '49' '33'}';
NodeTable = table(names,country_code,'VariableNames',{'Name' 'Country'})

G = digraph(EdgeTable, NodeTable);
plot(G,'NodeLabel',G.Nodes.Country,'EdgeLabel',G.Edges.Code)
% plot(G)

%%
clc;clear;close all
% Activity (Edge)
s = [0 0 1 2 [4 6] 2 3 [5 7]];
t = [1 2 3 4 [5 5] 6 7 [8 8]];
s = s+1;
t = t+1;
duration = [7 3 6 3 [3 3] 2 3 [2 2]];
ActivityTable = table([s' t'], duration', 'VariableNames', {'EndNodes', 'Duration'})

% Node
names = {'Start', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
NodeTable = table(names', 'VariableNames', {'Name'})

G = digraph(ActivityTable, NodeTable);
plot(G, 'NodeLabel', G.Nodes.Name)