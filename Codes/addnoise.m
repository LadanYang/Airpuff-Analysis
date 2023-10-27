function [noisymat]=addnoise(origmat)

[m, n]= size(origmat);

noisymat=zeros(m, n);

for i=1:m
    for j=1:n
        noisymat(i,j)=origmat(i,j)+normrnd(0, 0.0000001);
    end
end