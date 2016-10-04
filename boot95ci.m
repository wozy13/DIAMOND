function bt95 = boot95ci(bootres)
%
%  Name: boot95ci
% 
%  Usage: bt95 = boot95ci(bootres,dim)
% 
%  Description:
%     Compute 95% Confidence interval 'bt95' for bootstrap result vector 'bootres'
%     
%

%  Version SWD970823
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

nd = length(bootres);

bootressrt = sort(bootres);

bootlow = bootressrt(floor(nd*0.025)+1);
boothigh = bootressrt(floor(nd*0.975)+1);

bt95 = (boothigh - bootlow) / 2;

return