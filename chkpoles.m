function [A,B,C,dc,vc,emac] = chkpoles(A,B,C,dc,vc,emac)
%
%  chkpoles
%
%  [A,B,C,dc,vc,emac] = chkpoles(A,B,C,dc,vc,emac)
%
%  Checks the poles of the continuous-time
%  state matrix A to make sure that each
%  appears in a complex conjugate pair,
%  with the 'positive imag.' pole first.
%
%  A,B,C are the continuous state-space model
%  dc are the eigenvalues of A
%  vc are the eigenvectors of A

%  Version SWD960910
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

nx = length(dc);

found=1;

while found,

i = 1;
found = 0;

while i < nx,

  if (dc(i) ~= conj(dc(i+1))) | (abs(dc(i))==0) ,

    if (abs(dc(i))==0), save temp dc, end
    found=1;

%   This is a real or zero pole : remove it

     ks = [1:(i-1),(i+1):nx];

     dc = dc(ks);
     vc = vc(ks,ks);

     A = A(ks,ks);
     B = B(ks,:);
     C = C(:,ks);

     emac = emac(ks);

   elseif imag(dc(i)) < 0,

%   The pole with the neg. imag part is first, switch with the next one

     ks = [1:(i-1), (i+1), i, (i+2):nx];

     dc = dc(ks);
     vc = vc(ks,ks);

     A = A(ks,ks);
     B = B(ks,:);
     C = C(:,ks);
  
     emac = emac(ks);

     i = i+2;

   else

%   The pole is OK

     i = i+2;

   end

nx = length(dc);

end

end

%  if nx is odd, there is a real pole at the end of the sequence

if nx/2 ~= floor(nx/2),

   nx = nx-1;

   ks = [1:nx];

   dc = dc(ks);
   vc = vc(ks,ks);

   A = A(ks,ks);
   B = B(ks,:);
   C = C(:,ks);

   emac = emac(ks);

end

return

