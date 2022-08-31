%Causal Invariance Theory
%Initialization
cell='AAABBAB';  %Initial Value£ºAAABBB
rule{1}='AB';   %%Rule: AB=BA rule{1} denotes the value to be changed, rule{2} denotes the value after the change
rule{2}='BA';
total_path={};   %Total path
father_path={};  %Parent Node Path
path_num=1;
node_num=1;
%
%
global path_num
global node_num
Fission(cell,rule);






