%Construct a layer of tensor tree


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
%Try the three constructive methods, will it be the same, just say that the above B is not used above. Essence Essence The latter two are the same, which shows that the latter two structures are the same. It seems that only U can not work, and there must be B.
%Two ideas, one is changed on the basis of the original (can only be modified in the original dimension); the other is to construct it by itself.
%There is also a kind of idea, seven components of accumulation.

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

%Construction HTENSOR, now it can be constructed by itself. As long as the four parameters, Children, DIM2IND, U, B fill it up, it can be constructed.
%If a 1024*512*26 (the third dimension is time) If you want to simulate, you want to add one more on the time dimension and you can modify it on u {5}.
%Turn the 26*R matrix of u {5} to 27*R, and then the reconstruction, the result is 1024*512*27, which is the simulation matrix.
%After simulation, except for the increased dimension value, the remaining dimensions have not changed! Intersection Intersection Intersection
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



