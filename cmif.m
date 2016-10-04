function h = cmif(G)
%
%   CMIF
%
%   h = cmif(G)
%
%   Computes the Complex Mode Indicator Function (CMIF)
%   for the FRF matrix 'G'
%
%   G has dimensions nlines x nresp x nref

%  Version SWD970728
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

h = zeros(nref,nlines);

for i = 1:nlines,

   h(:,i) = svd(abs(squeeze(G(i,:,:))));

end

return
