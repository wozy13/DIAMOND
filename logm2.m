function [Y, warning]  = logm2(A, pert)
%LOGM2	LOGM2(X)  is the matrix natural logarithm of  X .    Complex
%	results  are  produced  if  X  has nonpositive eigenvalues.
%	LOGM2  can be thought of as being computed using eigenvalues
%	D  and eigenvectors  V,  such that if  [V,D] = EIG(X)  then  
%	LOGM2(X) = V*log(D)/V.  

%	Copyright (c) 1986-93 by the MathWorks, Inc.

warning = 0;
if ~length(A), Y = []; return; end
[Q,T] = schur(A);
[Q,T] = rsf2csf(Q,T);
dT = diag(T);
F = log(diag(T));

% Set log of zero to large negative number
find_vec = find(~finite(F));
F(find_vec) = -ones(length(find_vec),1).*(1/eps);

F = diag(F);
tol = eps*norm(T,1);
n = max(size(A));
for p = 1:n-1
   for i = 1:n-p
      j = i+p;
      s = T(i,j)*(F(j,j)-F(i,i));
      if p > 1
         k = i+1:j-1;
         s = s + T(i,k)*F(k,j) - F(i,k)*T(k,j);
      end
      d = T(j,j) - T(i,i);
      if abs(d) <= tol,
	 warning = 1;
         d = tol;
      end
      F(i,j) = s/d;
   end
end
Y = Q*F*Q';

% If diagonal elements are the same then check accuracy against expm.
% If accuracy is poor then perturb matrix and call logm2 again.
if (warning)
	tol = tol + eps;
	if  norm(expm(Y) - A, 'inf') > 1e5*tol 
		if nargin ==1, 
			pert = tol; 
		else
			pert = pert * 100
		end
		Y = logm2(A + pert*randn(n,n), pert);
	end
end 
