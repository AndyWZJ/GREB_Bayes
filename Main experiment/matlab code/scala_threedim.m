function outdata = scala_threedim(indata, out_size)
%%%Tensor resampling
%%Input is a 3D array assumed to be 144*73*50, output is a scaled 3D array assumed to be 96*48*50
[a b c]=size(indata);
o1=out_size(2);
o2=out_size(1);
for i=1:c
    outdata(:,:,i) = scale(indata(:,:,i),[o1 o2]);
end

end