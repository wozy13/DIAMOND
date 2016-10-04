function [M,C,K]=getsys(m,c,k);

% This function returns the mass(M), damping(C), and stiffness(K)
% matrices for a system of springs, masses and dampers connected 
% in series to ground.




M=diag(m);
N=length(m);

if N==1
  C=c;
  K=k;
else

  C=zeros(N,N);
  K=zeros(N,N);



  for i=1:N
  
    if i==1
      C(1,1:2)=[c(1)+c(2) -c(2)];
      K(1,1:2)=[k(1)+k(2) -k(2)];
    elseif i==N
      C(N,N-1:N)=[-c(N) c(N)];
      K(N,N-1:N)=[-k(N) k(N)];
    else
      C(i,i-1:i+1)=[-c(i) c(i)+c(i+1) -c(i+1)];
      K(i,i-1:i+1)=[-k(i) k(i)+k(i+1) -k(i+1)];
    end

  end

end
