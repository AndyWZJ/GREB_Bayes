function outdata = scala_threedim(indata, out_size)
%%%Tensor resampling
%%The input is a 3D array, let's say 144 by 73 by 50, and the output is a scaled 3D array let's say 96 by 48 by 50
[a b c]=size(indata);
o1=out_size(2);
o2=out_size(1);
for i=1:c
    outdata(:,:,i) = scale(indata(:,:,i),[o1 o2]);
end

end