function anmodwindow
%
%  Name:   anmodwindow
%
%  Usage:  anmodwindow
%
%  Activates the buttons for analyzing the modes
% 

%  Version SWD970805
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

global HANDLES MODES imode

%  Configure the DIAMOND buttons

hideallbtns
showall(HANDLES.hanalmodb)

if isempty(imode)
   imode = 1;
end

set(HANDLES.hanalmodb(4),'string',num2str(imode))

set(HANDLES.hanalmodb(13),'string',buildfreqpopup)
set(HANDLES.hanalmodb(13),'value',imode)

set(HANDLES.hanalmodb(15),'visible','off')

if ~isfield(MODES,'imnmeth')
   MODES.imnmeth = 'Drive Point';
elseif isempty(MODES.imnmeth)
   MODES.imnmeth = 'Drive Point';
end

switch MODES.imnmeth,
case 'Drive Point', set(HANDLES.hanalmodb(11),'value',1)
case 'Unit Mass', set(HANDLES.hanalmodb(11),'value',2)
end

if ~isfield(MODES,'dppair')
   MODES.dppair = [1 1];
elseif isempty(MODES.dppair)
   MODES.dppair = [1 1];
end

set(HANDLES.hanalmodb(9),'string',num2str(MODES.dppair))

return