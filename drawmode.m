function drawmode(phsdel)
%
%  Name: drawmode
% 
%  Usage: drawmode(phsdel)
% 
%  Description:
%    Draws mode shape
 
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

global MODES VIEWMODES HANDLES GEOM imode

%
%  Clear the axes and draw the undef geom.
%

axes(HANDLES.hviewm(2))
cla

set(HANDLES.hviewm(2),'nextplot','add')

if VIEWMODES.iundef == 1,
   temp1 = GEOM.barlnco;
   temp2 = GEOM.barlnst;
   temp3 = GEOM.nodelnco;
   GEOM.barlnco = GEOM.undefgeomco;
   GEOM.barlnst = ':';
   GEOM.nodelnco = GEOM.undefgeomco;
   
   updtgeom(HANDLES.hviewm(2),GEOM.Nodes);
   
   GEOM.barlnco = temp1;
   GEOM.barlnst = temp2;
   GEOM.nodelnco = temp3;
end


%  Select either complex or real mode shape 

switch VIEWMODES.ipltcmplx
case 'Real'
   Phi = MODES.modalvector{imode};
   nscale = VIEWMODES.realscale{imode};
case 'Complex'
   Phi = MODES.residue{imode};
   nscale = VIEWMODES.complexscale{imode};
end

%  display the appropriate scaling factor in viewmodes window

set(HANDLES.hviewm(6),'string',sprintf('%6.3e',nscale))

%
%  Determine 'Nodes' for displaced geometry
%

Nodes_def = GEOM.Nodes;

%
%  Loop over each entry in respDOF
%

for i = 1:size(MODES.respDOF,1),

%
%   Pull out the location, dir. magnitude, and dir. sign
%

    nloc = MODES.respDOF(i,1);
    ndirmag = abs(MODES.respDOF(i,2));
    ndirsign = sign(MODES.respDOF(i,2));

%
%   Find the Node which has this location
%

    rnode = find(GEOM.Nodes(:,1) == nloc);

%
%   Make the appropriate change to this Node's Location
%

    Nodes_def(rnode,ndirmag+1) =  GEOM.Nodes(rnode,ndirmag+1) + abs(Phi(i))*nscale*ndirsign*cos(phsdel+angle(Phi(i))-angle(Phi(1)));

end

%
%   Draw the deformed geometry
%

updtgeom(HANDLES.hviewm(2),Nodes_def)

return
