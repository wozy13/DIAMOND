function [P,u,v] = forsythe(xi,q,m)
%
%  Name: forsythe
%
%  Usage: [P,u,v] = forsythe(xi,q,m)
%
%  Description: Generates orthogonal Forsythe
%		polynomials over the domain 'xi'
%		with the weights 'q' of order 'm'
%
%		Returns matrix 'P', which has 
%		size (L x m+1). (L = length(xi))
%		and normalization factors 'u' and
%		'v'
%

%  Version SWD960507
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab source code was originally     %
% developed as part of "DIAMOND" at          %
% Los Alamos National Laboratory. It may     %
% be copied, modified, and distributed in    %
% any form, provided:                        %
%  a) This notice accompanies the files and  %
%     appears near the top of all source     %
%     code files.                            %
%  b) No payment or commercial services are  %
%     received in exchange for the code.     %
%                                            %
% Original copyright is reserved by the      %
% Regents of the University of California,   %
% in addition to Scott W. Doebling, Phillip  %
% J. Cornwell, Erik G. Straser, and Charles  %
% R. Farrar.                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L = length(xi);
P = zeros(L,m+1);
u = zeros(m+1,1);
v = zeros(m+1,1);
      
%
% Define zero-th order poly.
%

P(:,1) = ones(L,1);

%
% Define first order poly.
%
      
d(1) = sum( P(:,1).^2 .* q.^2);
u(2) = sum( xi .* P(:,1).^2 .* q.^2) / d(1);

P(:,2) = (xi - u(2)) .* P(:,1);

%
% Define higher-order polys.
%

for k = 3:(m+1),

   d(k-1) = sum( P(:,k-1).^2 .* q.^2);

   v(k-1) = sum( xi .* P(:,k-1) .* P(:,k-2) .* q.^2) / d(k-2);

   u(k) = sum( xi .* P(:,k-1).^2 .* q.^2) / d(k-1);
   
   P(:,k) = (xi - u(k)) .* P(:,k-1) - v(k-1) .* P(:,k-2);

end
      
d(m+1) = sum( P(:,m+1).^2 .* q.^2);

return