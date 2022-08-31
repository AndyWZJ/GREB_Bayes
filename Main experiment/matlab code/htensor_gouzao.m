%Constructing a hierarchical tensor tree


x = htenrandn([4 4 4]);
a=htenrandn([4 4 4]);
u1 = x.U{2};
u2 = x.U{4};
u3 = x.U{5};
x_begin = full(x);

z = rand(4,3);
x.U{2} = z;
x1_begin = full(x);

z1= rand(5,3);
x.U{2} = z1;
z2 = rand(3,6,1);
x.B{1}=z2;
x2_begin = full(x);

A=10*ones(3,4);
x2 = ttm(x,A,1);
x2_u1=x2.U{2};
uu = u1*A;
% three construction methods to try, will not be the same, the same means that the above B did not above with.... The latter two are the same, indicating that the latter two construction methods are the same, it seems that only U does not work, there must also be B that
% two ideas, one is to change the original basis (can only be modified in the original dimension); the other is to construct their own, their own construction, the lack of B, tomorrow to see
% There is another way of thinking, seven components for the outer product.

help htensor/htensor

% a1=rand(1024,10);
% a2=rand(512,10);
% a3=rand(26,10);
a4=cell(1,3);
a4{1}=u1;
a4{2}=u2;
a4{3}=u3;
a5=htensor(a4);
a_begin = full(a5);

c=htensor({u1,u2,u3});
c_begin = full(c);



% Construct htensor, now it is possible to construct it by yourself, just fill in the four parameters, children, dim2ind, U, B and you can construct it.
%If a 1024*512*26 (the third dimension is time) wants to simulate, and you want to add an extra line in the time dimension yourself, you can modify it on U{5}.
%Change the 26*r matrix of U{5} to 27*r and then reconstruct it to get the result as 1024*512*27, which the 27th is the matrix after the simulation.
% After simulation, all dimensional values remain unchanged except for the added dimensional values £¡£¡£¡£¡
x = htenrandn([4 4 4]);
u = x.U;
b = x.B;
children = x.children;
dim2 = x.dim2ind;
x_begin = full(x);
% u1 = x.U{2};
% u2 = x.U{4};
% u3 = x.U{5};
% b1 = x.B{1};
% b2 = x.B{3};
gouzao_u = x.U;
gouzao_u{5}(5,1)=1;
gouzao_u{5}(5,2)=2;
gouzao_u{5}(5,3)=3;
gouzao_u{5}(5,4)=4;

gouzao=htensor(children,dim2,gouzao_u,b);
gouzao_begin = full(gouzao);



