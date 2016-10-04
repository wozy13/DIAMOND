function bkm = bkm_comp(mmax,u,v)
%
%  Name: bkm_comp
%
%  Usage: bkm = bkm_comp(m,u,v)
%
%  Description: Computes coefficients bkm for conversion
%  		from Forsythe polynomials back to normal
%		polynomials
%

%  Version SWD960409
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

for k = 0:mmax,

    for m = k:mmax

%  First, call bkmcheck to see if recursion formula applies

bv = bkmcheck(k,m);

if bv == -1,

   bv1 = bkmcheck(k-1,m-1);
   bv2 = bkmcheck(k,m-1);
   bv3 = bkmcheck(k,m-2);

   if bv1 == -1,

      bkm1 = bkm(k,m);

   else

      bkm1 = bv1;

   end

   if bv2 == -1,

      bkm2 = bkm(k+1,m);

   else

      bkm2 = bv2;

   end

   if bv3 == -1,

      bkm3 = bkm(k+1,m-1);

   else

      bkm3 = bv3;

   end

   bkm(k+1,m+1) = bkm1 - u(m+1)*bkm2 - v(m)*bkm3;

else

   bkm(k+1,m+1) = bv;

end

end

end

return