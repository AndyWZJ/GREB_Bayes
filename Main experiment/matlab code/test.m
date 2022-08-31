clc;
N=8;
dag=zeros(N,N);
A=1;S=2;T=3;L=4;B=5;E=6;X=7;D=8;
dag(A,T)=1;
dag(S,[L B])=1;
dag([T L],E)=1;
dag(B,D)=1;
dag(E,[X D])=1;
discrete_nodes=1:N;
node_sizes=2*ones(1,N);
bnet=mk_bnet(dag,node_sizes,'names',{'A','S','T','L','B','E','X','D'},'discrete',discrete_nodes)
bnet.CPD{A}=tabular_CPD(bnet,A,[0.99,0.01])
bnet.CPD{S}=tabular_CPD(bnet,S,[0.5,0.5]);
bnet.CPD{T}=tabular_CPD(bnet,T,[0.99,0.95,0.01,0.05]);
bnet.CPD{L}=tabular_CPD(bnet,L,[0.99,0.9,0.01,0.1]);
bnet.CPD{B}=tabular_CPD(bnet,B,[0.7,0.4,0.3,0.6]);
bnet.CPD{E}=tabular_CPD(bnet,E,[1,0,0,0,0,1,1,1]);
bnet.CPD{X}=tabular_CPD(bnet,X,[0.95,0.02,0.05,0.98]);
bnet.CPD{D}=tabular_CPD(bnet,D,[0.9,0.2,0.3,0.1,0.1,0.8,0.7,0.9])
engine=jtree_inf_engine(bnet)
evidence=cell(1,N)
evidence{A}=1
evidence{S}=2;
evidence{X}=2;
evidence{D}=1
[engine,loglik]=enter_evidence(engine,evidence)
m=marginal_nodes(engine,T)
m.T(2)
m.T(1)
draw_graph(dag)