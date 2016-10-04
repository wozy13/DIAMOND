function editgeom
%
%  Name: editgeom.m
% 
%  Usage: editgeom.m
% 
%   Description:
%     Interactive Definition
%     of Nodes as well as Bar and Shell Connectivity
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

global EDITGEOM GEOM HANDLES

if ~isfield(EDITGEOM,'ilab'),
   EDITGEOM.ilab = [1 0 0 0 0 0];
end
GEOM.inodelab = EDITGEOM.ilab(1);
GEOM.ibarlab = EDITGEOM.ilab(2);
GEOM.itracelab = EDITGEOM.ilab(6);

GEOM.nodelnco = 'g';
GEOM.nodelabsz = 14;

GEOM.barlnco = 'y';
GEOM.barlnst = '-';
GEOM.barlabsz = 14;

if ~isfield(EDITGEOM,'nselsw'), 
   EDITGEOM.nselsw = 1; 
end

if ~isfield(GEOM,'Nodes'), GEOM.Nodes = []; end
if ~isfield(GEOM,'Bars'), GEOM.Bars = []; end
if ~isfield(GEOM,'SEMbeams'), GEOM.SEMbeams = {}; end
if ~isfield(GEOM,'SEMquads'), GEOM.SEMquads = {}; end
if ~isfield(GEOM,'Shells'), GEOM.Shells = []; end
if ~isfield(GEOM,'Tracelines'), GEOM.Tracelines = []; end


if ~isempty(GEOM.Nodes),
   updtgeom(HANDLES.heditgeom(7),GEOM.Nodes);
   set(HANDLES.heditgeom(7),'dataaspectratio',[1 1 1])
   rotate3d on
end


%
%  Initialize the listbox
%

eval(get(HANDLES.heditgeom(3),'callback'))

%
%  Turn on the figure
%

set(HANDLES.heditgeom(1),'visible','on')

return
