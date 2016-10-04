function [a,b]=d2cmatt(ad,bd,T)

[m,n]=size(ad);
[m,nb]=size(bd);
s=logm([ad bd;zeros(nb,n) eye(nb)]);
s=s/T;
a=real(s(1:n,1:n));
b=real(s(1:n,n+1:n+nb));