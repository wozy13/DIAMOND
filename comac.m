function CM = comac(modes1,modes2)
%
%  Name: comac
% 
%  Usage: comac(modes1,modes2)
% 
%   Description:
%     Plots the COMAC of modal sets modes1 and modes2
%
%	

%  Version SWD970916
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

nmodes1 = size(modes1,2);
nmodes2 = size(modes2,2);

nmodes = min(nmodes1,nmodes2);

CM = zeros(size(modes1,1),1);

for i = 1:size(modes1,1),
   
   CM(i) = 1 - sum(abs(modes1(i,1:nmodes) - modes2(i,1:nmodes))) / (2*nmodes);
   
end

return