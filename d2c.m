function [a, b] = d2c(phi, gamma, t)
%D2C	Conversion of state space models from discrete to continuous time.
%	[A, B] = D2C(Phi, Gamma, T)  converts the discrete-time system:
%
%		x[n+1] = Phi * x[n] + Gamma * u[n]
%
%	to the continuous-time state-space system:
%		.
%		x = Ax + Bu
%
%	assuming a zero-order hold on the inputs and sample time T.
%
%	See also: D2CM and C2D.

%	J.N. Little 4-21-85
%	Copyright (c) 1986-93 by the MathWorks, Inc.
%	Revised 9-22-88 JNL  Phi=1 case fixed,
%	10-17-90 A.Grace Better logm, and handles rows of zeros in gamma.

error(nargchk(3,3,nargin));
error(abcdchk(phi,gamma));

[m,n] = size(phi);
[m,nb] = size(gamma);

% phi = 1 case cannot be computed through matrix logarithm.  Handle
% as a special case.
if m == 1
	if phi == 1
		a = 0; b = gamma/t;
		return
	end
end

% Remove rows in gamma that correspond to all zeros
b = zeros(m,nb);
nz = 0;
nonzero = [];
for i=1:nb
	if any(gamma(:,i)~=0) 
		nonzero = [nonzero, i];
		nz = nz + 1;
	end
end

% Do rest of cases using matrix logarithm.

s = logm2([[phi gamma(:,nonzero)]; zeros(nz,n) eye(nz)])/t;
if norm(imag(s),'inf') > sqrt(eps); 
	disp('Warning: Accuracy of d2c conversion may be poor.')
end
s = real(s);
a = s(1:n,1:n);
if length(b)
	b(:,nonzero) = s(1:n,n+1:n+nz);
end
