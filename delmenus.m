function delmenus
%
%  Name: delmenus.m
% 
%  Usage: delmenus
% 
%  Description:
%     Deletes existing menus
%

%  Version SWD970804
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
%

global HANDLES

%
%  Delete existing menus
%

for i = 1:length(HANDLES.hmmenu),
   if ishandle(HANDLES.hmmenu{i}),
      delete(HANDLES.hmmenu{i})
   end
end

return