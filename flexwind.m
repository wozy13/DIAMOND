function flexwind
%
%  Name:   flexwind
%
%  Usage:  flexwind
%
%  Starts up the flexibility analysis window
% 

%  Version SWD970830
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
%  Activate the  Handle Vector
%

global HANDLES DAMAGEID GEOM

hideallbtns
showall(HANDLES.hflexb)

DAMAGEID.haxes = HANDLES.hflexb(2);
DAMAGEID.hlegax = HANDLES.hflexb(15);

%
%  Initialize the mode selection window
%

mdslinit

%
%  Initialize the flexibility buttons
%

DAMAGEID.nflexload = 'Multi Point';
DAMAGEID.iflextype = 'Flexibility Change';
DAMAGEID.iflexsgn = 1;

set(HANDLES.hflexb(8),'value',2)
set(HANDLES.hflexb(4:5),'visible','off')
set(HANDLES.hflexb(6),'value',1)

% Initialize the geometry display attributes

if ~isfield(GEOM,'inodelab'),
   GEOM.inodelab = 0;
end
if ~isfield(GEOM,'nodelnco'),
   GEOM.nodelnco = 'g';
end
if ~isfield(GEOM,'nodelabsz'),
   GEOM.nodelabsz = 12;
end

if ~isfield(GEOM,'ibarlab'),
   GEOM.ibarlab = 0;
end
if ~isfield(GEOM,'barlnco'),
   GEOM.barlnco = 'y';
end
if ~isfield(GEOM,'barlnst'),
   GEOM.barlnst = '-';
end
if ~isfield(GEOM,'barlabsz'),
   GEOM.barlabsz = 12;
end

return