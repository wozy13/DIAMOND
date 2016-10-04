function eraconv
%
%  Name: eraconv
%
%  Function: eraconv
%
%  Description:
%
%    Initializes the era convergence window
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

global MODES HANDLES

%  Make the ERA convergence window visible

set(HANDLES.herac(1),'visible','on')

%  Initialize the variable values

if ~isfield(MODES.eraparam,'nxlow')
   MODES.eraparam.nxlow = 10;
end

if ~isfield(MODES.eraparam,'nxhigh')
   MODES.eraparam.nxhigh = 100;
end

if ~isfield(MODES.eraparam,'dnx')
   MODES.eraparam.dnx = 10;
end

%  Initialize the edit text boxes

set(HANDLES.herac(6),'string',num2str(MODES.eraparam.q))

set(HANDLES.herac(8),'string',num2str(MODES.eraparam.d))

set(HANDLES.herac(10),'string',num2str(MODES.eraparam.nx))

set(HANDLES.herac(13),'string',num2str(MODES.eraparam.nxlow))

set(HANDLES.herac(15),'string',num2str(MODES.eraparam.nxhigh))

set(HANDLES.herac(17),'string',num2str(MODES.eraparam.dnx))

return