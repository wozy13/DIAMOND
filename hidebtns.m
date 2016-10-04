function hidebtns(hbtns)
%  Name:   hidebtns
%
%  Usage:  hidebtns(hbtns)
%
%	Description: Hides the buttons whose
%	handles are 'hbtns', after storing
%	their current state in their user
%	data variables  
%
%
%

%  Version SWD960822
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
%  Store current state in user data
%

for i = 1:length(hbtns),
    set(hbtns(i),'userdata',get(hbtns(i),'visible'))
end

set(hbtns,'visible','off')
