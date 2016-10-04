function popupstr = buildfreqpopup
%
%  Name:   
%
%  Usage: 
%
%  Builds a popup menu string of the identified modes and frequencies
% 

%  Version SWD970819
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

global MODES

popupstr = sprintf('#%2d %5.2fHz %4.2f%%',1,MODES.Freq{1},MODES.Damp{1}*100);

for i = 2:MODES.nmodes
   popupstr = [popupstr, sprintf('%1s#%2d %5.2fHz  %4.2f%%','|',i,MODES.Freq{i},MODES.Damp{i}*100)];
end   

return