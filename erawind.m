function erawind
%
%  Name: erawind
% 
%  Usage: erawind
% 
%  Description:
%    Initializes the DIAMOND main
%    figure for ERA analysis
%

%
%  Version SWD970907
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

global HANDLES MODES

%
% Activate the appropriate handles
%

hideallbtns
showall(HANDLES.herab)

MODES.eraparam.q = 10;
MODES.eraparam.d = 50;
MODES.eraparam.nx = 30;

set(HANDLES.herab(5),'string',num2str(MODES.eraparam.q))
set(HANDLES.herab(7),'string',num2str(MODES.eraparam.d))
set(HANDLES.herab(9),'string',num2str(MODES.eraparam.nx))

return