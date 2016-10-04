%
%  Name:   flexanal
%
%  Usage:  flexanal
%
%  Starts up the flexibility analysis window
% 

%  Version SWD970108
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

onHndlVector=handact(onHndlVector,hndlMatrix,8);

iopDOF =1 ; % Default to respDOF

idamugeom = get(hdamtl(14),'value');
ndamplttp = get(hdamtl(13),'value');
icontlab = get(hdamtl(15),'value');

haxes = onHndlVector(2);

%
% Turn off the display tools button
%

set(onHndlVector(11),'visible','off')
