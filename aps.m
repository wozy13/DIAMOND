function h = aps(G)
%
%   APS
%
%   h = aps(G)
%
%   Computes the Average Power Spectrum (APS)
%   for the FRF matrix 'G'
%   
%   Formula for APS found in: Pappa, Elliott, and Schenk,
%     "Consistent-Mode Indicator for the Eigensystem Realization
%      Algorithm", J. of Guidance, Control and Dynamics, 16(5), 852-858
%      Sept-Oct, 1993.

%  Version SWD970724
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

nlines = size(G,1);
nresp = size(G,2);
nref = size(G,3);

h = zeros(nlines,1);

Hi= zeros(nlines,1);

for iref = 1:nref,
  for iresp = 1:nresp,
    Hi = Hi + abs(G(:,iresp,iref)).^2;
  end
end

h = Hi / (nresp * nref);

return
