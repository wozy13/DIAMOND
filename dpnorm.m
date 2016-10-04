function [realmodes_out,mpf_out] = DPnorm(dppair,realmodes,mpf)
%
%  Name: DPnorm
% 
%  Usage: [realmodes,mpf] = DPnorm(dppair,realmodes,mpf)
% 
%   Description:
%     Executes mass-normalization of mode shapes
%     based on a single driving point FRF
%

%  Version SWD970520
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

nmod = size(realmodes,2);

phin_resp = zeros(size(realmodes));
phin_ref  = zeros(size(mpf));

%
%  Check size of dppair
%

if size(dppair) ~= [1 2],

    disp('ERROR: Driving Point Pair must be Vector of size 1 x 2')
    return

end

respdp = dppair(1);
refdp  = dppair(2);

%
%  Make sure Reference mode shapes are signed so that the DP MPF is positive
%

%for i = 1:size(mpf,2),

%    mpf(:,i) = mpf(:,i) * sign(mpf(refdp,i) * realmodes(respdp,i));

%end


%
%  Compute normalized driving-point value at respdp (refdp) for each mode
%

normval = sqrt(abs(realmodes(respdp,:).*mpf(refdp,:)));

%
%  Compute normalized values at all other DOF using dp as reference value
%

for i = 1:nmod,

    realmodes_out(:,i) = realmodes(:,i) / abs(realmodes(respdp,i)) * normval(i);
    mpf_out(:,i) = mpf(:,i) / abs(mpf(refdp,i)) * normval(i);

end


return
