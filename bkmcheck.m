function bv = bkmcheck(k,m)
%
%  Name: bkmcheck
%
%  Usage: bv = bkmcheck(k,m)
%
%  Description: Subroutine of bkm_comp -- checks
%		value of k and m to see which
%		formula applies
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


if k < 0 | k > m,

    bv = 0;

elseif k == m,

    bv = 1;

else

    bv = -1;  % Need to use full formula (or do table lookup)

end


return

